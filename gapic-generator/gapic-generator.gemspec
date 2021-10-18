# frozen_string_literal: true

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

lib = File.expand_path "lib", __dir__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require "gapic/generator/version"

Gem::Specification.new do |spec|
  spec.name          = "gapic-generator"
  spec.version       = Gapic::Generator::VERSION
  spec.authors       = ["Ernest Landrito", "Chris Smith", "Mike Moore"]
  spec.email         = ["landrito@google.com", "quartzmo@gmail.com",
                        "mike@blowmage.com"]
  spec.licenses      = ["Apache-2.0"]

  spec.summary       = "An API Client Generator for Ruby in Ruby!"
  spec.homepage      = "https://github.com/googleapis/gapic-generator-ruby"

  spec.files         = Dir.glob("bin/*") + Dir.glob("lib/**/*.rb") +
                       Dir.glob("gem_templates/**/*.erb") +
                       Dir.glob("templates/**/*.{rb,erb}") +
                       Dir.glob("*.md") +
                       ["LICENSE", "default-rubocop.yml", ".yardopts"]
  spec.bindir        = "bin"
  spec.executables   = ["gapic-generator", "protoc-gen-ruby_gapic"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5"

  spec.add_dependency "actionpack", "~> 5.2"
  spec.add_dependency "protobuf", "~> 3.8"

  spec.add_development_dependency "google-style", "~> 1.25.1"
  spec.add_development_dependency "grpc-tools", "~> 1.36.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-autotest", "~> 1.0"
  spec.add_development_dependency "minitest-focus", "~> 1.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", ">= 12.0"
  spec.add_development_dependency "redcarpet", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9"
end
