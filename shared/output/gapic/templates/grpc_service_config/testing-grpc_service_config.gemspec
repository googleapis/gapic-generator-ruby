# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/testing/grpc_service_config/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "testing-grpc_service_config"
  gem.version       = Testing::GrpcServiceConfig::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "testing-grpc_service_config is the official library for Testing GrpcServiceConfig API."
  gem.summary       = "API Client library for Testing GrpcServiceConfig API"
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "MIT"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE.md", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.4"

  gem.add_dependency "gapic-common", "~> 0.1.0"

  gem.add_development_dependency "google-style", "~> 1.24.0"
  gem.add_development_dependency "minitest", "~> 5.10"
  gem.add_development_dependency "rake", "~> 12.0"
  gem.add_development_dependency "redcarpet", "~> 3.0"
  gem.add_development_dependency "simplecov", "~> 0.18"
  gem.add_development_dependency "yard", "~> 0.9"
end
