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
Defines functions that will load the dependencies for gapic_generator_ruby
"""
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//rules_ruby_gapic/ruby:ruby_runtime.bzl", "ruby_runtime")
load("//rules_ruby_gapic/ruby:bundle_install.bzl", "bundle_install")
load("//rules_ruby_gapic/gapic-generator:repositories.bzl", "gapic_generator_repositories")
load("//rules_ruby_gapic/gapic-generator-cloud:repositories.bzl", "gapic_generator_cloud_repositories")
load("//rules_ruby_gapic/gapic-generator-ads:repositories.bzl", "gapic_generator_ads_repositories")

##
# Load a set of dependencies with the gems that work with all 3 gapic-generator flavors
#
def gapic_generator_ruby_repositories():
  gapic_generator_ruby_customgems({})

##
# Load a set of dependencies with a set of gems provided by the caller
#
# list_of_gems: a dictionary of gem name -> version strings to be loaded when the ruby_runtime dependency builds
#
def gapic_generator_ruby_customgems(list_of_gems):
  _protobuf_version = "3.13.0"
  _protobuf_version_in_link = "v%s" % _protobuf_version
  _maybe(
    http_archive,
    name = "com_google_protobuf",
    urls = ["https://github.com/protocolbuffers/protobuf/archive/%s.zip" % _protobuf_version_in_link],
    strip_prefix = "protobuf-%s" % _protobuf_version,
  )

  _maybe(
    http_archive,
    name = "bazel_skylib",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/2169ae1c374aab4a09aa90e65efe1a3aad4e279b.tar.gz"],
    strip_prefix = "bazel-skylib-2169ae1c374aab4a09aa90e65efe1a3aad4e279b",
  )

  _rules_gapic_version = "0.5.4"
  _maybe(
    http_archive,
    name = "rules_gapic",
    strip_prefix = "rules_gapic-%s" % _rules_gapic_version,
    urls = ["https://github.com/googleapis/rules_gapic/archive/v%s.tar.gz" % _rules_gapic_version],
  )

  _rules_gapic_version = "0.5.4"
  _maybe(
    http_archive,
    name = "rules_gapic",
    strip_prefix = "rules_gapic-%s" % _rules_gapic_version,
    urls = ["https://github.com/googleapis/rules_gapic/archive/v%s.tar.gz" % _rules_gapic_version],
   )

  # Create the common ruby runtime used for checks
  ruby_runtime(
    name = "ruby_runtime",
    urls = ["https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.6.tar.gz"],
    strip_prefix = "ruby-2.6.6",
    prebuilt_rubys = [
      "@gapic_generator_ruby//rules_ruby_gapic:prebuilt/ruby-2.6.6_glinux_x86_64.tar.gz",
    ],
    bundler_version_to_install = "2.1.4",
    gems_to_install = list_of_gems,
  )

  # a bundled isntallation for the bundler rainbow test
  bundle_install(
    name = "bundler_rainbow_test",
    bundle_bin = "@ruby_runtime//:bin/bundle",
    gemfile = "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:rainbow_bundler_test/Gemfile",
    gemfile_lock = "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:rainbow_bundler_test/Gemfile.lock",
    gemfile_srcs = {
      "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:rainbow_bundler_test/Gemfile" : "Gemfile",
      "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:rainbow_bundler_test/Gemfile.lock": "Gemfile.lock",
      "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:rainbow_bundler_test/lib/version.rb" : "lib/version.rb"
    }
  )
  
  # a bundled isntallation for the bundler rainbow-rubocop test
  bundle_install(
    name = "bundler_rubocop_test",
    bundle_bin = "@ruby_runtime//:bin/bundle",
    gemfile = "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:syscall_rubocop_bundler_test/Gemfile",
    gemfile_lock = "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:syscall_rubocop_bundler_test/Gemfile.lock",
    gemfile_srcs = {
      "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:syscall_rubocop_bundler_test/Gemfile" : "Gemfile",
      "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:syscall_rubocop_bundler_test/Gemfile.lock" : "Gemfile.lock",
      "@gapic_generator_ruby//rules_ruby_gapic/ruby_binary/test:syscall_rubocop_bundler_test/lib/version.rb" : "lib/version.rb"
    }
  )

  # gapic-generator-vanilla dependencies
  gapic_generator_repositories()

  # gapic-generator-cloud dependencies
  gapic_generator_cloud_repositories()

  # gapic-generator-ads dependencies
  gapic_generator_ads_repositories()

##
# a helper macro to load a repo rule with an optional prefix
#
def _maybe(repo_rule, name, strip_repo_prefix = "", **kwargs):
  if not name.startswith(strip_repo_prefix):
    return
  repo_name = name[len(strip_repo_prefix):]
  if repo_name in native.existing_rules():
    return
  repo_rule(name = repo_name, **kwargs)
