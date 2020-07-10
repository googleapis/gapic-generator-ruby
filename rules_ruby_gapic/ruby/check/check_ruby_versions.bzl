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
exercising the binaries of ruby sources
kicking the tires with the --version
"""

##
# An implementation for the check_ruby_binver rule
#
def _check_ruby_binver_impl(ctx):
  # declare the output of our rule,
  dec_file = ctx.actions.declare_file(ctx.attr.name)
  
  # note that the shell comand must be written in terms of dependencies and results
  ctx.actions.run_shell(
    tools = [ctx.file.dependency], 
    command="{bin} --version > {bin_result}".format(bin = ctx.file.dependency.path, bin_result = dec_file.path), 
    outputs=[dec_file])
  
  # end result of our rule with one file that we have declared
  return [DefaultInfo(files=depset(direct=[dec_file]))]

##
# Executing a --version over a binary file (e.g. gem) that is present 
# in the archive with the ruby sources.
# Does not need the sources to be built but currently there is no alternative.
#
check_ruby_binver = rule(
  _check_ruby_binver_impl,
  attrs = {
    "dependency": attr.label(
      allow_single_file = True,
      executable = True,
      cfg = "host",
    )
  }
)
