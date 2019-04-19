# API Client Generator for Ruby

Create Ruby clients from a protocol buffer description of an API.

**Note** This project is a preview. Please try it out and let us know what you think,
but there are currently no guarantees of stability or support.

## Usage

### Install the Generator

This tool is in pre-alpha so it is not yet released to RubyGems.

```sh
$ git clone https://github.com/googleapis/gapic-generator-ruby.git
$ cd gapic-generator-ruby
$ git submodule update --init
$ cd gapic-generator
$ bundle install
$ bundle exec rake install
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
