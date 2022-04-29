# frozen_string_literal: true

# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

flag :git_remote, "--remote=NAME" do
  desc "The name of the git remote to use as the pull request head. If omitted, does not open a pull request."
end

include :fileutils
include :exec, e: true
include "yoshi-utils"

def run
  Dir.chdir context_directory
  yoshi_utils.git_ensure_identity
  git_unshallow
  cur_version = determine_cur_version
  if found_tag cur_version
    logger.info "Current version #{cur_version} already has a tag. Nothing to do."
    exit
  end
  logger.info "Current version #{cur_version} needs a tag."
  tag_version cur_version
end

def git_unshallow
  if capture(["git", "rev-parse", "--is-shallow-repository"]).strip == "true"
    exec ["git", "fetch", "--unshallow"]
  end
  exec ["git", "fetch", "--tags"]
end

def determine_cur_version
  func = proc do
    Dir.chdir "gapic-generator" do
      spec = Gem::Specification.load "gapic-generator.gemspec"
      puts spec.version
    end
  end
  capture_proc(func).strip
end

def tag_name version, name = "gapic-generator"
  "#{name}/v#{version}"
end

def found_tag version
  !capture(["git", "tag", "--list", tag_name(version)]).strip.empty?
end

def tag_version version
  tag1 = tag_name version
  tag2 = tag_name version, "gapic-generator-ads"
  tag3 = tag_name version, "gapic-generator-cloud"
  exec ["git", "tag", tag1]
  exec ["git", "tag", tag2]
  exec ["git", "tag", tag3]
  exec ["git", "push", git_remote, tag1, tag2, tag3] if git_remote
end
