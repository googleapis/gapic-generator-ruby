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
Macros wrapping protoc-library for ruby_gapic_library set of rules
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
# using the provided entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# plugin: a label to the ruby_binary rule wrapping the plugin entrypoint
# generator_params: a string-string dictionary of the generator parameters
#   (e.g. :gem.:name)
# yml_configs: a list of labels of the yaml configs (or an empty list)
# grpc_service_config: a label to the grpc service config
#
def ruby_gapic_library(
  name,
  srcs,
  plugin,
  extra_protoc_parameters,
  yml_configs,
  grpc_service_config,
  **kwargs):

  srcjar_target_name = name
  srcjar_output_suffix = ".srcjar"

  name_srcjar = "{name}_srcjar".format(name = name)

  opt_args = []
  if extra_protoc_parameters:
    for key_val_string in extra_protoc_parameters:
      key_boundary = key_val_string.find('=') # finds the first occurence
      if key_boundary <= 0 or key_boundary == len(key_val_string)-1:
        fail("Parameter {key_val_string} is not in the 'key=value' format")
      # reminder that the substr format is [startPos:length] and not [startPos:endPos]
      key = key_val_string[:key_boundary]
      value = key_val_string[key_boundary+1:]

      escaped_value = _escape_config_value(value)
      opt_args.append("{key}={value}".format(key = key, value = escaped_value))

  opt_file_args = {}
  if grpc_service_config:
    opt_file_args[grpc_service_config] = "grpc_service_config"

  if yml_configs:
    for file_label in yml_configs:
      opt_file_args[file_label] = "configuration"

  proto_custom_library(
    name = name_srcjar,
    deps = srcs,
    plugin = plugin,
    opt_args = opt_args,
    opt_file_args = opt_file_args,
    output_type = "ruby_gapic",
    output_suffix = srcjar_output_suffix,
    **kwargs
  )
  _ruby_gapic_library_add_gapicinfo(
    name = name,
    output = ":{name_srcjar}".format(name_srcjar = name_srcjar),
  )

##
# Escapes symbols in the config parameters values that would break the command line
# when folded into the --opt_ruby_gapic protoc command line parameter
#
def _escape_config_value(value):
  return value.replace("\\", "\\\\").replace(",", "\\,").replace( "=", "\\=")
