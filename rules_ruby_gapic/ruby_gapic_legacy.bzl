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
Rules for generating ruby code with protoc.
Legacy nonbundler rules for various flavors of gapic-generator-ruby
"""
load(
  ":private/ruby_gapic_library.bzl",
  _ruby_gapic_library = "ruby_gapic_library",
)
##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator entrypoint
#
# Legacy rule not using bundler
#
# name: name of the rule
# generator_params: a string-string dictionary of the generator parameters
#   (e.g. :gem.:name)
# srcs: proto files wrapped in the proto_library rule
# yml_configs: a list of labels of the yaml configs (or an empty list)
# grpc_service_config: a label to the grpc service config
#
def ruby_nonbundler_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  yml_configs = [],
  grpc_service_config = None,
  **kwargs):
  
  _ruby_gapic_library(
    name,
    srcs,
    Label("@gapic_generator_ruby//rules_ruby_gapic/gapic-generator:gapic_generator_ruby_nonbundler"),
    extra_protoc_parameters,
    yml_configs,
    grpc_service_config
  )

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator-cloud entrypoint
#
# Legacy rule not using bundler
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# ruby_cloud_params a string-string dictionary of the cloud generator parameters
#   (e.g. :gem.:name)
# grpc_service_configs: a list of labels of the grpc service configs (or an empty list)
#
def ruby_nonbundler_cloud_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  grpc_service_config = None,
  **kwargs):
  
  _ruby_gapic_library(
    name,
    srcs,
    Label("@gapic_generator_ruby//rules_ruby_gapic/gapic-generator-cloud:gapic_generator_cloud_nonbundler"),
    extra_protoc_parameters,
    [],
    grpc_service_config
  )

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator-ads entrypoint
#
# Legacy rule not using bundler
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# yml_configs: a list of labels of the yaml configs (or an empty list)
# grpc_service_config: a label to the grpc service config
#
def ruby_nonbundler_ads_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  grpc_service_config = None,
  **kwargs):
  
  _ruby_gapic_library(
    name,
    srcs,
    Label("@gapic_generator_ruby//rules_ruby_gapic/gapic-generator-ads:gapic_generator_ads_nonbundler"),
    extra_protoc_parameters,
    [],
    grpc_service_config
  )
