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
util functions
"""

##
# Runs a command and either fails or returns an ExecutionResult
#
def execute_and_check_result(ctx, command, **kwargs):
  res = ctx.execute(command, **kwargs)
  if res.return_code != 0:
      fail("""Failed to execute command: `{command}`{newline}Exit Code: {code}{newline}STDERR: {stderr}{newline}""".format(
          command = command,
          code = res.return_code,
          stderr = res.stderr,
          newline = "\n"
      ))
  return res

##
# Runs a command and logs the result into a separate file
#
def execute_log_action(repo_ctx, log_file_name, action, working_directory = ".", environment={}, should_fail = False):
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

  if log_file_name:
    log_file_path = "logs/{log_file_name}".format(log_file_name = log_file_name)
    repo_ctx.file(log_file_path, result_str)

  if should_fail and res.return_code:
    fail("Failed: {result_str}". format(result_str))

  return res, result_str