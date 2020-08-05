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
load("//rules_ruby_gapic:private/providers.bzl", "RubyLibraryInfo", "RubyContext")

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

  # Grabbing the RubyContext and extracting the binary from it
  ruby_context = ctx.attr.ruby_context[RubyContext]
  ruby_bin = ruby_context.bin
  ruby_bin_path = ruby_bin.path
  ruby_bin_dirpath = ruby_bin.dirname
  ruby_all_bins = ruby_context.all_bins

  run_log_text += "\nruby_bin_path={ruby_bin_path}".format(ruby_bin_path = ruby_bin_path)
  run_log_text += "\nruby_bin_dirpath={ruby_bin_dirpath}".format(ruby_bin_dirpath = ruby_bin_dirpath)

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

  # bundler
  bundler_bin_path = ruby_bin_dirpath + "/bundler"
  run_log_text += "\nbundler_bin_path={bundler_bin_path}".format(bundler_bin_path = bundler_bin_path)

  # gemfile
  gemfile_path = ctx.file.gemfile.path
  gemfile_tmp_file = ctx.actions.declare_file("Gemfile")
  gemfile_tmp_path = gemfile_tmp_file.path

  run_log_text += "\ngemfile_path={gemfile_path}".format(gemfile_path = gemfile_path)
  run_log_text += "\ngemfile_tmp_path={gemfile_tmp_path}".format(gemfile_tmp_path = gemfile_tmp_path)

  ctx.actions.run_shell(
    inputs = [ctx.file.gemfile],
    command="cp {gemfile} {gemfile_tmp}".format(gemfile = gemfile_path, gemfile_tmp = gemfile_tmp_path), 
    outputs=[gemfile_tmp_file])

  # gemspec
  gemspec_path = ctx.file.gemspec.path
  gemspec_tmp_file = ctx.actions.declare_file("gapic-generator.gemspec")
  gemspec_tmp_path = gemspec_tmp_file.path

  run_log_text += "\ngemspec_path={gemspec_path}".format(gemspec_path = gemspec_path)
  run_log_text += "\ngemspec_tmp_path={gemspec_tmp_path}".format(gemspec_tmp_path = gemspec_tmp_path)

  ctx.actions.run_shell(
    inputs = [ctx.file.gemspec],
    command="cp {gemspec} {gemspec_tmp}".format(gemspec = gemspec_path, gemspec_tmp = gemspec_tmp_path), 
    outputs=[gemspec_tmp_file])

  # bundler gemfile export
  bundler_export = "export HOME=/tmp/{newline}export BUNDLE_GEMFILE={gemfile_tmp_path}{newline}export BUNDLE_GEMFILE_LOCKFILE=/tmp/foo.lock".format(newline = "\n", gemfile_tmp_path = gemfile_tmp_path)
  run_log_text += "\nbundler_export={bundler_export}".format(bundler_export = bundler_export)

  # the actual command: a ruby binary invocation of the entrypoint file with the correct imports
  cmd_text = """{bundler} exec {ruby} -W0 -I {src_dir} {imports} {entrypoint}""".format(
    bundler = bundler_bin_path,
    ruby = ruby_bin_path,
    src_dir = src_base_path,
    imports = import_paths_string,
    entrypoint = entrypoint_path)

  run_log_text += "\ncmd_text={cmd_text}".format(cmd_text = cmd_text)
  ctx.actions.write(run_log_file, run_log_text)

  # the command text is prepended by some gapic-generator-ruby requirements:
  # * a path to a folder with the ruby binaries so that gapic-generator-ruby can systemcall rubocop
  # * an XDG_CACHE_HOME env var export so that the rubocop won't frivolously fail
  # * LANG & LANGUAGE env var exports so that the rails templating engine is satisfied
  #
  # then the actual command follows 
  #
  exec_text = "#!/bin/bash{newline}export PATH=$PATH:{ruby_bin_dirpath}{newline}export XDG_CACHE_HOME=/tmp{newline}export LANG=en_US.UTF-8{newline}export LANGUAGE=en_US:en{newline}{bundler_export}{newline}{cmd_text}{newline}".format(
    newline = "\n",
    bundler_export = bundler_export,
    cmd_text = cmd_text,
    ruby_bin_dirpath = ruby_bin_dirpath,
  )

  # write the shellscript into the result file
  ctx.actions.write(run_result_file, exec_text)

  # collect everything that can be useful in a result
  direct = ctx.files.srcs[:]
  direct.append(run_result_file)
  direct.append(run_log_file)
  direct.append(gemfile_tmp_file)
  direct.append(gemspec_tmp_file)
  direct.append(ruby_bin)
  direct = direct + ruby_all_bins

  # Everything goes into the runfiles since that's how bazel knows to simlink the files around the shellscript file
  runfiles = ctx.runfiles(files=[run_result_file, gemfile_tmp_file, gemspec_tmp_file, ruby_bin] + ruby_all_bins + ctx.files.srcs)

  return [DefaultInfo(
    files = depset(direct=direct),
    runfiles = runfiles,
    executable = run_result_file,
  )]

##
# A rule that takes a ruby application and wraps it into a bazel-runnable shellscript
# Defines an executable target 
#
ruby_bundler_binary = rule(
  _ruby_bundler_binary_impl,
  attrs = {
    "srcs": attr.label_list(allow_files = True),
    "src_base": attr.label(allow_single_file=True),
    "ruby_context": attr.label(default = Label("//rules_ruby_gapic/ruby:ruby_context")),
    "gemfile": attr.label(allow_single_file = True),
    "gemspec": attr.label(allow_single_file = True),
    "entrypoint": attr.label( allow_single_file = True),
    "deps": attr.label_list(
      providers = [RubyLibraryInfo],
    ),
  },
  executable = True,
)
