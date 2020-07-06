exports_files(glob(include = ["{srcs_dir}/bin/**", "bin/*", "lib/**"], exclude_directories = 0))
load(":copy_ruby_runtime.bzl", "copy_ruby_runtime")

filegroup(
  name = "ruby_bins_allfiles",
  srcs = glob([
    "bin/**/*"
  ]),
  visibility = ["//visibility:public"],
)

filegroup(
  name = "ruby_libs_allfiles",
  srcs = glob([
    "lib/**/*"
  ]),
  visibility = ["//visibility:public"],
)

filegroup(
  name = "ruby_libroots",
  srcs = glob([
    "lib/**/.ruby_bazel_libroot",
  ]),
  visibility = ["//visibility:public"],
)

copy_ruby_runtime(
  name = "copy_ruby_runtime",
  visibility = ["//visibility:public"],
)
