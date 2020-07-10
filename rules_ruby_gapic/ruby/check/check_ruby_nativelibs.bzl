"""
exercising the ruby libraries with a special require
"""

def _check_ruby_require_impl(ctx):
  run_result_file = ctx.actions.declare_file(ctx.attr.name)
  ruby_bin = ctx.file.ruby_bin

  exec_text = "#!/bin/bash\n" + "{ruby_bin} -ropenssl -rzlib -rreadline -rdigest/sha2.so -e 'puts :success'".format(ruby_bin = ruby_bin.path)
  ctx.actions.write(run_result_file, exec_text)
  runfiles = ctx.runfiles(files=[run_result_file, ruby_bin])

  return [DefaultInfo(
    files = depset(direct=[]),
    runfiles = runfiles,
    executable = run_result_file,
  )]

##
# Executing a special command that runs ruby while requiring multiple ruby libraries 
# If this is running then the ruby standard libs seem to be built correctly
#
check_ruby_require = rule(
  _check_ruby_require_impl,
  attrs = {
    "ruby_bin": attr.label(
      allow_single_file = True,
      executable = True,
      cfg = "host",
    )
  },
  executable = True,
)
