"""
Creating the ruby runtime workspace
"""

load(
  ":templates/copy_ruby_runtime_template.bzl",
  copy_ruby_runtime_template = "copy_ruby_runtime_template",
  )

load(
  ":private/utils.bzl",
  _execute_and_check_result = "execute_and_check_result",
)

###
# 
#
def create_copy_ruby_runtime_bzl():
  return copy_ruby_runtime_template

##
# Implementation for a ruby_runtime rule
# 
def _ruby_runtime_impl(ctx):
  # grabbing the path to the root of the dynamic workspace
  root_path = ctx.path(".")

  # a folder to extract the sources into
  srcs_dir = "srcs"
  
  # First try using the prebuilt version
  os_name = ctx.os.name
  prebuilt_selection_log = ""
  if len(ctx.attr.prebuilt_rubys) == 0:
    prebuilt_selection_log = "No prebuilt rubies supplied"
  else:
    prebuilt_selection_log = "{count} prebuilt rubies supplied. Filtering on the os name {os_name}".format(count = len(ctx.attr.prebuilt_rubys), os_name=os_name)

  working_prebuild_located = False

  for prebuilt_ruby in ctx.attr.prebuilt_rubys:
    prebuilt_selection_log += "\nTrying prebuilt ruby @ {prebuilt_ruby}".format(prebuilt_ruby = prebuilt_ruby)
    if prebuilt_ruby.name.find(os_name) < 0:
      prebuilt_selection_log += "\nPrebuilt ruby @ {prebuilt_ruby}: does not contain os name {os_name}".format(prebuilt_ruby = prebuilt_ruby, os_name=os_name)
      continue

    tmp = "ruby_tmp"
    _execute_and_check_result(ctx, ["mkdir", tmp], quiet = False)
    ctx.extract(archive = prebuilt_ruby, stripPrefix = ctx.attr.strip_prefix, output = tmp)
    include_path = ctx.path("./{tmp}/lib".format(tmp = tmp))
    include_path_str =  "%s" % include_path.realpath
    ctx.file("includepath.log", include_path_str)
    res = ctx.execute(["bin/ruby", "--version"], environment={"LD_LIBRARY_PATH" : include_path_str}, working_directory = tmp)
    _execute_and_check_result(ctx, ["rm", "-rf", tmp], quiet = False)
    if res.return_code == 0:
      ctx.extract(archive = prebuilt_ruby, stripPrefix = ctx.attr.strip_prefix)
      working_prebuild_located = True
      prebuilt_selection_log += "\nPrebuilt ruby @ {prebuilt_ruby}: execution succeeded. Chosen.".format(prebuilt_ruby = prebuilt_ruby)
      break
    else:
      prebuilt_selection_log += "\nPrebuilt ruby @ {prebuilt_ruby}: execution failed code {res_code}; Error:\n{err}".format(prebuilt_ruby = prebuilt_ruby, res_code=res.return_code, err=res.stderr)

  ctx.file("prebuilt_selection.log", prebuilt_selection_log+"\n")
  if not working_prebuild_located:
    ctx.download_and_extract(
      url = ctx.attr.urls,
      stripPrefix = ctx.attr.strip_prefix,
      output = srcs_dir,
    )

    # configuring with shared library support, no docs and installing inside our workspace
    configure_opts = ["./configure",
      "--enable-load-relative", # this forces the path to libruby{version}.so to be relative instead of absolute allowing for prebuiltization
      #"--build=x86_64-linux-gnu",
      "--enable-shared",
      "--with-openssl-dir=/usr",
      "--with-zlib-dir=/usr",
      "--with-readline-dir=/usr",
      "--disable-install-doc",
      "--prefix=%s" % root_path.realpath,
      "--with-ruby-version=ruby_bazel_libroot"]
    ctx.file("configure_opts.log", " ".join(configure_opts))
    _execute_and_check_result(ctx, configure_opts, working_directory = srcs_dir, quiet = False)

    # if num_proc gets us some reasonable number of processors let's use them
    num_proc = "1"
    make_opts_log = ""
    # let's try to run nproc
    nproc_res = ctx.execute(["nproc"])
    if nproc_res.return_code == 0:
      num_proc = nproc_res.stdout.rstrip()
      make_opts_log += "numproc was {num_proc}".format(num_proc = num_proc)
    else:
      make_opts_log += "running numproc ended in error: {stderr}".format(stderr = nproc_res.stderr)

    make_opts = ["make",]
    if num_proc.isdigit():
      if int(num_proc) > 1:
        make_opts.extend(["-j", num_proc])

    make_opts_log += "\n" + " ".join(make_opts)
    ctx.file("make_opts.log", make_opts_log)
    
    _execute_and_check_result(ctx, make_opts, working_directory = srcs_dir, quiet = False)

    # nothing special about make install
    _execute_and_check_result(ctx, ["make", "install"], working_directory = srcs_dir, quiet = False)

  ctx.report_progress("=======================================")
  ctx.report_progress("Installing gems")


  for gem, version in  ctx.attr.gems_to_install.items():
    ctx.report_progress("-------------------------------------")
    ctx.report_progress("Installing gem: {gem} version {version}".format(gem=gem, version=version))

    #gem_path = "./vendor/cache/{gem}".format(gem=gem)
    #res = ctx.execute(["bin/gem", "install", "--force", "--local", gem_path], working_directory = ".")

    res = ctx.execute(["bin/gem", "install", gem, "-v={version}".format(version=version)], working_directory = ".")

    if res.return_code != 0:
      ctx.report_progress("failed to install")
      log_path = "err_gem_install_{gem}.log".format(gem=gem)
      ctx.file(log_path, "Gem {gem} install failed code {res_code}; Error:\n{err}".format(gem=gem, res_code=res.return_code, err=res.stderr))
    else:
      ctx.report_progress("install successful")

  ctx.report_progress("=======================================")

  # adding a libroot file to mark the root of the ruby standard library
  ctx.file("lib/ruby/ruby_bazel_libroot/.ruby_bazel_libroot", "")

  copy_ruby_runtime_bzl = create_copy_ruby_runtime_bzl()
  ctx.file("copy_ruby_runtime.bzl", copy_ruby_runtime_bzl)

  ctx.template(
    "BUILD.bazel",
    ctx.attr._build_tpl,
    substitutions = {"{srcs_dir}": srcs_dir,},
  )

##
# Creates a workspace with ruby runtime, including
# a ruby executable and ruby standard libraries
#
# urls: url of the ruby sources archive 
# strip_prefix: the path prefix to strip after extracting
# prebuilt_rubys: list of archives with prebuilt ruby versions (for different platforms)
#
ruby_runtime = repository_rule(
  implementation = _ruby_runtime_impl,
  attrs = {
    "urls": attr.string_list(),
    "strip_prefix": attr.string(),
    "prebuilt_rubys": attr.label_list(allow_files = True, mandatory = False),
    "gems_to_install": attr.string_dict(),
    "_build_tpl": attr.label(
      default = ":templates/BUILD.dist.bazel.tpl"
    ),
  }
)
