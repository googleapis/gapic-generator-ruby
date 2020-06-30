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

load("@com_google_api_codegen//rules_gapic:gapic.bzl", "proto_custom_library", "GapicInfo")

def _ruby_gapic_library_add_gapicinfo_impl(ctx):
  return [
    DefaultInfo(files = depset(direct = [ctx.file.output])),
    GapicInfo(),
  ]

_ruby_gapic_library_add_gapicinfo = rule(
  _ruby_gapic_library_add_gapicinfo_impl,
  attrs = {
    "output": attr.label(allow_single_file = True)
  }
)

def ruby_gapic_library(name, srcs, yml_file_labels,  **kwargs):
  srcjar_target_name = name
  srcjar_output_suffix = ".srcjar"

  name_srcjar = "{name}_srcjar".format(name = name)

  opt_yml_files = {}
  for file_label in yml_file_labels:
    opt_yml_files[file_label] = "configuration"

  proto_custom_library(
    name = name_srcjar,
    deps = srcs,
    plugin = Label("@com_googleapis_gapic_generator_ruby//rules_ruby_gapic:gapic_generator_ruby"),
    opt_file_args = opt_yml_files,
    output_type = "ruby_gapic",
    output_suffix = srcjar_output_suffix,
    **kwargs
  )
  _ruby_gapic_library_add_gapicinfo(
    name = name,
    output = ":{name_srcjar}".format(name_srcjar = name_srcjar),
  )

def ruby_proto_library(name, deps, **kwargs):
  # Build zip file of protoc output
  proto_custom_library(
    name = name,
    deps = deps,
    output_type = "ruby",
    output_suffix = ".srcjar",
    **kwargs
  )

def ruby_grpc_library(name, srcs, deps, **kwargs):
  # Build zip file of grpc output
  proto_custom_library(
    name = name,
    deps = srcs,
    plugin = Label("@com_github_grpc_grpc//src/compiler:grpc_ruby_plugin"),
    output_type = "grpc",
    output_suffix = ".srcjar",
    **kwargs
  )

def ruby_gapic_ads_library(name, srcs, yml_file_labels, **kwargs):
  srcjar_target_name = name
  srcjar_output_suffix = ".srcjar"

  name_srcjar = "{name}_srcjar".format(name = name)

  opt_yml_files = {}
  for file_label in yml_file_labels:
    opt_yml_files[file_label] = "configuration"

  proto_custom_library(
    name = name_srcjar,
    deps = srcs,
    plugin = Label("@com_googleapis_gapic_generator_ruby//rules_ruby_gapic:gapic_generator_ads"),
    opt_file_args = opt_yml_files,
    output_type = "ruby_gapic",
    output_suffix = srcjar_output_suffix,
    **kwargs
  )
  _ruby_gapic_library_add_gapicinfo(
    name = name,
    output = ":{name_srcjar}".format(name_srcjar = name_srcjar),
  )