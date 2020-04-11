# frozen_string_literal: true

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


lib = File.expand_path "lib", __dir__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require "gapic/generator/ads/version"

Gem::Specification.new do |spec|
  spec.name          = "gapic-generator-ads"
  spec.version       = Gapic::Generator::Ads::VERSION
  spec.authors       = ["Ernest Landrito", "Chris Smith", "Mike Moore"]
  spec.email         = ["landrito@google.com", "quartzmo@gmail.com",
                        "mike@blowmage.com"]

  spec.licenses      = ["Apache-2.0"]

  spec.summary       = "An API Client Generator for Ruby in Ruby!"
  spec.homepage      = "https://github.com/googleapis/gapic-generator-ruby"

  spec.files         = Dir.glob("bin/*") + Dir.glob("lib/**/*.rb") +
                       Dir.glob("templates/**/*.{rb,erb}") +
                       Dir.glob("*.md") +
                       ["LICENSE"]
  spec.bindir        = "bin"
  spec.executables   = ["protoc-gen-ruby_ads"]
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack", "~> 5.2"
  spec.add_dependency "gapic-generator", "= 0.3.1"
  spec.add_dependency "protobuf", "~> 3.8"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "google-style", "~> 1.24.0"
  spec.add_development_dependency "grpc-tools", "~> 1.19"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-focus", "~> 1.0"
  spec.add_development_dependency "rake", ">= 12.0"
end
