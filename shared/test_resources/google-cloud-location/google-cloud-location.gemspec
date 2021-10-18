# frozen_string_literal: true
# This is a placeholder that will be removed
# when google-cloud-locations gem is released

Gem::Specification.new do |spec|
  spec.name          = "google-cloud-location"
  spec.version       = "1.0"
  spec.authors       = ["Viacheslav Rostovtsev"]
  spec.email         = ["virost@google.com"]

  spec.summary       = "."
  spec.homepage      = "http://example.com/location"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
