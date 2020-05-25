"""
exercicing the binaries of ruby sources
kicking the tires with the --version
"""

def _check_ruby_gemver_impl(ctx):
  # declare the output of our rule,
  dec_file = ctx.actions.declare_file(ctx.attr.name)
  
  # note that the shell comand must be written in terms of dependencies and results
  ctx.actions.run_shell(
    tools = [ctx.file.dependency], 
    command="{gem} --version > {gem_result}".format(gem = ctx.file.dependency.path, gem_result = dec_file.path), 
    outputs=[dec_file])
  
  # end result of our rule with one file that we have declared
  return [DefaultInfo(files=depset(direct=[dec_file]))]

##
# Executing a --version over a binary file (gem) that is present 
# in the archive with the ruby sources.
# Does not need the sources to be built but currently there is no alternative.
#
check_ruby_gemver = rule(
  implementation = _check_ruby_gemver_impl,
  attrs = {
    "dependency": attr.label(
      default = Label("@ruby_runtime//:bin/gem"),
      allow_single_file = True,
      executable = True,
      cfg = "host",
    )
  }
)
