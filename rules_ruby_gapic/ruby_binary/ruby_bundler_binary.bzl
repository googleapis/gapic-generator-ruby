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
Defines a rule that wraps a ruby application into a shellscript, executable by bazel
"""
load("//rules_ruby_gapic:private/providers.bzl", "RubyLibraryInfo", "RubyRuntimeInfo", "BundledInstallInfo")

##
# An implementation for ruby_binary rule
#
def _ruby_bundler_binary_impl(ctx):
  src_base_path = ctx.file.src_base.path

  # the shellscript file that calls the ruby application
  run_result_file_path = "{name}".format(name = ctx.label.name)
  run_result_file = ctx.actions.declare_file(run_result_file_path)

  run_log_file_path = "{name}.log".format(name = ctx.label.name)
  run_log_file = ctx.actions.declare_file(run_log_file_path)
  run_log_text = ""

  # entrypoint for our Ruby application
  entrypoint_dir = ctx.file.entrypoint.dirname
  entrypoint_path = ctx.file.entrypoint.path

  run_log_text += "\nentrypoint_dir={entrypoint_dir}".format(entrypoint_dir = entrypoint_dir)
  run_log_text += "\nentrypoint_path={entrypoint_path}".format(entrypoint_path = entrypoint_path)

  # Grabbing the RubyRuntimeInfo and extracting the binary from it
  ruby_context = ctx.attr.ruby_context[RubyRuntimeInfo]
  ruby_bin = ruby_context.bin
  ruby_bin_path = ruby_bin.path
  ruby_bin_dirpath = ruby_bin.dirname
  bundle_bin = ruby_context.bundle_bin
  bundle_bin_path = bundle_bin.path
  
  ruby_all_bins = ruby_context.all_bins

  run_log_text += "\nruby_bin_path={ruby_bin_path}".format(ruby_bin_path = ruby_bin_path)
  run_log_text += "\nruby_bin_dirpath={ruby_bin_dirpath}".format(ruby_bin_dirpath = ruby_bin_dirpath)
  run_log_text += "\nbundle_bin_path={bundle_bin_path}".format(bundle_bin_path = bundle_bin_path)

  # Same dependency also contains the Ruby StandardLibrary info packaged as RubyLibraryInfo
  ruby_standard_lib = ctx.attr.ruby_context[RubyLibraryInfo]

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

  run_log_text += "\nimport_paths_string={import_paths_string}".format(import_paths_string = import_paths_string) 

  # 2. all the library files join the program sources in the set of inputs
  all_inputs = ctx.files.srcs[:]
  all_inputs.append(ctx.file.entrypoint)
  for dep in deps_set.to_list():
    all_inputs = all_inputs + dep.srcs  

  # Now grabbing the bundled context to get the files of the bundle install
  bundled_context = ctx.attr.bundled_context[BundledInstallInfo]
  gemfile = bundled_context.gemfile
  all_bundled_files = bundled_context.all_bundled_files
  all_inputs = all_inputs + all_bundled_files

  # gemfile
  gemfile_path = gemfile.path
  run_log_text += "\ngemfile_path={gemfile_path}".format(gemfile_path = gemfile_path)

  bundle_rel_path = ctx.attr._bundle_rel_path
  run_log_text += "\nbundle_rel_path={bundle_rel_path}".format(bundle_rel_path = bundle_rel_path)

  # bundle gemfile export
  bundle_export_lines = [
    "export HOME=/tmp/",
    "export BUNDLE_GEMFILE={gemfile_path}".format(gemfile_path = gemfile_path),
    "export BUNDLE_DEPLOYMENT=true",
    "export BUNDLE_PATH={bundle_rel_path}".format(bundle_rel_path = "bundle"),
  ]
  bundle_export = "\n".join(bundle_export_lines)
  run_log_text += "\nbundle_export={bundle_export}".format(bundle_export = bundle_export)

  # the actual command: a ruby binary invocation of the entrypoint file with the correct imports
  cmd_text = """{bundle} exec {ruby} -W0 -I {src_dir} {imports} {entrypoint}""".format(
    bundle = bundle_bin_path,
    ruby = ruby_bin_path,
    src_dir = src_base_path,
    imports = import_paths_string,
    entrypoint = entrypoint_path)

  run_log_text += "\ncmd_text={cmd_text}".format(cmd_text = cmd_text)
  ctx.actions.write(run_log_file, run_log_text+"\n")

  # the command text is prepended by some gapic-generator-ruby requirements:
  # * a path to a folder with the ruby binaries so that gapic-generator-ruby can systemcall `rubocop`
  # * an XDG_CACHE_HOME env var export so that the rubocop won't frivolously fail
  # * LANG & LANGUAGE env var exports so that the rails templating engine is satisfied
  #
  # then the actual command follows 
  #
  path_command = "export PATH={ruby_bin_dirpath}".format(ruby_bin_dirpath = ruby_bin_dirpath)
  shell_script_lines = [
    "#!/bin/bash",
    path_command,
    "export XDG_CACHE_HOME=/tmp",
    "export LANG=en_US.UTF-8",
    "export LANGUAGE=en_US:en",
    bundle_export,
    cmd_text
  ]
  exec_text = "\n".join(shell_script_lines)

  # write the shellscript into the result file
  ctx.actions.write(run_result_file, exec_text)

  # things that need to be symlinked around the shell script go into the runfiles
  runfiles = ruby_all_bins + ctx.files.srcs + all_bundled_files + [
    gemfile,
  ]

  # collect everything that can be useful in a result
  direct = runfiles + [run_result_file, run_log_file]

  # Everything goes into the runfiles since that's how bazel knows to simlink the files around the shellscript file
  runfiles = ctx.runfiles(files=runfiles)

  return [DefaultInfo(
    files = depset(direct=direct),
    runfiles = runfiles,
    executable = run_result_file,
  )]

##
# A rule that takes a ruby application and wraps it into a bazel-runnable shellscript
# Defines an executable target. Uses bundler to execute
#
ruby_bundler_binary = rule(
  _ruby_bundler_binary_impl,
  attrs = {
    "srcs": attr.label_list(allow_files = True),
    "src_base": attr.label(allow_single_file=True),
    "ruby_context": attr.label(),
    "bundled_context": attr.label(),
    "entrypoint": attr.label( allow_single_file = True),
    "deps": attr.label_list(
      providers = [RubyLibraryInfo],
    ),
    "_bundle_rel_path": attr.string(default = "bundle")
  },
  executable = True,
)
