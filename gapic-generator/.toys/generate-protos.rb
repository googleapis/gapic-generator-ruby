# frozen_string_literal: true

# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include :gems
include :exec, e: true

def run
  gem "grpc-tools", "~> 1.57"
  exec [
    "grpc_tools_ruby_protoc",
    "--ruby_out=lib",
    "-I", "./protos",
    "google/protobuf/compiler/plugin.proto",
    "google/cloud/tools/snippetgen/configlanguage/v1/snippet_config_language.proto",
    "google/cloud/tools/snippetgen/snippetindex/v1/snippet_index.proto",
  ]
end
