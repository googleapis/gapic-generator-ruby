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
Creates a workspace that installs bundled gems for the bundle execution later
"""
load(
  ":private/utils.bzl",
  _execute_log_action = "execute_log_action",
)

def _bundle_install(repo_ctx):
  bundle_install_path = None
  gemfile_path = None
  gemfile_sel_log = "Not found"

  copy_log = []
  for label, relpath in repo_ctx.attr.gemfile_srcs.items():
    orig_file_path = repo_ctx.path(label)
    file_path = repo_ctx.path("./export/{relpath}".format(relpath = relpath))
    repo_ctx.file(file_path, "") # this create the folder structure like mkdir -p
    res, log = _execute_log_action(repo_ctx, None, 
      ["cp", "%s" % orig_file_path, "%s" % file_path]
    )
    copy_log.append(log)

    if label == repo_ctx.attr.gemfile:
      gemfile_sel_log = ""
      gemfile_path =  file_path
      gemfile_sel_log += "gemfile_path={gemfile_path}\n".format(gemfile_path = gemfile_path)
      
      gemfile_dir = gemfile_path.dirname
      bundle_install_path = repo_ctx.path("{gemfile_dir}/bundle".format(gemfile_dir = gemfile_dir))
      gemfile_sel_log += "bundle_install_path={bundle_install_path}\n".format(bundle_install_path = bundle_install_path)

  repo_ctx.file("logs/copy_gemfile_srcs.log", "---\n---".join(copy_log)+"\n")
  repo_ctx.file("logs/gemfile_selection.log", gemfile_sel_log)

  home_fname = repo_ctx.path("./home/foo")
  repo_ctx.file("home/foo", content ="")
  home_path = home_fname.dirname

  bundle_bin = repo_ctx.attr.bundle_bin
  bundle_bin_path = repo_ctx.path(bundle_bin)

  # Now create a file that will run the bundler update
  # it has to delete the files and folders with spaces in their names or bazel runfile linking won't work 
  # https://github.com/bazelbuild/bazel/issues/4327
  sh_path = repo_ctx.path("bundle_install.sh")
  repo_ctx.template(
    sh_path.basename,
    repo_ctx.attr._bundle_install_tpl,
    substitutions = {
      "{bundle}": "%s" % bundle_bin_path,
    },
    executable = True,
  )

  repo_ctx.report_progress("Running bundle install on %s" % gemfile_path)
  _execute_log_action(repo_ctx, "bundle_install.log", ["%s" % sh_path], environment = {
    "HOME": "%s" % home_path, # otherwise the local user's home will get contaminated
    "BUNDLE_JOBS": "8",
    "BUNDLE_RETRY": "3",
    "BUNDLE_GEMFILE": "%s" % gemfile_path,
    "BUNDLE_DEPLOYMENT": "true", # put the gems all in one folder
    "BUNDLE_PATH": "%s" % bundle_install_path, # and this is the folder where to put them
  })
  
  repo_ctx.report_progress("Running bundle list on %s" % gemfile_path)
  _execute_log_action(repo_ctx, "bundle_list.log", ["%s" % bundle_bin_path, "list"], environment = {
    "HOME": "%s" % home_path, # otherwise the local user's home will get contaminated
    "BUNDLE_GEMFILE": "%s" % gemfile_path,
    "BUNDLE_DEPLOYMENT": "true", # put the gems all in one folder
    "BUNDLE_PATH": "%s" % bundle_install_path, # and this is the folder where to put them
  })

  repo_ctx.template("BUILD.bazel", repo_ctx.attr._build_tpl,)

bundle_install = repository_rule(
  implementation = _bundle_install,
  attrs = {
    "bundle_bin": attr.label(
      mandatory = True,
      allow_single_file = True,
    ),
    "gemfile": attr.label(
      mandatory = True,
      allow_single_file = True,
    ),
    "gemfile_lock": attr.label(
      mandatory = True,
      allow_single_file = True,
    ),
    "gemfile_srcs": attr.label_keyed_string_dict(
      mandatory = False,
    ),
    "_bundle_install_tpl": attr.label(
      default = ":templates/bundle_install.sh.tpl"
    ),
    "_build_tpl": attr.label(
      default = ":templates/BUILD.bundle.bazel.tpl"
    ),
  },
)
