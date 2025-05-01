# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/testing/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "testing"
  gem.version       = Testing::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "Typical Garbage Service."
  gem.summary       = "Typical Garbage Service."
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "MIT"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 3.1"

  gem.add_dependency "gapic-common", "~> 1.0"
  gem.add_dependency "google-cloud-common", "~> 1.0"
  gem.add_dependency "google-cloud-location", "~> 1.0"
end
