#!/bin/bash

if [[ -z "${GOOGLEAPIS_IMAGE}" ]]
then
  echo "GOOGLEAPIS_IMAGE not set, defaulting to gcr.io/gapic-images/googleapis:prod"
  GOOGLEAPIS_IMAGE=" gcr.io/gapic-images/googleapis:prod"
fi

sourceRoot=$(git rev-parse --show-toplevel)
echo "sourceRoot: ${sourceRoot}"

docker run --rm \
  --volume "${sourceRoot}":/workspace \
  --workdir "/workspace" \
  --entrypoint "/workspace/rules_ruby_gapic/prebuild.sh"
