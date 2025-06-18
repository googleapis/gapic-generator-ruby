#!/bin/bash

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
