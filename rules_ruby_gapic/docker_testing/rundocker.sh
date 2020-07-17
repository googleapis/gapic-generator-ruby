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

# A script that builds and runs an image that showcases bazel rules for gapic-generator-ruby

rm -rf bazel-*
docker build -t gapic-generator-ruby-bazel -f rules_ruby_gapic/docker_testing/Dockerfile . && \
docker run -it --rm \
--mount type=bind,source="$(pwd)",target='/src/gapic-generator-ruby' \
gapic-generator-ruby-bazel
/bin/bash