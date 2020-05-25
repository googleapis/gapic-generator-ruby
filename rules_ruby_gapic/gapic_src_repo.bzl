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
A function that loads gapic-generator-ruby itself as a dependency to build the libraries with
and then strips it from the softlinks so that bazel accepts it
"""
load("//rules_ruby_gapic/ruby:private/utils.bzl", _execute_and_check_result = "execute_and_check_result")

##
# An implementation of gapic_generator_src rule
#
def _gapic_generator_src_impl(ctx):
  ctx.download_and_extract(
    url = "https://github.com/viacheslav-rostovtsev/gapic-generator-ruby/archive/45d1159fe395881ad6e851e4c91bd65a332c9fef.zip",
    stripPrefix = "gapic-generator-ruby-45d1159fe395881ad6e851e4c91bd65a332c9fef",
    #sha256 = "8565fa6d4f18833958d61ba843a00c618715ecf8b820182c4ade9be648803b55",
    output = "gen_src",
  )
  ctx.file(
    "BUILD.bazel",
    """exports_files(glob(include = ["gen_src/**"], exclude_directories = 0))""",
  )
  ctx.execute(["rm", "gen_src/gapic-generator/expected_output"], quiet = False)
  ctx.execute(["rm", "gen_src/gapic-generator/proto_input"], quiet = False)
  ctx.execute(["rm", "gen_src/gapic-generator/protofiles_input"], quiet = False)

  ctx.execute(["rm", "gen_src/gapic-generator-ads/expected_output"], quiet = False)
  ctx.execute(["rm", "gen_src/gapic-generator-ads/proto_input"], quiet = False)

  ctx.execute(["rm", "gen_src/gapic-generator-cloud/expected_output"], quiet = False)
  ctx.execute(["rm", "gen_src/gapic-generator-cloud/proto_input"], quiet = False)

  ctx.execute(["rm", "gen_src/shared/input/proto_input"], quiet = False)
  ctx.execute(["rm", "gen_src/shared/output/gapic/expected_output"], quiet = False)
  ctx.execute(["rm", "gen_src/shared/output/cloud/expected_output"], quiet = False)

##
# A rule to load the gapic-generator-ruby as a dependency to use to build the libraries with
#
gapic_generator_src = repository_rule(
  _gapic_generator_src_impl,
)
