# API Client Generator for Ruby

Create Ruby clients from a protocol buffer description of an API.

This code is used to generate client libraries for many Google APIs including
Cloud and Ads services. The `gapic-generator` gem itself includes the main
generator, whereas the `gapic-generator-cloud` and `gapic-generator-ads` gems
provide modifications specific to Google Cloud and Google Ads APIs.

These gems can also be used to create clients for any other API, for Google or
non-Google services, that use protocol buffers as the description language. The
generators will work best for APIs that follow the design guidance documented
in the [Google AIPs](https://aip.dev/). An API that is not AIP-compliant should
still yield a usable client library, but it may be missing features such as
idiomatic naming, pagination, or retry configuration.

**Important:** This is not an official Google project. While it is being used
internally to generate official Google API client libraries, there is no
guarantee of support or stability for any other use.

## Using the Ruby gem

This section provides a brief getting started guide for the Ruby gem. However,
we do not release the Ruby gems often, and they may be substantially behind the
current generator code. In most cases, we recommend generating from the
GitHub repository directly. See the main README for
https://github.com/googleapis/gapic-generator-ruby for more information.

### Install the Generator

The generator is a plugin for **protoc**, the protocol buffers compiler, so
you'll need to install it first, along with the standard protobuf and grpc
plugins for Ruby. The easiest way to do this is to install the `grpc-tools` gem
which will provide all three. You can also follow the
[official install instructions](https://github.com/protocolbuffers/protobuf#protobuf-compiler-installation).
Note that if you installed protoc using `grpc-tools`, the compiler binary name
will be named `grpc_tools_ruby_protoc`; otherwise it will likely be `protoc`.

Install the `gapic-generator` gem to get access to the gapic generator plugin.
Since you are looking at the `gapic-generator-cloud` gem's README, we will
assume you want Cloud-specific output, so also install `gapic-generator-cloud`.

Alternatively, add all the above to a Gemfile:

```ruby
# Gemfile
source "https://rubygems.org/"

gem "grpc-tools"
gem "gapic-generator"
gem "gapic-generator-cloud"
```

And install using bundler:

```sh
$ bundle install
```

### Generate an API

Installing the cloud-specific generator exposes `protoc-gen-ruby_cloud` on the
PATH. (Note that this name is different from the `protoc-gen-ruby_gapic` plugin
exposed by the basic generator.) By doing so, it gives the protobuf compiler
the CLI option `--ruby_cloud_out` on which you can specify an output path for
this generator.

In most cases, in order to generate a functional client library, you must also
include the Ruby proto and grpc plugins, using the CLI options `--ruby_out` and
`--grpc_out`.

If you want to experiment with an already-existing API, you can use one of the
existing Google APIs from https://github.com/googleapis/googleapis.
First you should get the protos and dependencies:

```sh
$ git clone git@github.com:googleapis/googleapis.git
```

Now you're ready to compile the API. For example, to compile the Vision V1 API:

```sh
$ grpc_tools_ruby_protoc google/cloud/vision/v1/*.proto \
    --proto_path=googleapis/ \
    --ruby_out=/path/to/dest/ \
    --grpc_out=/path/to/dest/ \
    --ruby_cloud_out=/path/to/dest/ \
```

Note: most real-world client libraries require additional options to be passed
to the generator, via the `--ruby_cloud_opt` flag. Those options are not
covered in this document.

## Support

This is not an official Google project. While it is being used internally to
generate official Google API client libraries, there is no guarantee of support
or stability for any other use.

As of January 2024, this generator can be run on Ruby 3.0 or later. In general,
we will make an effort to ensure it is supported on non-end-of-life versions of
Ruby.

Issues can be filed on GitHub at
https://github.com/googleapis/gapic-generator-ruby/issues.
