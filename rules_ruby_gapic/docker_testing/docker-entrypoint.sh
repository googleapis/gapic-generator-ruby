#!/bin/bash

# build our ruby via bazel
bazel build //rules_ruby_gapic/ruby_binary/check:ruby_hellolib_sh
bazel query //rules_ruby_gapic/...