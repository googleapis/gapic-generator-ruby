# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/cloud/secret_manager/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-cloud-secret_manager"
  gem.version       = Google::Cloud::SecretManager::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "google-cloud-secret_manager is the official client library for the Secret Manager API."
  gem.summary       = "Stores, manages, and secures access to application secrets."
  gem.homepage      = "https://github.com/googleapis/google-cloud-ruby"
  gem.license       = "Apache-2.0"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      ["README.md", "AUTHENTICATION.md", "LICENSE.md", ".yardopts", "MIGRATING.md"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 3.0"

  gem.add_dependency "google-cloud-core", "~> 1.6"
  gem.add_dependency "google-cloud-secret_manager-v1", "~> 1.0"
  gem.add_dependency "google-cloud-secret_manager-v1beta1", ">= 0.2", "< 2.a"
end
