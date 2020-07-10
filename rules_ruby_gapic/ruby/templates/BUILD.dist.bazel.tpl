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

"""
A BUILD.bazel file of the ruby_runtime workspace defining the targets for the rules consuming
the ruby runtime, first and foremost the ruby_context rule
"""
load(":copy_ruby_runtime.bzl", "copy_ruby_runtime")

# export every relevant file
exports_files(glob(include = ["{srcs_dir}/bin/**", "bin/*", "lib/**"], exclude_directories = 0))

##
# A filegroup for all the ruby binaries
#
filegroup(
  name = "ruby_bins_allfiles",
  srcs = glob([
    "bin/**/*"
  ]),
  visibility = ["//visibility:public"],
)

##
# A filegroup for all the files of ruby standard libraries
#
filegroup(
  name = "ruby_libs_allfiles",
  srcs = glob([
    "lib/**/*"
  ]),
  visibility = ["//visibility:public"],
)

##
# A filegroup for the set of files pointing to the directories that have to be 
# passed via -I to ruby invocations so that the ruby standard libraries can be used
#
filegroup(
  name = "ruby_libroots",
  srcs = glob([
    "lib/**/.ruby_bazel_libroot",
  ]),
  visibility = ["//visibility:public"],
)

copy_ruby_runtime(
  name = "copy_ruby_runtime",
  visibility = ["//visibility:public"],
)
