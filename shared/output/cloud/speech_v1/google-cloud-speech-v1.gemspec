# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/cloud/speech/v1/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-cloud-speech-v1"
  gem.version       = Google::Cloud::Speech::V1::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "google-cloud-speech-v1 is the official library for Google Cloud Speech V1 API."
  gem.summary       = "API Client library for Google Cloud Speech V1 API"
  gem.homepage      = "https://github.com/googleapis/google-cloud-ruby"
  gem.license       = "Apache-2.0"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", "AUTHENTICATION.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.4"

  gem.add_dependency "gapic-common", "~> 0.1.0"
  gem.add_dependency "google-cloud-errors", "~> 1.0"

  gem.add_development_dependency "google-style", "~> 1.24.0"
  gem.add_development_dependency "minitest", "~> 5.10"
  gem.add_development_dependency "rake", ">= 12.0"
  gem.add_development_dependency "redcarpet", "~> 3.0"
  gem.add_development_dependency "simplecov", "~> 0.18"
  gem.add_development_dependency "yard", "~> 0.9"
end
