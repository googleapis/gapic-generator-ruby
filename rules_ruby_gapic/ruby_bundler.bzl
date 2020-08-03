def _bundler_install(repo_ctx):
  sh_path = repo_ctx.path("runbundler.sh")
  log_path = repo_ctx.path("bundler.log")
  repo_ctx.file("bundler.log")
  lrpath = "%s" % log_path.realpath

  gem_bin = repo_ctx.attr.gem_bin
  bundle_bin = repo_ctx.attr.bundle_bin
  gemfile = repo_ctx.attr.gemfile

  gem_path = repo_ctx.path(gem_bin)  
  bundle_path = repo_ctx.path(bundle_bin)
  gemfile_dir = repo_ctx.path(gemfile).dirname  

  repo_ctx.report_progress("Doing gem install -f --no-document bundler:2.1.4")
  res = repo_ctx.execute(["%s" % gem_path.realpath, "install", "-f", "--no-document", "bundler:2.1.4"], working_directory = ".")
  repo_ctx.file("logs/gem_install_bundler.log","RETCODE: {code}\nSTDOUT:{stdout}\nSTDERR:{stderr}".format(
    code = res.return_code,
    stdout = res.stdout,
    stderr = res.stderr,
  ))

  if res.return_code:
    fail("gem install failed:\nSTDOUT: %s\nSTRDERR: (%s)" % (res.stdout, res.stderr))

# 
  repo_ctx.file(
            "runbundler.sh",
            content = """#!/usr/bin/env bash
# Immediately exit if any command fails.
set -e
(cd "{gemfile_dir}" && rm -rf vendor && "{bundle}" config set --local deployment 'true' && "{bundle}" install && rm -f 'vendor/bundle/ruby/ruby_bazel_libroot/gems/mini_portile2-2.4.0/test/assets/patch 1.diff' && rm -rf 'vendor/bundle/ruby/ruby_bazel_libroot/gems/mini_portile2-2.4.0/test/assets/test mini portile-1.0.0')
""".format(
        gemfile_dir = gemfile_dir,
        bundle = bundle_path,
        log_path = lrpath
      ),
            executable = True,
  )

  repo_ctx.file("BUILD.bazel", """exports_files(glob(include = ["*"], exclude_directories = 0))""")

  repo_ctx.report_progress("Running bundler install on %s" % gemfile)
  res = repo_ctx.execute(
    ["%s" % sh_path],
  )

  repo_ctx.file("logs/bundler_install.log","RETCODE: {code}\nSTDOUT:{stdout}\nSTDERR:{stderr}".format(
    code = res.return_code,
    stdout = res.stdout,
    stderr = res.stderr,
  ))

  if res.return_code:
    fail("bundler install failed:\nSTDOUT: %s\nSTRDERR: (%s)" % (res.stdout, res.stderr))

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
  },
)