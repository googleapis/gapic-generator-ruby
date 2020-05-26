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
