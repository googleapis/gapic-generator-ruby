exports_files(glob(include = ["export", "export/**/*"], exclude_directories = 0))
filegroup(
  name = "bundler_installed_gems",
  srcs = glob([
    "export",
    "export/**/*",
  ]),
  visibility = ["//visibility:public"],
)