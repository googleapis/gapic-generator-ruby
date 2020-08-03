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
Builds ruby runtime context and the ruby standard libraries context
from the ruby runtime.
It's a bit convoluted since ruby runtime is a repo rule, so
the path goes ruby_runtime -> WORKSPACE -> ruby_context
"""
load("//rules_ruby_gapic:private/providers.bzl", "RubyRuntimeInfo", "RubyLibraryInfo")

##
# An implementation of the ruby_context rule
#
def _ruby_context_impl(ctx):
  ruby_bin = ctx.file.ruby_bin
  gem_bin = ctx.file.gem_bin
  bundle_bin = ctx.file.bundle_bin
  all_bins = ctx.files.all_bins
  ruby_libfiles = ctx.files.ruby_libfiles
  lib_root = ctx.files.ruby_libroots[0]

  return [
    DefaultInfo(files = depset(ruby_libfiles)),
    RubyRuntimeInfo(
      info = struct(
        srcs = ruby_libfiles,
        lib_path = lib_root,
      ),
      bin = ruby_bin,
      gem_bin = gem_bin,
      bundle_bin = bundle_bin,
      all_bins = all_bins,
    ),
    RubyLibraryInfo(
      info = struct(
        srcs = ruby_libfiles,
        lib_path = lib_root,
        ext_path = None,
      ),
      deps = depset(),
    ),
  ]

##
# Builds ruby runtime context and the ruby standard libraries context
# from the ruby runtime decoupling the ruby runtime usage
# from the details of ruby_runtime repo rule implementation
# 
# ruby_bin: a label to the ruby binary (bin/ruby)
# all_bins: a list of labels to all the ruby binaries (gem, rubocop, etc)
# ruby_libfiles: all files that are part of the ruby standard libraries
# ruby_libroots: a set of files pointing to the directories that have to be
# passed via -I to ruby invocations so that the ruby standard libraries can be used
#
ruby_context = rule(
  _ruby_context_impl,
  attrs = {
    "ruby_bin": attr.label(
      allow_single_file = True,
      executable = True,
      cfg = "host"
    ),
    "gem_bin": attr.label(
      allow_single_file = True,
      executable = True,
      cfg = "host"
    ),
    "bundle_bin": attr.label(
      allow_single_file = True,
      executable = True,
      cfg = "host"
    ),
    "all_bins": attr.label(),
    "ruby_libfiles": attr.label(),
    "ruby_libroots": attr.label(),
  }
)
