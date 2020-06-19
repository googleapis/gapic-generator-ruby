"""
"""
load("//rules_ruby_gapic:private/providers.bzl", "RubyLibraryInfo", "RubyContext")

def _ruby_binary_impl(ctx):
  print("==========================================")
  print("=! building ruby binary")  
  print("= {cname}".format(cname = ctx.attr.name))
  print("---------------------")

  src_dir = ctx.actions.declare_directory("src")
  src_base_path = ctx.file.src_base.path

  command = "cp -r {src_base_path}/* {src_dir}".format(
    src_base_path = src_base_path,
    src_dir = src_dir.path
  )

  ctx.actions.run_shell(
    inputs = ctx.files.srcs,
    outputs = [src_dir],
    command = command,
  )

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
  deps_strings = [entrypoint_dir]
  for dep in deps_set.to_list():
    deps_strings.append(dep.lib_path.dirname)
    if dep.ext_path:
      deps_strings.append(dep.ext_path.dirname)

  import_paths_string = "-I " + " -I ".join(deps_strings)

  # 2. all the library files join the program sources in the set of inputs
  all_inputs = ctx.files.srcs[:]
  all_inputs.append(ctx.file.entrypoint)
  for dep in deps_set.to_list():
    all_inputs = all_inputs + dep.srcs  

  # echo_import_command = "echo -n '-I '$(readlink -f " + ")' ' >> {ruby_run_result}; echo -n '-I '$(readlink -f ".join(deps_strings) +")' ' >> {ruby_run_result};"
  # echo_import_command = echo_import_command.format(
  #   ruby_run_result = run_result_file.path,
  # )
  # command="echo -n $(readlink -f {ruby_bin}) > {ruby_run_result}; echo -n ' -W0 ' >> {ruby_run_result}; {echo_import_command} echo $(readlink -f {entrypoint}) >> {ruby_run_result}".format(
  #   ruby_bin = ruby_bin_path, 
  #   echo_import_command = echo_import_command, 
  #   entrypoint = entrypoint_path,
  #   ruby_run_result = run_result_file.path)

  # print(command)

  #~
  # now we can run the application
  # ctx.actions.run_shell(
  #   tools = [ruby_bin], 
  #   inputs = all_inputs,
  #   command = command, 
  #   outputs=[run_result_file],
  #   execution_requirements = {
  #     "no-sandbox": "1",
  #     "no-cache": "1",
  #     "no-remote": "1",
  #     "local": "1",
  #   },)

  exec_text = """tree;{ruby_bin} -W0 -I {src_dir} {imports} {entrypoint}
""".format(
      src_dir = src_dir.path,
      ruby_bin = ruby_bin_path, 
      imports = import_paths_string, 
      entrypoint = entrypoint_path)

  ctx.actions.write(run_result_file, exec_text)

  direct = ctx.files.srcs[:]
  direct.append(run_result_file)
  direct.append(ruby_bin)

  runfiles = ctx.runfiles(files=[run_result_file, ruby_bin] + ctx.files.srcs)

  return [DefaultInfo(
    files = depset(direct=direct),
    runfiles = runfiles,
    executable = run_result_file,
  )]

ruby_binary = rule(
  _ruby_binary_impl,
  attrs = {
    "srcs": attr.label_list(allow_files = True),
    "src_base": attr.label(allow_single_file=True),
    "ruby_context": attr.label(default = Label("//rules_ruby_gapic/ruby:ruby_context")),
    "entrypoint": attr.label( allow_single_file = True),
    "deps": attr.label_list(
      providers = [RubyLibraryInfo],
    ),
  },
  executable = True,
)