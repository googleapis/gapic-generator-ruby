exports_files(glob(include = ["export", "export/bundle", "export/**/*"], exclude_directories = 0))
filegroup(
  name = "bundler_installed_gems",
  srcs = glob([
    "export",
    "export/bundle",
    "export/**/*",
  ]),
  visibility = ["//visibility:public"],
)