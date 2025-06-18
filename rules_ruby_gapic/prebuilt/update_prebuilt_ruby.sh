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

if [[ -z "${GOOGLEAPIS_IMAGE}" ]]
then
  echo "GOOGLEAPIS_IMAGE not set, defaulting to gcr.io/gapic-images/googleapis:prod"
  GOOGLEAPIS_IMAGE="gcr.io/gapic-images/googleapis:prod"
fi

branch="update-binary-`date +%Y%m%dT%H%M%S`"
sourceRoot=$(git rev-parse --show-toplevel)
echo "sourceRoot: ${sourceRoot}"

docker run --rm \
  --volume "${sourceRoot}":/workspace \
  --workdir "/workspace" \
  --entrypoint "/workspace/rules_ruby_gapic/prebuilt/prebuild.sh" \
  "${GOOGLEAPIS_IMAGE}"

git checkout -b "${branch}"
rm -rf rules_ruby_gapic/prebuilt/ruby-*.tar.gz
cp output/ruby-*.tar.gz  rules_ruby_gapic/prebuilt
git add rules_ruby_gapic/prebuilt/
git commit -m "fix: update Ruby prebuilt binary"
echo "Pushing Ruby branch to GitHub..."
git push --set-upstream origin "${branch}"

echo "Please create pull requests:"
echo "  https://github.com/googleapis/gapic-generator-ruby/pull/new/${branch}"
