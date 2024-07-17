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
require "gapic/common/version"

Gem::Specification.new do |spec|
  spec.name =          "gapic-common"
  spec.version =       Gapic::Common::VERSION
  spec.authors =       ["Google API Authors"]
  spec.email =         ["googleapis-packages@google.com"]
  spec.licenses =      ["Apache-2.0"]

  spec.summary =       "Common code for GAPIC-generated API clients"
  spec.homepage =      "https://github.com/googleapis/gapic-generator-ruby"

  spec.files =         Dir.glob("lib/**/*") + Dir.glob("*.md") +
                       ["LICENSE", ".yardopts"]
  spec.require_paths = ["lib"]
  spec.platform =      Gem::Platform::RUBY

  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "faraday", ">= 1.9", "< 3.a"
  spec.add_dependency "faraday-retry", ">= 1.0", "< 3.a"
  spec.add_dependency "googleapis-common-protos", "~> 1.6"
  spec.add_dependency "googleapis-common-protos-types", "~> 1.15"
  spec.add_dependency "googleauth", "~> 1.11"
  spec.add_dependency "google-protobuf", ">= 3.25", "< 5.a"
  spec.add_dependency "grpc", "~> 1.65"
end
