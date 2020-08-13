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
Builds a context for the bundled installation from the repo rule
"""
load("//rules_ruby_gapic:private/providers.bzl", "BundledInstallInfo")

##
# An implementation of the bundled_install_context rule
#
def _bundled_install_context_impl(ctx):
  gemfile = ctx.file.gemfile
  all_bundled_files = ctx.files.all_bundled_files

  return [
    DefaultInfo(files = depset(all_bundled_files)),
    BundledInstallInfo(
      gemfile = gemfile,
      all_bundled_files = all_bundled_files,
    ),
  ]

bundled_install_context = rule(
  _bundled_install_context_impl,
  attrs = {
    "gemfile": attr.label(
      allow_single_file = True,
    ),
    "all_bundled_files": attr.label(),
  }
)
