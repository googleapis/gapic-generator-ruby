#!/bin/bash

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

# A script demonstrating how to pack a ruby_runtime prebuild
VERSION="3.1.3"

mkdir -p /tmp/pack_prebuilt_ruby/ruby-${VERSION}
rm -rf /tmp/pack_prebuilt_ruby/ruby-${VERSION}/*

pushd /tmp/pack_prebuilt_ruby/
cp -r ~/src/gapic-generator-ruby/bazel-gapic-generator-ruby/external/ruby_runtime/* ./ruby-${VERSION}/

# alternative location -- from the bazel_example sub-workspace
# cp -r ~/src/gapic-generator-ruby/bazel_example/bazel-bazel_example/external/ruby_runtime/* ./ruby-${VERSION}/

tar -czf ruby-${VERSION}_linux_x86_64.tar.gz ruby-${VERSION}/bin ruby-${VERSION}/lib ruby-${VERSION}/include
cp ./ruby-${VERSION}_linux_x86_64.tar.gz ~/src/gapic-generator-ruby/rules_ruby_gapic/prebuilt/
popd
