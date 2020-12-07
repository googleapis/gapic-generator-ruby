#!/usr/bin/env bash
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

##
# A shell script used by the ruby_runtime rule to install bundler gem
# GEM_HOME and GEM_PATH should be unset before that operation
#

# Immediately exit if any command fails.
set -e
unset GEM_HOME
unset GEM_PATH
./bin/gem env
./bin/bundler --version

#./bin/gem install -f --no-document bundler:{version}