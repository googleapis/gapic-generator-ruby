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
def execute_log_action(repo_ctx, log_file_name, action, should_fail = False, **kwargs):
  cmd = " ".join(action)
  repo_ctx.report_progress("Running {cmd}".format(cmd = cmd))

  environment_str = ""
  if "environment" in kwargs:
    environment_str = "\nENV: {env}".format(env = kwargs["environment"])

  workdir_str = ""
  if "working_directory" in kwargs:
    workdir_str = "\nENV: {workdir}".format(workdir = kwargs["working_directory"])

  sh_path = repo_ctx.path("{log_file_name}.sh".format(log_file_name = log_file_name))
  shell_script_lines = [
    "#!/bin/bash",
    "unset GEM_HOME",
    "unset GEM_PATH",
    cmd,
    "",
  ]
  exec_text = "\n".join(shell_script_lines)

  repo_ctx.file(sh_path.basename, exec_text)
  
  res = repo_ctx.execute(["%s" % sh_path], **kwargs)
  result_str = "cmd: {cmd}{env_str}{workdir_str}\nRETCODE: {code}\nSTDOUT:{stdout}\nSTDERR:{stderr}".format(
    cmd = cmd,
    env_str = environment_str,
    workdir_str = workdir_str,
    code = res.return_code,
    stdout = res.stdout,
    stderr = res.stderr,
  )

  if log_file_name:
    log_file_path = "logs/commands/{log_file_name}".format(log_file_name = log_file_name)
    repo_ctx.file(log_file_path, result_str)

  if should_fail and res.return_code:
    fail("Failed: {result_str}". format(result_str))

  return res, result_str
