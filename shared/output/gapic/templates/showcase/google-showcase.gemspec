# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/showcase/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-showcase"
  gem.version       = Google::Showcase::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "Showcase represents both a model API and an integration testing surface for client library generator consumption."
  gem.summary       = "Showcase represents both a model API and an integration testing surface for client library generator consumption."
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "MIT"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 3.0"

  gem.add_dependency "gapic-common", ">= 0.25.0", "< 2.a"
  gem.add_dependency "google-cloud-location", ">= 0.7", "< 2.a"
  gem.add_dependency "google-iam-v1", ">= 0.7", "< 2.a"
end
