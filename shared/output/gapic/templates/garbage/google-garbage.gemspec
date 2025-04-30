# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/garbage/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-garbage"
  gem.version       = Google::Garbage::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "## Overview Typical Garbage Service overview. ## Resources Typical Garbage Service {typical.garbage}"
  gem.summary       = "Typical Garbage Service Summary."
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "MIT"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 3.1"

  gem.add_dependency "gapic-common", "~> 1.0"
  gem.add_dependency "grpc-google-iam-v1", "~> 1.11"
end
