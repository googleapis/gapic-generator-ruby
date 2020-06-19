#!/bin/bash

# Copyright [yyyy] [name of copyright owner]
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

# enable extended globbing for flag pattern matching
shopt -s extglob

# Parse out options.
while true; do
  case "$1" in
    --ruby-my_plugin* ) echo "Skipping unrecognized ruby-my_plugin flag: $1" >&2; shift ;;
    --* | +([[:word:][:punct:]]) ) shift ;;
    * ) break ;;
  esac
done

mkdir -p /workspace/out/lib
exec grpc_tools_ruby_protoc \
        --experimental_allow_proto3_optional=1 \
        --proto_path=/workspace/common-protos/ --proto_path=/workspace/in/ \
        --ruby_out=/workspace/out/lib \
        --grpc_out=/workspace/out/lib \
        --ruby_my_plugin_out=/workspace/out/ \
        --ruby_my_plugin_opt="configuration=/workspace/config.yml" \
        `find /workspace/in/ -name *.proto`
