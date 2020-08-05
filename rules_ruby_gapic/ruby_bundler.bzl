def _bundler_install(repo_ctx):
  vendor_path = repo_ctx.path("./vendor")
  
  home_fname = repo_ctx.path("./home/foo")
  repo_ctx.file("home/foo", content ="")
  home_path = home_fname.dirname

  sh_path = repo_ctx.path("runbundler.sh")

  gem_bin = repo_ctx.attr.gem_bin
  gem_bin_path = repo_ctx.path(gem_bin)

  bundle_bin = repo_ctx.attr.bundle_bin
  bundle_bin_path = repo_ctx.path(bundle_bin)

  origin_gemfile = repo_ctx.attr.gemfile
  # origin_gemfile_lock = repo_ctx.attr.gemfile_lock
  # origin_gemfile_spec = repo_ctx.attr.gemfile_spec
  # origin_gemfile_srcs = repo_ctx.attr.gemfile_srcs

  #gemfile_dir = repo_ctx.path(origin_gemfile).dirname

  # gemfile_path = repo_ctx.path("Gemfile")
  # repo_ctx.symlink(origin_gemfile, gemfile_path)

  # gemfile_lock_path = repo_ctx.path("Gemfile.lock")
  # repo_ctx.symlink(origin_gemfile_lock, gemfile_lock_path)

  gemfile_dir = repo_ctx.path(origin_gemfile).dirname

  # _execute_log_action(repo_ctx, "copy_gemfile.log", 
  #   ["cp", "%s" % origin_gemfile_path, "%s" % gemfile_path, ]
  # )

  # First update bundler to the correct version
  _execute_log_action(repo_ctx, "gem_install_bundler.log", 
    ["%s" % gem_bin_path, "install", "-f", "--no-document", "bundler:2.1.4"]
  )

#"{bundle}" config set --local deployment 'true' && \\
#"{bundle}" config set --local path "{vendor_path}" && \\

  # Now create a file that will run the bundler update
  repo_ctx.file(
            "runbundler.sh",
            content = """#!/usr/bin/env bash
# Immediately exit if any command fails.
set -e
(cd "{gemfile_dir}" && \\
"{bundle}" install && \\
find {vendor_path} -name "patch 1.diff" -delete && \\
find {vendor_path} -type d -name "test mini portile-1.0.0" | while read f ; do rm -rf "$f" ; done )
""".format(
        gemfile_dir = gemfile_dir,
        bundle = bundle_bin_path,
        vendor_path = vendor_path
      ),
            executable = True,
  )

  #find {vendor_path} -type d -name "test mini portile-1.0.0" -print0 | xargs -0 -I {{}} /bin/rm -rf "{{}}"

  repo_ctx.report_progress("Running bundle install on %s" % gemfile_dir)
  _execute_log_action(repo_ctx, "bundle_install.log", ["%s" % sh_path], environment = {
    "HOME": "{home_path}".format(home_path = home_path), # otherwise the local user's home will get contaminated
    "BUNDLE_DEPLOYMENT": "true",
    "BUNDLE_PATH": "{vendor_path}".format(vendor_path = vendor_path),
  })
  
  repo_ctx.file("BUILD.bazel", """exports_files(glob(include = ["*"], exclude_directories = 0))
filegroup(
  name = "bundler_installed_gems",
  srcs = glob([
    "vendor",
    "vendor/**/*"
  ]),
  visibility = ["//visibility:public"],
)
""")

bundler_install = repository_rule(
  implementation = _bundler_install,
  attrs = {
    "gem_bin": attr.label(
      mandatory = True,
      allow_single_file = True,
    ),
    "bundle_bin": attr.label(
      mandatory = True,
      allow_single_file = True,
    ),
    "gemfile": attr.label(
      mandatory = True,
      allow_single_file = True,
    ),
    "gemfile_lock": attr.label(
      mandatory = True,
      allow_single_file = True,
    ),
  },
)

def _execute_log_action(repo_ctx, log_file_name, action, working_directory = ".", environment={}, should_fail = False):
  cmd = " ".join(action)
  repo_ctx.report_progress("Running {cmd}".format(cmd = cmd))

  res = repo_ctx.execute(action, working_directory = working_directory, environment = environment)
  result_str = "cmd: {cmd}\nENV: {env}\nRETCODE: {code}\nSTDOUT:{stdout}\nSTDERR:{stderr}".format(
    cmd = cmd,
    env = environment,
    code = res.return_code,
    stdout = res.stdout,
    stderr = res.stderr,
  )
  log_file_path = "logs/{log_file_name}".format(log_file_name = log_file_name)
  repo_ctx.file(log_file_path, result_str)

  if should_fail and res.return_code:
    fail("Failed: {result_str}". format(result_str))

  return res
