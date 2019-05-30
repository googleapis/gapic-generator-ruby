# -*- ruby -*-
# encoding: utf-8

require File.expand_path("lib/google/ads/googleads/version", __dir__)

Gem::Specification.new do |gem|
  gem.name          = "google-ads-googleads"
  gem.version       = Google::Ads::GoogleAds::VERSION

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "google-ads-googleads is the official library for Google Ads Googleads API."
  gem.summary       = "API Client library for Google Ads Googleads API"
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "MIT"

  gem.platform      = Gem::Platform::RUBY

  gem.files         = `git ls-files -- lib/*`.split("\n") +
                      `git ls-files -- proto_docs/*`.split("\n") +
                      ["README.md", "LICENSE", ".yardopts"]
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.0.0"

  gem.add_dependency "google-gax", "2.0.alpha.0.development"

  gem.add_development_dependency "google-style", "~> 0.3"
  gem.add_development_dependency "minitest", "~> 5.10"
  gem.add_development_dependency "redcarpet", "~> 3.0"
  gem.add_development_dependency "simplecov", "~> 0.9"
  gem.add_development_dependency "yard", "~> 0.9"
end
