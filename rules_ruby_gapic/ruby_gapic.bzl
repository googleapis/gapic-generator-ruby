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
load(
  ":private/ruby_gapic_library_internal.bzl",
  _ruby_gapic_library_internal = "ruby_gapic_library_internal",
)
load("@com_google_api_codegen//rules_gapic:gapic.bzl", "proto_custom_library")

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator entrypoint
#
# name: name of the rule
# generator_params: a string-string dictionary of the generator parameters
#   (e.g. :gem.:name)
# srcs: proto files wrapped in the proto_library rule
# yml_configs: a list of labels of the yaml configs (or an empty list)
# grpc_service_config: a label to the grpc service config
#
def ruby_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  yml_configs = [],
  grpc_service_config = None,
  **kwargs):
  
  _ruby_gapic_library_internal(
    name,
    srcs,
    Label("//rules_ruby_gapic/gapic-generator:gapic_generator_ruby"),
    extra_protoc_parameters,
    yml_configs,
    grpc_service_config
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
def ruby_cloud_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  grpc_service_config = None,
  **kwargs):
  
  _ruby_gapic_library_internal(
    name,
    srcs,
    Label("//rules_ruby_gapic/gapic-generator-cloud:gapic_generator_cloud"),
    extra_protoc_parameters,
    [],
    grpc_service_config
  )

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator-ads entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# extra_protoc_parameters: a 
# grpc_service_config: a label to the grpc service config
#
def ruby_ads_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  grpc_service_config = None,
  **kwargs):
  
  _ruby_gapic_library_internal(
    name,
    srcs,
    Label("//rules_ruby_gapic/gapic-generator-ads:gapic_generator_ads"),
    extra_protoc_parameters,
    [],
    grpc_service_config
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
