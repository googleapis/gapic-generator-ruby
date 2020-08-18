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

##
# A main file for a small application that is used to check that bazel
# can run ruby apps via bundler when the apps in question are making system() calls
# to a ruby gemfile's binstubs, e.g. rubocop
#

require "rainbow"
require "tmpdir"

file_content = "none"
rubocop_out_content = "none"
Dir.mktmpdir do |dir|
  tmp_file = File.join dir, "foo.rb"
  FileUtils.mkdir_p File.dirname tmp_file
  File.write tmp_file, "p 'foo'"

  rubocop_result = system "rubocop --cache false -x #{dir} -o #{dir}/rubocop.out"
  rubocop_retcode = $?.exitstatus
  fail "rubocop formatting invocation failed, exit code #{rubocop_retcode}\ncheck the stderr for the error messages" unless rubocop_result

  file_content = File.read tmp_file
  rubocop_out_content = File.read "#{dir}/rubocop.out"
end

puts Rainbow(file_content).red + " and " + Rainbow("yellow bg").bg(:yellow) + " and " + Rainbow(rubocop_out_content).underline.bright
