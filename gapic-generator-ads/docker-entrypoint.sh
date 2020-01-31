#!/bin/bash
# Copyright 2019 Google LLC
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
set -euxo pipefail

# Parse out options.
#while true; do
#  case "$1" in
#    --ruby-ads* ) echo "Skipping unrecognized ruby-ads flag: $1" >&2; shift ;;
#    --* | +([[:word:][:punct:]]) ) shift ;;
#    * ) break ;;
#  esac
#done

export RUBY_VM_THREAD_VM_STACK_SIZE=8000000
export RUBY_VM_THREAD_VM_STACK_SIZE_MIN=4000000

mkdir -p /workspace/out/lib

grpc_tools_ruby_protoc \
  --proto_path=/workspace/common-protos/ --proto_path=/workspace/in/ \
  --ruby_out=/workspace/out/lib \
  --grpc_out=/workspace/out/lib \
  --ruby_ads_out=/workspace/out/ \
  --ruby_ads_opt="configuration=/workspace/config.yml" \
  `find /workspace/in/ -name *.proto`

# Fix file paths
# Ensure google_ads exists
mkdir -p /workspace/out/lib/google/ads/google_ads
# Copy all googleads files to google_ads
cp -r /workspace/out/lib/google/ads/googleads/* /workspace/out/lib/google/ads/google_ads
# Remove googleads directory
rm -rf /workspace/out/lib/google/ads/googleads

# Fix requires
# Fix require with double quote
find /workspace/out/lib/google/ads -name "*.rb" -type f -exec sed -i -e 's/require "google\/ads\/googleads/require "google\/ads\/google_ads/g' {} \;
# Fix require with single quote
find /workspace/out/lib/google/ads -name "*.rb" -type f -exec sed -i -e "s/require 'google\/ads\/googleads/require 'google\/ads\/google_ads/g" {} \;

# Fix the protoc-gen-grpc output not respecting ruby_package:
# See https://github.com/grpc/grpc/issues/19438
find /workspace/out/lib/google/ads -name "*.rb" -type f -exec sed -i -e 's/Google::Ads::Googleads::/Google::Ads::GoogleAds::/g' {} \;
find /workspace/out -type f | xargs -n 1 -I{} chmod 644 {}
find /workspace/out -type d | xargs -n 1 -I{} chmod 755 {}
