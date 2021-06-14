# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
A rule for packaging the ruby gapic library
"""
load("@com_google_api_codegen//rules_gapic:gapic.bzl", "GapicInfo", "CustomProtoInfo")
load("@rules_proto//proto:defs.bzl", "ProtoInfo")

def _ruby_gapic_assembly_pkg_impl(ctx):
  out_dir = ctx.actions.declare_directory(ctx.attr.package_dir)
  out_tar = ctx.actions.declare_file("{dir}.tar.gz".format(dir = ctx.attr.package_dir))
  gapic_zip = None
  extras = []
  for dep in ctx.attr.deps:
      #ProtoInfo/CustomProtoInfo delineate proto plugin/grpc plugin results -- they need to go into /lib subfolder
      if ProtoInfo in dep or CustomProtoInfo in dep:
          extras = extras + dep.files.to_list()
      else:
          gapic_zip = dep.files.to_list()[0]

  ctx.actions.run_shell(
    inputs = [gapic_zip] + extras,
    outputs = [out_dir, out_tar],
    tools = [],
    command = """
unzip -q {gapic_zip} -d {out_dir}
for extra in {extras}; do
  unzip -q $extra -d {out_dir}/lib
done
tar -czhpf {out_tar} -C {out_dir}/.. {pkg_name}
    """.format(
      gapic_zip = gapic_zip.path,
      extras = " ".join(["'%s'" % f.path for f in extras]),
      out_dir = out_dir.path,
      out_tar = out_tar.path,
      pkg_name = ctx.attr.name,
    )
  )
  return [DefaultInfo(
    files = depset(direct = [out_tar])
  )]

##
# A rule that is used to package together the outputs from gapic-generator-ruby,
# ruby, and grpc-ruby protoc plugins. Moves the files from the last two plugins 
# into the lib/ folder of the first one.
#
_ruby_gapic_assembly_pkg = rule(
  implementation = _ruby_gapic_assembly_pkg_impl,
  attrs = {
    "deps": attr.label_list(mandatory = True, allow_files = True),
    "package_dir": attr.string(mandatory = True),
  }
)

##
# A macro over the _ruby_gapic_assembly_pkg making sure that name and package_dir are the same
#
def ruby_gapic_assembly_pkg(name, deps, **kwargs):
  _ruby_gapic_assembly_pkg(
    name = name,
    deps = deps,
    package_dir = name,
    **kwargs
  )
