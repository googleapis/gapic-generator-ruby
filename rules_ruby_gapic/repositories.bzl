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
load("//rules_ruby_gapic:gapic_src_repo.bzl", "gapic_generator_src")
load ("//rules_ruby_gapic/ruby:ruby_runtime.bzl", "ruby_runtime")

def gapic_generator_ruby_repositories():
  gems = {
    "mini_portile2": "2.4.0", # mini_portile for nokogiri needs and before nokogiri
    "nokogiri": "1.10.9",
    "actionpack": "5.2.4.2",
    "actionview": "5.2.4.2",
    "activesupport": "5.2.4.2",
    "addressable": "2.7.0",
    "ast": "2.4.0",
    "builder": "3.2.4",
    "concurrent-ruby": "1.1.6",
    "crass": "1.0.6",
    "erubi": "1.9.0",
    "faraday": "1.0.0",
    "gapic-generator": "0.6.3",
    "googleapis-common-protos": "1.3.9",
    "googleapis-common-protos-types": "1.0.4",
    "googleauth": "0.11.0",
    #"google-protobuf": "3.11.4",
    "google-style": "1.24.0",
    #"grpc": "1.27.0",
    "i18n": "1.8.2",
    "jaro_winkler": "1.5.4",
    "jwt": "2.2.1",
    "loofah": "2.5.0",
    "memoist": "0.16.2",
    "middleware": "0.1.0",
    "minitest": "5.14.0",
    "multi_json": "1.14.1",
    "multipart-post": "2.1.1",
    "os": "1.0.1",
    "parallel": "1.19.1",
    "parser": "2.7.1.1",
    "protobuf": "3.10.3",
    "public_suffix": "4.0.3",
    "rack": "2.2.2",
    "rack-test": "1.1.0",
    "rails-dom-testing": "2.0.3",
    "rails-html-sanitizer": "1.3.0",
    "rainbow": "3.0.0",
    "rake": "12.3.3",
    "rubocop": "0.74.0",
    "ruby-progressbar": "1.10.1",
    "signet": "0.13.0",
    "thor": "1.0.1",
    "thread_safe": "0.3.6",
    "tzinfo": "1.2.7",
    "unicode-display_width": "1.6.1",
  }
  gapic_generator_ruby_customgems(gems)

def gapic_generator_ruby_customgems(list_of_gems):
  _protobuf_version = "3.11.2"
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

  _maybe(
    http_archive,
    name = "com_google_api_codegen",
    strip_prefix = "gapic-generator-2.4.0",
    urls = ["https://github.com/googleapis/gapic-generator/archive/v2.4.0.zip"],
  )

  _maybe(
    gapic_generator_src,
    name = "gapic_generator_src",
  )

  # Create the ruby runtime
  ruby_runtime (
    name = "ruby_runtime",
    urls = ["https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.6.tar.gz"],
    strip_prefix = "ruby-2.6.6",
    prebuilt_rubys = [
      "@gapic_generator_ruby//rules_ruby_gapic:prebuilt/ruby-2.6.6_linux_kokoro_x86_64.tar.gz",
      "@gapic_generator_ruby//rules_ruby_gapic:prebuilt/ruby-2.6.6_glinux_x86_64.tar.gz",
    ],
    gems_to_install = list_of_gems,
  )

def _maybe(repo_rule, name, strip_repo_prefix = "", **kwargs):
  if not name.startswith(strip_repo_prefix):
    return
  repo_name = name[len(strip_repo_prefix):]
  if repo_name in native.existing_rules():
    return
  repo_rule(name = repo_name, **kwargs)
