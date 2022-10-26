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
load("@rules_gapic//:gapic.bzl", "proto_custom_library")

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# extra_protoc_parameters: a list of the generator parameters in the form of "key=value" strings
#   (e.g. gem-name=a-gem-name-v1)
# yml_configs: a list of labels of the yaml configs (or an empty list)
# grpc_service_config: a label to the grpc service config
# service_yaml: a label to the service yaml
# rest_numeric_enums: set to True to enable numeric enums for REST clients
#
def ruby_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  yml_configs = [],
  grpc_service_config = None,
  service_yaml = None,
  rest_numeric_enums = None,
  **kwargs):
  
  _ruby_gapic_library_internal(
    name,
    srcs,
    Label("//rules_ruby_gapic/gapic-generator:gapic_generator_ruby"),
    extra_protoc_parameters,
    yml_configs,
    grpc_service_config,
    service_yaml,
    rest_numeric_enums
  )

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator-cloud entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# ruby_cloud_title: cloud gem's title. 
#   It is separated from the extra_protoc_parameters because of issues with build_gen: https://github.com/googleapis/gapic-generator-ruby/issues/539
# ruby_cloud_description: cloud gem's description. 
#   It is separated from the extra_protoc_parameters because of issues with build_gen: https://github.com/googleapis/gapic-generator-ruby/issues/539
# extra_protoc_parameters: a list of the generator parameters in the form of "key=value" strings
#   (e.g. ruby-cloud-gem-name=google-cloud-gem-name-v1)
# grpc_service_config: a label to the grpc service config
# service_yaml: a label to the service yaml
# rest_numeric_enums: set to True to enable numeric enums for REST clients
#
def ruby_cloud_gapic_library(
  name,
  srcs,
  ruby_cloud_title = "",
  ruby_cloud_description = "",
  extra_protoc_parameters = [],
  grpc_service_config = None,
  service_yaml = None,
  rest_numeric_enums = None,
  **kwargs):
  
  if extra_protoc_parameters:
    for key_val_string in extra_protoc_parameters:
        key_val_split = key_val_string.split("=", 1)
        if len(key_val_split) < 2:
            fail("Parameter '{key_val_string}' is not in the 'key=value' format".format(key_val_string=key_val_string))
        key = key_val_split[0].strip()
        if key == "ruby-cloud-title":
          fail("Parameter 'ruby-cloud-title' should be specified in a separate Bazel rule attribute 'ruby_cloud_title'")
        if key == "ruby-cloud-description":
          fail("Parameter 'ruby-cloud-description' should be specified in a separate Bazel rule attribute 'ruby_cloud_description'")
  
  if ruby_cloud_title:
    extra_protoc_parameters.append("ruby-cloud-title={value}".format(value = ruby_cloud_title))
  
  if ruby_cloud_description:
    extra_protoc_parameters.append("ruby-cloud-description={value}".format(value = ruby_cloud_description))
  
  # Add the cloud form of the generator parameter here. We then pass None to
  # _ruby_gapic_library_internal so that it doesn't also add the generic form
  # of the parameter.
  if rest_numeric_enums:
    extra_protoc_parameters.append("ruby-cloud-rest-numeric-enums=true")

  _ruby_gapic_library_internal(
    name,
    srcs,
    Label("//rules_ruby_gapic/gapic-generator-cloud:gapic_generator_cloud"),
    extra_protoc_parameters,
    [],
    grpc_service_config,
    service_yaml,
    None
  )

##
# A macro over the proto_custom_library that generates a library
# using the gapic-generator-ads entrypoint
#
# name: name of the rule
# srcs: proto files wrapped in the proto_library rule
# extra_protoc_parameters: a list of the generator parameters in the form of "key=value" strings
#   (e.g. gem-name=google-ads-googleads)
# grpc_service_config: a label to the grpc service config
# service_yaml: a label to the service yaml
# rest_numeric_enums: set to True to enable numeric enums for REST clients
#
def ruby_ads_gapic_library(
  name,
  srcs,
  extra_protoc_parameters = [],
  grpc_service_config = None,
  service_yaml = None,
  rest_numeric_enums = None,
  **kwargs):
  
  _ruby_gapic_library_internal(
    name,
    srcs,
    Label("//rules_ruby_gapic/gapic-generator-ads:gapic_generator_ads"),
    extra_protoc_parameters,
    [],
    grpc_service_config,
    service_yaml,
    rest_numeric_enums
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
