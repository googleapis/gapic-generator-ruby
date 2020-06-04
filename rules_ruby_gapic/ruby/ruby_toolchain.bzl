def _ruby_toolchain_impl():
  ruby_bin = ctx.executable.ruby_bin
  ruby_gem = ctx.executable.ruby_gem
  
  return [platform_common.ToolchainInfo(
    compile = ruby_bin,
    
    internal = struct(
      ruby_gem = ruby_gem,
      tools = ctx.files.tools,
      std_lib = ctx.files.std_lib
    ),
  )]

ruby_toolchain = rule(
  _ruby_toolchain_impl,
  attrs = {
    "ruby_bin": attr.label(
      mandatory = True,
      executable = True,
      cfg = "host",
      doc = "ruby interpreter",
    ),
    "ruby_gem": attr.label(
      mandatory = True,
      executable = True,
      cfg = "host",
      doc = "rubygems package manager",
    ),
    "tools" : attr.label_list(
      mandatory = True, 
      doc = "all executables from ruby runtime",
    ),
    "std_lib": attr.label_list(
      mandatory = True,
      doc = "Ruby standard library",
    ),
  },
  doc = "Gathers executables and file lists needed for Ruby toolchain"
)