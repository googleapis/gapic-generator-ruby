# frozen_string_literal: true

# Copyright 2019 Google LLC
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
require "gapic/version"

Gem::Specification.new do |spec|
  spec.name = "gapic"
  spec.version = Gapic::VERSION
  spec.authors = ["Google API Authors"]
  spec.email = ["googleapis-packages@google.com"]
  spec.licenses = ["Apache-2.0"]

  spec.platform = Gem::Platform::RUBY

  spec.summary = "Core namespace for Google generated API client tools"
  spec.homepage = "https://github.com/googleapis/gapic-generator-ruby"

  spec.files = Dir.glob("lib/**/*.rb") + Dir.glob("*.md") +
               ["LICENSE"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7"
end
