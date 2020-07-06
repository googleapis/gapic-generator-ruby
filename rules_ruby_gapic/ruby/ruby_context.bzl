"""
Builds ruby runtime context from the ruby runtime.
It's a bit convoluted since ruby runtime is a repo rule, so
the path goes ruby_runtime -> WORKSPACE -> ruby_context
"""
load("//rules_ruby_gapic:private/providers.bzl", "RubyContext", "RubyLibraryInfo")

def _ruby_context_impl(ctx):
  ruby_bin = ctx.file.ruby_bin
  all_bins = ctx.files.all_bins
  ruby_libfiles = ctx.files.ruby_libfiles
  lib_root = ctx.files.ruby_libroots[0]

  return [
    DefaultInfo(files = depset(ruby_libfiles)),
    RubyContext(
      info = struct(
        srcs = ruby_libfiles,
        lib_path = lib_root,
      ),
      bin = ruby_bin,
      all_bins = all_bins,
    ),
    RubyLibraryInfo(
      info = struct(
        srcs = ruby_libfiles,
        lib_path = lib_root,
        ext_path = None,
      ),
      deps = depset(),
    ),
  ]

ruby_context = rule(
  _ruby_context_impl,
  attrs = {
    "ruby_bin": attr.label(
      allow_single_file = True,
      executable = True,
      cfg = "host"
    ),
    "all_bins": attr.label(),
    "ruby_libfiles": attr.label(),
    "ruby_libroots": attr.label(),
  }
)
