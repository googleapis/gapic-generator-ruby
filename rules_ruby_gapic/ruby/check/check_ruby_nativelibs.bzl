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
exercising the ruby libraries with a special require
"""

##
# An implementation for the check_ruby_require rule
#
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
