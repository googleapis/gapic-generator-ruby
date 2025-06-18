#!/bin/bash
# Copyright 2025 Google LLC
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

set -eo pipefail

env
pwd
bazel --version

mkdir -p output
OUTPUT_DIR=$(realpath output)

bazel build //rules_ruby_gapic/gapic-generator:gapic_generator_bundled_context

RUBY_DIRECTORY=$(ls -d "${HOME}"/.cache/bazel/*/*/external/gapic_generator_ruby_runtime)
RUBY_VERSION=$(echo 'puts RUBY_VERSION' | "${RUBY_DIRECTORY}/bin/ruby")
echo "Ruby version: $RUBY_VERSION, packing..."
RUBY_ARCHIVE_DIR="ruby-$RUBY_VERSION"
RUBY_TARBALL_FILENAME="ruby-${RUBY_VERSION}_glinux_x86_64.tar.gz"
mkdir -p "$RUBY_ARCHIVE_DIR"
cp -r "$RUBY_DIRECTORY"/bin "$RUBY_DIRECTORY"/include "$RUBY_DIRECTORY"/lib "$RUBY_ARCHIVE_DIR"
tar cfz "${OUTPUT_DIR}/${RUBY_TARBALL_FILENAME}" "$RUBY_ARCHIVE_DIR"
echo "Done: $RUBY_TARBALL_FILENAME"
ls -alh "${OUTPUT_DIR}/${RUBY_TARBALL_FILENAME}"
