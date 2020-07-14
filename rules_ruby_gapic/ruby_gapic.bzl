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
Rules for generating ruby code with protoc
including rules for ruby, grpc-ruby, and various flavors of gapic-generator-ruby
"""
load("@com_google_api_codegen//rules_gapic:gapic.bzl", "proto_custom_library", "GapicInfo")

##
# An implementation of the _ruby_gapic_library_add_gapicinfo
#
def _ruby_gapic_library_add_gapicinfo_impl(ctx):
  return [
    DefaultInfo(files = depset(direct = [ctx.file.output])),
    GapicInfo(),
  ]

##
# A rule that adds the GapicInfo provider to the input
# used to mark the result of the gapic-generator-ruby plugin
# to distinguish it from the output of other plugins (e.g. grpc)
#
_ruby_gapic_library_add_gapicinfo = rule(
  _ruby_gapic_library_add_gapicinfo_impl,
  attrs = {
    "output": attr.label(allow_single_file = True)
  }
)

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator-ads entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# yml_configs: a list of labels of the yaml configs (or an empty list)
#
def ruby_gapic_ads_library(name, srcs, yml_configs, **kwargs):
  srcjar_target_name = name
  srcjar_output_suffix = ".srcjar"

  name_srcjar = "{name}_srcjar".format(name = name)

  opt_yml_files = {}
  for file_label in yml_configs:
    opt_yml_files[file_label] = "configuration"

  proto_custom_library(
    name = name_srcjar,
    deps = srcs,
    plugin = Label("@gapic_generator_ruby//rules_ruby_gapic:gapic_generator_ads"),
    opt_file_args = opt_yml_files,
    output_type = "ruby_gapic",
    output_suffix = srcjar_output_suffix,
    **kwargs
  )
  _ruby_gapic_library_add_gapicinfo(
    name = name,
    output = ":{name_srcjar}".format(name_srcjar = name_srcjar),
  )

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# yml_configs: a list of labels of the yaml configs (or an empty list)
#
def ruby_gapic_library(name, srcs, yml_configs,  **kwargs):
  srcjar_target_name = name
  srcjar_output_suffix = ".srcjar"

  name_srcjar = "{name}_srcjar".format(name = name)

  opt_yml_files = {}
  for file_label in yml_configs:
    opt_yml_files[file_label] = "configuration"

  proto_custom_library(
    name = name_srcjar,
    deps = srcs,
    plugin = Label("@gapic_generator_ruby//rules_ruby_gapic:gapic_generator_ruby"),
    opt_file_args = opt_yml_files,
    output_type = "ruby_gapic",
    output_suffix = srcjar_output_suffix,
    **kwargs
  )
  _ruby_gapic_library_add_gapicinfo(
    name = name,
    output = ":{name_srcjar}".format(name_srcjar = name_srcjar),
  )

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator-cloud entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# ruby_cloud_params a string-string dictionary of the cloud generator parameters
#   (e.g. :gem.:name)
# grpc_service_configs: a list of labels of the grpc service configs (or an empty list)
#
def ruby_gapic_cloud_library(
  name,
  srcs,
  ruby_cloud_params,
  grpc_service_configs,
  **kwargs):

  srcjar_target_name = name
  srcjar_output_suffix = ".srcjar"

  name_srcjar = "{name}_srcjar".format(name = name)

  opt_args = []
  for key, value in ruby_cloud_params.items():
    escaped_value = _escape_config_value(value)
    opt_args.append("{key}={value}".format(key = key, value = escaped_value))

  opt_service_configs = {}
  for file_label in grpc_service_configs:
    opt_service_configs[file_label] = "grpc_service_config"

  proto_custom_library(
    name = name_srcjar,
    deps = srcs,
    plugin = Label("@gapic_generator_ruby//rules_ruby_gapic:gapic_generator_cloud"),
    opt_args = opt_args,
    opt_file_args = opt_service_configs,
    output_type = "ruby_gapic",
    output_suffix = srcjar_output_suffix,
    **kwargs
  )
  _ruby_gapic_library_add_gapicinfo(
    name = name,
    output = ":{name_srcjar}".format(name_srcjar = name_srcjar),
  )

##
# A macro over the proto_custom_library that runs protoc with a ruby plugin
#
# name: name of the rule
# deps: proto files wrapped in the proto_library rule
#
def ruby_proto_library(name, deps, **kwargs):
  # Build zip file of protoc output
  proto_custom_library(
    name = name,
    deps = deps,
    output_type = "ruby",
    output_suffix = ".srcjar",
    **kwargs
  )

##
# A macro over the proto_custom_library that runs protoc with a grpc-ruby plugin
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# deps: a ruby_proto_library output
#
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

##
# Escapes symbols in the config parameters values that would break the command line
# when folded into the --opt_ruby_gapic protoc command line parameter
#
def _escape_config_value(value):
  return value.replace("\\", "\\\\").replace(",", "\\,").replace( "=", "\\=")
