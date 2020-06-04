workspace(name = "gapic_generator_ruby")

##
# Import gapic-generator-ruby specific dependencies
#
load("//rules_ruby_gapic:repositories.bzl", "gapic_generator_ruby")
gapic_generator_ruby()

##
# Create the ruby runtime
#
load ("//rules_ruby_gapic/ruby:ruby_runtime.bzl", "ruby_runtime")
ruby_runtime (
  name = "ruby_runtime",
  urls = ["https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.6.tar.gz"],
  strip_prefix = "ruby-2.6.6",
  prebuilt_rubys = [
    #"//rules_ruby_gapic:prebuilt/ruby-2.6.6_glinux_x86_64.tar.gz",
    "//rules_ruby_gapic:prebuilt/ruby-2.6.6_linux_container_x86_64.tar.gz",
  ],
)
