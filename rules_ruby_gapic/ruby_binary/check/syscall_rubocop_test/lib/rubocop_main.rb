require 'rainbow'
require 'tmpdir'

file_content = 'none'
Dir.mktmpdir do |dir|
  tmp_file = File.join dir, "foo.rb"
  FileUtils.mkdir_p File.dirname tmp_file
  File.write tmp_file, "p 'foo'"

  rubocop_result = system "rubocop --cache false -x #{dir} -o #{dir}/rubocop.out"
  rubocop_retcode = $?.exitstatus
  fail "rubocop formatting invocation failed, exit code #{rubocop_retcode}\ncheck the stderr for the error messages" unless rubocop_result

  file_content = File.read tmp_file
end

puts Rainbow("this is red").red + " and " + Rainbow("this on yellow bg").bg(:yellow) + " and " + Rainbow(file_content).underline.bright
