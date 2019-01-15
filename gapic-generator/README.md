# API Client Generator for Ruby

Create Ruby clients from a protocol buffer description of an API.

**Note** This project is a preview. Please try it out and let us know what you think,
but there are currently no guarantees of stability or support.

## Usage
### Install the Proto Compiler
This generator relies on the Protocol Buffer Compiler to [orchestrate] the
client generation.

```sh
# Declare the protobuf version to use.
$ export PROTOBUF_VERSION=3.6.1

# Declare the target installation system.
# export SYSTEM=osx
$ export SYSTEM=linux

# Get the precompiled protobuf compiler.
$ curl --location https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip > usr/src/protoc/protoc-${PROTOBUF_VERSION}.zip
$ cd /usr/src/protoc/
$ unzip protoc-${PROTOBUF_VERSION}.zip
$ rm protoc-${PROTOBUF_VERSION}.zip

# Link the protoc to the path.
$ ln -s /usr/src/protoc/bin/protoc /usr/local/bin/protoc
$ mkdir -p /protos/

# Move the common protobuf files to the local include folder.
$ cp -R /usr/src/protoc/include/* /usr/local/include/
```

[orchestrate]: https://developers.google.com/protocol-buffers/docs/reference/ruby-generated

### Build and Install the Generator
This tool is in pre-alpha so it is not yet released to RubyGems. You will have to
build the generator from scratch. Building the gem requires the proto compiler to be installed
as shown in the previous section.

```sh
$ git clone https://github.com/googleapis/gapic-generator-ruby.git
$ cd gapic-generator-ruby
$ git submodule init
$ git submodule update
$ bundle install
$ bundle exec rake
$ gem build gapic-generator/gapic-generator.gemspec
$ gem install gapic-generator/gapic-generator-0.1.0.gem
$ which protoc-gen-ruby_gapic
> {Non-empty path}
```

### Generate an API
Installing this generator exposes `protoc-gen-ruby_gapic` on the PATH. By doing
so, it gives the protobuf compiler the CLI option `--ruby_gapic_out` on which
you can specify an output path for this generator.

If you want to experiment with an already-existing API, one example is available.
Note: You need to clone the googleapis repository from GitHub, and change
to a special branch:
```sh
# Get the protos and it's dependencies.
$ git clone git@github.com:googleapis/api-common-protos.git
$ git clone git@github.com:googleapis/googleapis.git
$ cd googleapis
$ git checkout --track -b input-contract origin/input-contract

# Now you're ready to compile the API.
$ protoc google/cloud/vision/v1/*.proto \
    --proto_path=../api-common-protos/ --proto_path=. \
    --ruby_gapic_out=/dest/
```

## Contributing

Contributions to this library are always welcome and highly encouraged.

See the [CONTRIBUTING](CONTRIBUTING.md) documentation for more information on how to get started.

## Versioning

This library is currently a **preview** with no guarantees of stability or support. Please get
involved and let us know if you find it useful and we'll work towards a stable version.

## Disclaimer

This is not an official Google product.
