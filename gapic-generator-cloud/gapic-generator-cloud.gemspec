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
require "google/gapic/generator/cloud/version"

Gem::Specification.new do |spec|
  spec.name          = "gapic-generator-cloud"
  spec.version       = Google::Gapic::Generator::Cloud::VERSION
  spec.authors       = ["landrito@google.com"]
  spec.email         = ["googleapis@google.com"]
  spec.licenses      = ["Apache-2.0"]

  spec.summary       = "An API Client Generator for Ruby in Ruby!"
  spec.homepage      = "https://github.com/googleapis/gapic-generator-ruby"

  # Specify which files should be added to the gem when it is released. The `git
  # ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir File.expand_path(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match %r{^(test|spec|features)/}
    end
  end
  spec.bindir        = "bin"
  spec.executables   = ["protoc-gen-ruby_cloud"]
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack", "~> 5.2"
  spec.add_dependency "gapic-generator"
  spec.add_dependency "protobuf", "~> 3.8"
  spec.add_dependency "rubocop", "~> 0.61"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-focus", "~> 1.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
