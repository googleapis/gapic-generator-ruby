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
# A shell script used by the bundle_install rule to run the bundle installer and then
# delete known files and folders with the spaces in their names https://github.com/bazelbuild/bazel/issues/4327
#

# Immediately exit if any command fails.
set -e
"{bundle}" install
find export -name "patch 1.diff" -delete
find export -type d -name "test mini portile-1.0.0" | while read f ; do rm -rf "$f" ; done
