load("//rules_ruby_gapic/ruby:ruby_runtime.bzl", "ruby_runtime")
load("//rules_ruby_gapic/ruby:ruby_bundler.bzl", "bundle_install")

def gapic_generator_cloud_repos():
  # Create the ruby runtime
  ruby_runtime(
    name = "gapic_generator_cloud_ruby_runtime",
    urls = ["https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.6.tar.gz"],
    strip_prefix = "ruby-2.6.6",
    prebuilt_rubys = [
      "@gapic_generator_ruby//rules_ruby_gapic:prebuilt/ruby-2.6.6_glinux_x86_64.tar.gz",
    ],
    gemfile_lock = "@gapic_generator_ruby//:gapic-generator-cloud/Gemfile.lock",
    gems_to_install = {},
  )

  bundle_install(
    name = "bundler_gapic_generator_cloud",
    bundle_bin = "@gapic_generator_cloud_ruby_runtime//:bin/bundle",
    gemfile = "@gapic_generator_ruby//:gapic-generator-cloud/Gemfile",
    gemfile_lock = "@gapic_generator_ruby//:gapic-generator-cloud/Gemfile.lock",
    gemfile_srcs = {
      "@gapic_generator_ruby//:gapic-generator-cloud/Gemfile" : "gapic-generator-cloud/Gemfile",
      "@gapic_generator_ruby//:gapic-generator-cloud/Gemfile.lock" : "gapic-generator-cloud/Gemfile.lock",
      "@gapic_generator_ruby//:gapic-generator-cloud/gapic-generator-cloud.gemspec": "gapic-generator-cloud/gapic-generator-cloud.gemspec",
      "@gapic_generator_ruby//:gapic-generator-cloud/lib/gapic/generator/cloud/version.rb": "gapic-generator-cloud/lib/gapic/generator/cloud/version.rb",
      "@gapic_generator_ruby//:gapic-generator/gapic-generator.gemspec": "gapic-generator/gapic-generator.gemspec",
      "@gapic_generator_ruby//:gapic-generator/lib/gapic/generator/version.rb": "gapic-generator/lib/gapic/generator/version.rb"
    }
  )
