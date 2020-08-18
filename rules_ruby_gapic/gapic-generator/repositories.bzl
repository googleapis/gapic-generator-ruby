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
Defines the function that will load the dependencies for gapic-generator-vanilla
"""
load("//rules_ruby_gapic/ruby:ruby_runtime.bzl", "ruby_runtime")
load("//rules_ruby_gapic/ruby:bundle_install.bzl", "bundle_install")

##
# Creates a ruby runtime specific to gapic-generator-vanilla and 
# a bundled installation for its packages
#
def gapic_generator_repositories():
  # Create the ruby runtime
  ruby_runtime(
    name = "gapic_generator_ruby_runtime",
    urls = ["https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.6.tar.gz"],
    strip_prefix = "ruby-2.6.6",
    prebuilt_rubys = [
      "@gapic_generator_ruby//rules_ruby_gapic:prebuilt/ruby-2.6.6_glinux_x86_64.tar.gz",
    ],
    gemfile_lock = "@gapic_generator_ruby//:gapic-generator/Gemfile.lock",
    gems_to_install = {},
  )

  # Create the bundled installation
  bundle_install(
    name = "bundler_gapic_generator",
    bundle_bin = "@gapic_generator_ruby_runtime//:bin/bundle",
    gemfile = "@gapic_generator_ruby//:gapic-generator/Gemfile",
    gemfile_lock = "@gapic_generator_ruby//:gapic-generator/Gemfile.lock",
    gemfile_srcs = {
      "@gapic_generator_ruby//:gapic-generator/Gemfile":"gapic-generator/Gemfile",
      "@gapic_generator_ruby//:gapic-generator/Gemfile.lock":"gapic-generator/Gemfile.lock",
      "@gapic_generator_ruby//:gapic-generator/gapic-generator.gemspec": "gapic-generator/gapic-generator.gemspec",
      "@gapic_generator_ruby//:gapic-generator/lib/gapic/generator/version.rb": "gapic-generator/lib/gapic/generator/version.rb"
    }
  )
