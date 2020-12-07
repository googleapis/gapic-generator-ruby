# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
Creates a workspace with ruby runtime, including ruby executables and ruby standard libraries
"""
load(
  ":private/utils.bzl",
  _execute_log_action = "execute_log_action",
)

##
# Tries a single prebuilt ruby rutime file and verifies if it's working
#
def try_prebuilt(ctx, prebuilt_ruby, os_name):
  prebuilt_selection_log = "\nTrying prebuilt ruby @ {prebuilt_ruby}".format(prebuilt_ruby = prebuilt_ruby)
  if prebuilt_ruby.name.find(os_name) < 0:
    prebuilt_selection_log += "\nPrebuilt ruby @ {prebuilt_ruby}: does not contain os name {os_name}".format(
      prebuilt_ruby = prebuilt_ruby,
      os_name = os_name
    )
    return False, prebuilt_selection_log

  tmp = "ruby_tmp"
  _execute_log_action(ctx, None, ["mkdir", tmp], quiet = False)
  
  ctx.extract(archive = prebuilt_ruby, stripPrefix = ctx.attr.strip_prefix, output = tmp)

  res = ctx.execute(
    ["bin/ruby", "-ropenssl", "-rzlib", "-rreadline", "-rdigest/sha2.so", "-e 'puts :success'"],
    working_directory = tmp
  )

  prebuilt_working = res.return_code == 0

  if prebuilt_working == 0:
    prebuilt_selection_log += "\nPrebuilt ruby @ {prebuilt_ruby}: execution succeeded. Chosen.".format(
      prebuilt_ruby = prebuilt_ruby
    )
  else:
    prebuilt_selection_log += "\nPrebuilt ruby @ {prebuilt_ruby}: execution failed code {res_code}; Error:\n{err}".format(
      prebuilt_ruby = prebuilt_ruby, res_code=res.return_code, err=res.stderr)
  
  _execute_log_action(ctx, None, ["rm", "-rf", tmp], quiet = False)
  return prebuilt_working, prebuilt_selection_log

##
# Creates a ruby runtime by downloading and building ruby sources
#
def build_ruby_runtime(ctx, root_path, srcs_dir):
  ctx.download_and_extract(
    url = ctx.attr.urls,
    stripPrefix = ctx.attr.strip_prefix,
    output = srcs_dir,
  )

  # configuring with shared library support, no docs and installing inside our workspace
  configure_opts = ["./configure",
    # this forces the path to libruby{version}.so to be relative 
    # instead of absolute allowing for the reusable prebuilds
    "--enable-load-relative",
    "--enable-shared",
    "--with-openssl-dir=/usr",
    "--with-zlib-dir=/usr",
    "--with-readline-dir=/usr",
    "--disable-install-doc",
    "--prefix=%s" % root_path.realpath,
    "--with-ruby-version=ruby_bazel_libroot"]
  ctx.file("configure_opts.log", " ".join(configure_opts))
  _execute_log_action(ctx, None, configure_opts, working_directory = srcs_dir, quiet = False)

  # if num_proc gets us some reasonable number of processors let's use them
  num_proc = "1"
  make_opts_log = ""
  # let's try to run nproc to get the count of processors
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

  _execute_log_action(ctx, None, make_opts, working_directory = srcs_dir, quiet = False)
  _execute_log_action(ctx, None, ["make", "install"], working_directory = srcs_dir, quiet = False)

##
# Tries to find a gem installed locally with gem list
#
def try_locate_gem(ctx, gem, version):
  ctx.report_progress("-------------------------------------")
  ctx.report_progress("Checking for gem: {gem} version {version}".format(gem = gem, version = version))
  cmd_arr = ["bin/gem", "list", "-i", '{gem}'.format(gem = gem), "-v", '{version}'.format(version = version)]
  res = ctx.execute(cmd_arr, working_directory = ".")
  gem_located = res.return_code == 0
  report = ""
  if gem_located:
    report = "Gem {gem} version {version} located installed".format(gem = gem, version = version)
    ctx.report_progress(report)
  else:
    log_path = "logs/err_gem_list_{gem}.log".format(gem = gem, version = version)
    report = "Gem {gem} version {version} list failed code {res_code}\nCmd: {cmd}\nStdOut:\n{stdout}\nStdErr:\n{stderr}".format(
      gem = gem,
      version = version,
      res_code = res.return_code,
      cmd = " ".join(cmd_arr),
      stdout = res.stdout,
      stderr = res.stderr
    )
    ctx.report_progress(report)
    ctx.file(log_path, report)
  
  return gem_located, report

##
# Installs a gem from rubygems with gem install
#
def install_gem(ctx, gem, version):
  ctx.report_progress("-------------------------------------")  
  ctx.report_progress("Installing gem: {gem} version {version}".format(gem = gem, version = version))

  res = ctx.execute(["bin/gem", "install", gem, "-v={version}".format(version = version)], working_directory = ".")
  report = ""
  if res.return_code == 0:
    report = "Gem {gem} version {version} install successful".format(gem = gem, version = version)
    ctx.report_progress(report)
  else:
    ctx.report_progress("failed to install")
    log_path = "logs/err_gem_install_{gem}.log".format(gem = gem)
    report = "Gem {gem} version {version} install failed code {res_code}; StdErr:\n{stderr}".format(
      gem = gem,
      version = version,
      res_code = res.return_code,
      stderr = res.stderr
    )
    ctx.report_progress(report)
    ctx.file(log_path, report)

  return report

##
# Implementation for a ruby_runtime rule
# 
def _ruby_runtime_impl(ctx):
  # grabbing the path to the root of the dynamic workspace
  root_path = ctx.path(".")

  # a folder to extract the sources into
  srcs_dir = "srcs"
  
  ctx.report_progress("Unpacking or building the ruby runtime")
  # First try using the prebuilt version
  os_name = ctx.os.name
  prebuilt_selection_log = ""
  if len(ctx.attr.prebuilt_rubys) == 0:
    prebuilt_selection_log = "No prebuilt rubies supplied"
  else:
    prebuilt_selection_log = "{count} prebuilt rubies supplied. Filtering on the os name {os_name}".format(
      count = len(ctx.attr.prebuilt_rubys),
      os_name = os_name
    )

  working_prebuild_located = False

  for prebuilt_ruby in ctx.attr.prebuilt_rubys:
    prebuilt_working, prebuilt_log = try_prebuilt(ctx, prebuilt_ruby, os_name)
    prebuilt_selection_log += prebuilt_log
    if prebuilt_working:
      ctx.extract(archive = prebuilt_ruby, stripPrefix = ctx.attr.strip_prefix)
      working_prebuild_located = True
      break

  ctx.file("logs/prebuilt_selection.log", prebuilt_selection_log+"\n")
  if not working_prebuild_located:
    build_ruby_runtime(ctx, root_path, srcs_dir)

  ctx.report_progress("Installing gems")
  _execute_log_action(ctx, "gem_env_novars_set.log", 
    ["bin/gem", "env"],
  )

  res = ctx.execute(["bin/gem", "list"], working_directory = ".")
  ctx.file("logs/gem_list_pre.log", res.stdout)

  gem_log = []
  for gem, version in  ctx.attr.gems_to_install.items():
    gem_located = False
    if working_prebuild_located:
      gem_located, gem_locate_report = try_locate_gem(ctx, gem, version)
      gem_log.append(gem_locate_report)

    if not gem_located:
      gem_install_report = install_gem(ctx, gem, version)
      gem_log.append(gem_install_report)

  gem_report_path = "logs/gem_report.log"
  ctx.file(gem_report_path, "\n".join(gem_log)+"\n")

  bundler_version = None
  if ctx.attr.bundler_version_to_install:
    bundler_version = ctx.attr.bundler_version_to_install
    ctx.file("logs/bundler_version_from_attr.log", bundler_version)
  elif ctx.attr.gemfile_lock:
    gemfile_lock_str = ctx.read(ctx.attr.gemfile_lock)
    bundler_version = [x.strip() for x in gemfile_lock_str.split("\n") if x.strip()].pop()
    ctx.file("logs/bundler_version_from_gemfile.log", bundler_version)

  if bundler_version:
    gem_home_path = ctx.path("./lib/ruby/gems/ruby_bazel_libroot/")
    gem_home_path_str = "%s" % gem_home_path.realpath

    _execute_log_action(ctx, "gem_env_bundler_envars.log", 
      ["bin/gem", "env"],
      environment = {
        "GEM_HOME": gem_home_path_str,
        "GEM_PATH": gem_home_path_str,
      }
    )

    # Update bundler to the correct version
    _execute_log_action(ctx, "gem_install_bundler.log", 
      ["bin/gem", "install", "-f", "--no-document", "bundler:{version}".format(version = bundler_version)],
      environment = {
        "GEM_HOME": gem_home_path_str,
        "GEM_PATH": gem_home_path_str,
      }
    )
    
    _execute_log_action(ctx, "gem_list_post_bundler_envars.log", ["bin/gem", "list"], 
      environment = {
        "GEM_HOME": gem_home_path_str,
        "GEM_PATH": gem_home_path_str, 
      }
    )
    
    _execute_log_action(ctx, "bundler_version_envars.log", ["bin/bundler", "--version"],
      environment = {
        "GEM_HOME": gem_home_path_str,
        "GEM_PATH": gem_home_path_str, 
      }
    )

    sh_path = ctx.path("gem_install_bundler.sh")
    ctx.template(
      sh_path.basename,
      ctx.attr._gem_install_bundler_tpl,
      executable = True,
    )
    _execute_log_action(ctx, "bundler_version_unset.log", ["%s" % sh_path])


  _execute_log_action(ctx, "gem_list_post.log", ["bin/gem", "list"])
  _execute_log_action(ctx, "bundler_version.log", ["bin/bundler", "--version"]) 

  # adding a libroot file to mark the root of the ruby standard library
  ctx.file("lib/ruby/ruby_bazel_libroot/.ruby_bazel_libroot", "")

  # adding a BUILD.bazel file to the workspace with the filegroup targets for the things we've built
  ctx.template(
    "BUILD.bazel",
    ctx.attr._build_tpl,
    substitutions = {"{srcs_dir}": srcs_dir,},
  )

##
# Creates a workspace with ruby runtime, including
# ruby executables and ruby standard libraries. 
# Optionally allows gems to be installed
#
# urls: url of the ruby sources archive 
# strip_prefix: the path prefix to strip after extracting
# prebuilt_rubys: list of archives with prebuilt ruby versions (for different platforms)
# gems_to_install: list of gems to preinstall in the workspace
#
ruby_runtime = repository_rule(
  implementation = _ruby_runtime_impl,
  attrs = {
    "urls": attr.string_list(),
    "strip_prefix": attr.string(),
    "prebuilt_rubys": attr.label_list(allow_files = True, mandatory = False),
    "gems_to_install": attr.string_dict(),
    "bundler_version_to_install": attr.string(
      mandatory = False,
    ),
    "gemfile_lock": attr.label(
      mandatory = False,
      allow_single_file = True,
    ),
    "_build_tpl": attr.label(
      default = ":templates/BUILD.dist.bazel.tpl"
    ),
    "_gem_install_bundler_tpl": attr.label(
      default = ":templates/gem_install_bundler.sh.tpl"
    ),
  }
)
