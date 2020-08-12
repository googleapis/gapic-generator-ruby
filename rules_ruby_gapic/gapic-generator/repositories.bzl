load("//rules_ruby_gapic/ruby:ruby_runtime.bzl", "ruby_runtime")
load("//rules_ruby_gapic/ruby:ruby_bundler.bzl", "bundle_install")

def gapic_generator_repos():
  # Create the ruby runtime
  ruby_runtime(
    name = "gapic_generator_ruby_runtime",
    urls = ["https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.6.tar.gz"],
    strip_prefix = "ruby-2.6.6",
    prebuilt_rubys = [
      "@gapic_generator_ruby//rules_ruby_gapic:prebuilt/ruby-2.6.6_glinux_x86_64.tar.gz",
    ],
    gemfile_lock = "@gapic_generator_ruby//:gapic-generator/Gemfile.lock",
    gems_to_install = {},
  )

  bundle_install(
    name = "bundler_gapic_generator",
    bundle_bin = "@gapic_generator_ruby_runtime//:bin/bundle",
    gemfile = "@gapic_generator_ruby//:gapic-generator/Gemfile",
    gemfile_lock = "@gapic_generator_ruby//:gapic-generator/Gemfile.lock",
    gemfile_srcs = {
      "@gapic_generator_ruby//:gapic-generator/Gemfile":"gapic-generator/Gemfile",
      "@gapic_generator_ruby//:gapic-generator/Gemfile.lock":"gapic-generator/Gemfile.lock",
      "@gapic_generator_ruby//:gapic-generator/gapic-generator.gemspec": "gapic-generator/gapic-generator.gemspec",
      "@gapic_generator_ruby//:gapic-generator/lib/gapic/generator/version.rb": "gapic-generator/lib/gapic/generator/version.rb"
    }
  )
