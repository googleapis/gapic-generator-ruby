# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/garbage/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-garbage"
  gem.version       = Google::Garbage::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "google-garbage is the official client library for the Google Garbage API."
  gem.summary       = "API Client library for the Google Garbage API"
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "MIT"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.7"

  gem.add_dependency "gapic-common", ">= 0.21.1", "< 2.a"
  gem.add_dependency "grpc-google-iam-v1", "~> 1.1"
end
