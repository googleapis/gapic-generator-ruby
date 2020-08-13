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
