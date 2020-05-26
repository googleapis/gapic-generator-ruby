"""
"""
load("//rules_ruby_gapic:private/providers.bzl", "RubyLibraryInfo", "RubyContext")

def _ruby_binary_impl(ctx):
  print("==========================================")
  print("=! building ruby binary")  
  print("= {cname}".format(cname = ctx.attr.name))
  print("---------------------")

  # the result of our invocation is dumped into this file
  run_result_file_path = "{name}".format(name = ctx.label.name)
  run_result_file = ctx.actions.declare_file(run_result_file_path)

  # entrypoint for our Ruby application
  entrypoint_dir = ctx.file.entrypoint.dirname
  entrypoint_path = ctx.file.entrypoint.path

  #~
  # Grabbing the RubyContext and extracting the binary from it
  ruby_context = ctx.attr.ruby_context[RubyContext]
  ruby_bin = ruby_context.bin
  ruby_bin_path = ruby_bin.path

  # Same dependency also contains the Ruby StandardLibrary info packaged as RubyLibraryInfo
  ruby_standard_lib = ctx.attr.ruby_context[RubyLibraryInfo]

  #~
  # All dependencies combined form the depset
  deps = [ruby_standard_lib] + [dep[RubyLibraryInfo] for dep in ctx.attr.deps]
  deps_set = depset(
    direct = [d.info for d in deps],
    transitive = [d.deps for d in deps],
  )

  # From this depset we extract two things:
  # 1. We take all the lib directories and ext directories and add them to the path
  deps_import_strings = ["-I " + entrypoint_dir]
  for dep in deps_set.to_list():
    deps_import_strings.append("-I " + dep.lib_path.dirname)
    if dep.ext_path:
      deps_import_strings.append("-I " + dep.ext_path.dirname)
  import_paths_string = " ".join(deps_import_strings)

  # 2. all the library files join the program sources in the set of inputs
  all_inputs = ctx.files.srcs[:]
  all_inputs.append(ctx.file.entrypoint)
  for dep in deps_set.to_list():
    all_inputs = all_inputs + dep.srcs  

  #~
  # now we can run the application
  ctx.actions.run_shell(
    tools = [ruby_bin], 
    inputs = all_inputs,
    command="{ruby_bin} -W0 -I $(pwd) {imports} {entrypoint} > {ruby_run_result}".format(
      ruby_bin = ruby_bin_path, 
      imports = import_paths_string, 
      entrypoint = entrypoint_path,
      ruby_run_result = run_result_file.path), 
    outputs=[run_result_file])

  # exec_text = """#!/bin/bash\n{ruby_bin} {import_path} {entrypoint}""".format(ruby_bin = ctx.file.ruby_bin.path, import_path = import_path, entrypoint = ctx.file.entrypoint.path)
  # ctx.actions.write(executable, exec_text)

  direct = ctx.files.srcs[:]
  direct.append(run_result_file)

  return [DefaultInfo(
    files = depset(direct=direct),
    executable = run_result_file,
  )]

ruby_binary = rule(
  _ruby_binary_impl,
  attrs = {
    "srcs": attr.label_list(allow_files = True),
    "ruby_context": attr.label(default = Label("//rules_ruby_gapic/ruby:ruby_context")),
    "entrypoint": attr.label( allow_single_file = True),
    "deps": attr.label_list(
      providers = [RubyLibraryInfo],
    ),
  },
  # executable = True,
)