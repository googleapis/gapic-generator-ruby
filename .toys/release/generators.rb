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
include "yoshi-pr-generator"

def run
  Dir.chdir context_directory
  yoshi_utils.git_ensure_identity
  git_unshallow
  analyze
  branch_name = "release-generators-#{@release_timestamp}"
  message = "release: gapic-generator #{@new_version}"
  pr_body = <<~BODY
    This #{@new_version} release of the Ruby GAPIC Generators has been requested.

    To perform this release, check the changelogs and update if necessary. Then approve and merge this pull request.
    The release will be tagged automatically by a separate GitHub Action.
 
    To abort this release, simply close this pull request without merging.
  BODY
  result = yoshi_pr_generator.capture enabled: !git_remote.nil?,
                                      remote: git_remote,
                                      branch_name: branch_name,
                                      pr_body: pr_body,
                                      commit_message: message do
    prepare_changes
  end
end

def git_unshallow
  if capture(["git", "rev-parse", "--is-shallow-repository"]).strip == "true"
    exec ["git", "fetch", "--unshallow"]
  end
  exec ["git", "fetch", "--tags"]
end

def analyze
  now = Time.now
  @release_date = now.strftime "%Y-%m-%d"
  @release_timestamp = now.strftime "%Y%m%d-%H%M%S"
  @old_version = determine_old_version
  bump, @base_messages, @ads_messages, @cloud_messages = analyze_commits @old_version
  @new_version = bump_version @old_version, bump
  @ads_messages = ["* Includes changes from gapic-generator #{@new_version}"] + @ads_messages
  @cloud_messages = ["* Includes changes from gapic-generator #{@new_version}"] + @cloud_messages
end

def prepare_changes
  update_version_file "gapic-generator/lib/gapic/generator/version.rb", @new_version
  update_version_file "gapic-generator-ads/lib/gapic/generator/ads/version.rb", @new_version
  update_version_file "gapic-generator-cloud/lib/gapic/generator/cloud/version.rb", @new_version
  update_changelog_file "gapic-generator/CHANGELOG.md", @base_messages, @new_version, @release_date
  update_changelog_file "gapic-generator-ads/CHANGELOG.md", @ads_messages, @new_version, @release_date
  update_changelog_file "gapic-generator-cloud/CHANGELOG.md", @cloud_messages, @new_version, @release_date
  update_bundles
end

def determine_old_version
  func = proc do
    Dir.chdir "gapic-generator" do
      spec = Gem::Specification.load "gapic-generator.gemspec"
      puts spec.version
    end
  end
  capture_proc(func).strip
end

def analyze_commits old_version
  bump = 2
  base_messages = []
  ads_messages = []
  cloud_messages = []
  shas = capture ["git", "log", "gapic-generator/v#{old_version}..HEAD", "--format=%H"]
  shas.split("\n").reverse_each do |sha|
    include_base = include_ads = include_cloud = false
    files = capture ["git", "diff", "--name-only", "#{sha}^..#{sha}"]
    files.split("\n").each do |file|
      include_base = true if file.start_with? "gapic-generator/"
      include_ads = true if file.start_with? "gapic-generator-ads/"
      include_cloud = true if file.start_with? "gapic-generator-cloud/"
    end
    next unless include_base || include_ads || include_cloud
    message_bump, message = analyze_message capture ["git", "log", "#{sha}^..#{sha}", "--format=%B"]
    next unless message
    base_messages << message if include_base
    ads_messages << message if include_ads
    cloud_messages << message if include_cloud
    bump = message_bump if message_bump < bump
  end
  [bump, base_messages, ads_messages, cloud_messages]
end

def analyze_message message
  case message.strip
  when /^(?:feat|fix)(?:\([\w-]+\))?!: (.+)$/
    [1, format_message("BREAKING CHANGE", Regexp.last_match[1])]
  when /^feat(?:\([\w-]+\))?: (.+)$/
    [1, format_message("Feature", Regexp.last_match[1])]
  when /^fix(?:\([\w-]+\))?: (.+)$/
    [2, format_message("Fix", Regexp.last_match[1])]
  else
    [3, nil]
  end
end

def format_message type, message
  message = message.sub /\s+\(#\d+\)$/, ""
  "* #{type}: #{message}"
end

def bump_version old_version, bump
  parts = old_version.split(".").map(&:to_i)
  parts[bump] += 1
  ((bump+1)...3).each { |i| parts[i] = 0 }
  parts.join "."
end

def update_version_file path, new_version
  content = File.read path
  content.sub!(/VERSION = "\d+\.\d+\.\d+"/, "VERSION = \"#{new_version}\"")
  File.open path, "w" do |file|
    file.write content
  end
end

def update_changelog_file path, messages, new_version, new_date
  content = File.read path
  messages = ["No significant changes"] if messages.empty?
  release_content = <<~CONTENT
    ### #{new_version} / #{new_date}

    #{messages.join "\n"}
  CONTENT
  content.sub! /\A(# [^\n]+)\n+/, "\\1\n\n#{release_content}\n"
  File.open path, "w" do |file|
    file.write content
  end
end

def update_bundles
  exec ["bundle", "update"]
  exec ["bundle", "update"], chdir: "gapic-generator"
  exec ["bundle", "update"], chdir: "gapic-generator-ads"
  exec ["bundle", "update"], chdir: "gapic-generator-cloud"
end
