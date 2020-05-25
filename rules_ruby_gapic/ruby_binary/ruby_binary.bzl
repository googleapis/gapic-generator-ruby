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
Defines a rule that wraps a ruby application into a shellscript, executable by bazel
"""
load("//rules_ruby_gapic:private/providers.bzl", "RubyLibraryInfo", "RubyContext")

##
# An implementation for ruby_binary rule
#
def _ruby_binary_impl(ctx):
  src_base_path = ctx.file.src_base.path

  # the shellscript file that calls the ruby application
  run_result_file_path = "{name}".format(name = ctx.label.name)
  run_result_file = ctx.actions.declare_file(run_result_file_path)

  # entrypoint for our Ruby application
  entrypoint_dir = ctx.file.entrypoint.dirname
  entrypoint_path = ctx.file.entrypoint.path

  # Grabbing the RubyContext and extracting the binary from it
  ruby_context = ctx.attr.ruby_context[RubyContext]
  ruby_bin = ruby_context.bin
  ruby_bin_path = ruby_bin.path
  ruby_bin_dirpath = ruby_bin.dirname
  ruby_all_bins = ruby_context.all_bins

  # Same dependency also contains the Ruby StandardLibrary info packaged as RubyLibraryInfo
  ruby_standard_lib = ctx.attr.ruby_context[RubyLibraryInfo]

  # All dependencies combined form the depset
  deps = [ruby_standard_lib] + [dep[RubyLibraryInfo] for dep in ctx.attr.deps]
  deps_set = depset(
    direct = [d.info for d in deps],
    transitive = [d.deps for d in deps],
  )

  # From this depset we extract two things:
  # 1. We take all the lib directories and ext directories and add them to the path
  deps_strings = [entrypoint_dir]
  for dep in deps_set.to_list():
    deps_strings.append(dep.lib_path.dirname)
    if dep.ext_path:
      deps_strings.append(dep.ext_path.dirname)

  import_paths_string = "-I " + " -I ".join(deps_strings)

  # 2. all the library files join the program sources in the set of inputs
  all_inputs = ctx.files.srcs[:]
  all_inputs.append(ctx.file.entrypoint)
  for dep in deps_set.to_list():
    all_inputs = all_inputs + dep.srcs  

  # the actual command: a ruby binary invocation of the entrypoint file with the correct imports
  cmd_text = """{ruby_bin} -W0 -I {src_dir} {imports} {entrypoint}""".format(
    src_dir = src_base_path,
    ruby_bin = ruby_bin_path, 
    imports = import_paths_string, 
    entrypoint = entrypoint_path)

  # the command text is prepended by some gapic-generator-ruby requirements:
  # * a path to a folder with the ruby binaries so that gapic-generator-ruby can systemcall rubocop
  # * an XDG_CACHE_HOME env var export so that the rubocop won't frivolously fail
  # * LANG & LANGUAGE env var exports so that the rails templating engine is satisfied
  #
  # then the actual command follows 
  #
  exec_text = "#!/bin/bash{newline}export PATH=$PATH:{ruby_bin_dirpath}{newline}export XDG_CACHE_HOME=/tmp{newline}export LANG=en_US.UTF-8{newline}export LANGUAGE=en_US:en{newline}{cmd_text}{newline}".format(
    newline = "\n",
    cmd_text = cmd_text,
    ruby_bin_dirpath = ruby_bin_dirpath,
  )

  # write the shellscript into the result file
  ctx.actions.write(run_result_file, exec_text)

  # collect everything that can be useful in a result
  direct = ctx.files.srcs[:]
  direct.append(run_result_file)
  direct.append(ruby_bin)
  direct = direct + ruby_all_bins

  # Everything goes into the runfiles since that's how bazel knows to simlink the files around the shellscript file
  runfiles = ctx.runfiles(files=[run_result_file, ruby_bin] + ctx.files.srcs)

  return [DefaultInfo(
    files = depset(direct=direct),
    runfiles = runfiles,
    executable = run_result_file,
  )]

##
# A rule that takes a ruby application and wraps it into a bazel-runnable shellscript
# Defines an executable target 
#
ruby_binary = rule(
  _ruby_binary_impl,
  attrs = {
    "srcs": attr.label_list(allow_files = True),
    "src_base": attr.label(allow_single_file=True),
    "ruby_context": attr.label(default = Label("//rules_ruby_gapic/ruby:ruby_context")),
    "entrypoint": attr.label( allow_single_file = True),
    "deps": attr.label_list(
      providers = [RubyLibraryInfo],
    ),
  },
  executable = True,
)
