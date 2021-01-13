# Release History for Bazel-Ruby rules and examples

### 2021-01-13

* GEM_HOME and GEM_PATH environment variables when set on the host system no longer break Bazel-Ruby rules
* Parameter parsing no longer escapes the '=' since it is no longer has a special use in the gapic-generator parameters
* some examples in the bazel_example has been updated to reflect new human-readable parameters available for gapic-generator-cloud
