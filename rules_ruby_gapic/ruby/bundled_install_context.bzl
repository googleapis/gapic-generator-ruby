load("//rules_ruby_gapic:private/providers.bzl", "BundledInstallContext")

##
# An implementation of the ruby_context rule
#
def _bundled_install_context_impl(ctx):
  gemfile = ctx.file.gemfile
  all_bundled_files = ctx.files.all_bundled_files

  return [
    DefaultInfo(files = depset(all_bundled_files)),
    BundledInstallContext(
      gemfile = gemfile,
      all_bundled_files = all_bundled_files,
    ),
  ]

bundled_install_context = rule(
  _bundled_install_context_impl,
  attrs = {
    "gemfile": attr.label(
      allow_single_file = True,
    ),
    "all_bundled_files": attr.label(),
  }
)
