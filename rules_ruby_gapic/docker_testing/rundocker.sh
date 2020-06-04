#!/bin/bash
rm -rf bazel-*
docker build -t gapic-generator-ruby-bazel -f rules_ruby_gapic/docker_testing/Dockerfile . && \
docker run -it --rm \
--mount type=bind,source="$(pwd)",target='/src/gapic-generator-ruby' \
gapic-generator-ruby-bazel
