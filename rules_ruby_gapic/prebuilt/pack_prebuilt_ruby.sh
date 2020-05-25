mkdir -p /tmp/pack_prebuilt_ruby/ruby-2.6.6
rm -rf /tmp/pack_prebuilt_ruby/ruby-2.6.6/*

pushd /tmp/pack_prebuilt_ruby/
cp -r ~/src/gapic-generator-ruby/bazel-gapic-generator-ruby/external/ruby_runtime/* ./ruby-2.6.6/

rm BUILD.bazel
rm WORKSPACE
rm *.bzl

tar -czf ruby-2.6.6_linux_x86_64.tar.gz ruby-2.6.6/bin ruby-2.6.6/lib ruby-2.6.6/include
cp ./ruby-2.6.6_linux_x86_64.tar.gz ~/src/gapic-generator-ruby/rules_ruby_gapic/prebuilt/
popd