# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/garbage/noservice/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-garbage-noservice"
  gem.version       = Google::Garbage::Noservice::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "google-garbage-noservice is the official client library for the Google Garbage Noservice API."
  gem.summary       = "API Client library for the Google Garbage Noservice API"
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "MIT"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.6"

  gem.add_dependency "gapic-common", ">= 0.21.1", "< 2.a"

  gem.add_development_dependency "google-style", "~> 1.26.3"
  gem.add_development_dependency "minitest", "~> 5.16"
  gem.add_development_dependency "minitest-focus", "~> 1.1"
  gem.add_development_dependency "minitest-rg", "~> 5.2"
  gem.add_development_dependency "rake", ">= 13.0"
  gem.add_development_dependency "redcarpet", "~> 3.0"
  gem.add_development_dependency "simplecov", "~> 0.18"
  gem.add_development_dependency "yard", "~> 0.9"
end
