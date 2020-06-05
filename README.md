# API Client Generator for Ruby

Create Ruby clients from a protocol buffer description of an API.

**Note** This project is a preview. Please try it out and let us know what you think,
but there are currently no guarantees of stability or support.

## Getting started using the Docker image
The easiest way to use the generator is to run it with the Docker image. There are several docker images containing various flavors of gapic generators, we are going to use the `gapic-generator-ruby` image which is generating code using the [gapic-generator-cloud](https://github.com/googleapis/gapic-generator-ruby/tree/master/gapic-generator-cloud).

### Download the sample protos for the Showcase API
The [Showcase API](https://github.com/googleapis/gapic-showcase) is a good API to
play with if you want to start generating your own client libraries. It has several
services, we'll use `Echo` ([echo.proto](https://github.com/googleapis/gapic-showcase/blob/master/schema/google/showcase/v1beta1/echo.proto)) service as an example.

Download the proto files locally (the following examples work in Linux or macOS):

```sh
$ curl -L https://github.com/googleapis/gapic-showcase/releases/download/v0.6.1/gapic-showcase-0.6.1-protos.tar.gz | tar xz
```

### Run the generator using the Docker image

```sh
$ mkdir showcase-ruby
$ docker run --rm --user $UID \
  --mount type=bind,source=`pwd`/google/showcase/v1beta1,destination=/in/google/showcase/v1beta1,readonly \
  --mount type=bind,source=`pwd`/showcase-ruby,destination=/out \
  gcr.io/gapic-images/gapic-generator-ruby:latest --ruby-cloud-gem-name=google-showcase
```

NB: `ruby-cloud-gem-name` currently has to partialy (excluding version) match the package option from the proto files. For showcase the package is `google.showcase.v1beta1` and so the `ruby-cloud-gem-name` has to be `google-showcase`

The resulting files are in `showcase-ruby` folder:

```sh
$ cd showcase-ruby
$ bundle install   # install dependencies
$ bundle exec rake ci  # run unit tests
```

## Building, installation and API generation without the Docker image
### Install the Proto Compiler
This generator relies on the Protocol Buffer Compiler to [orchestrate] the
client generation. Install protoc version 3.7 or later.

It may be available from your package manager. The following should work on Mac
OS X using homebrew:
```sh
$ brew install protobuf
```

Otherwise, you can download the release from GitHub:
```sh
# Declare the protobuf version to use.
$ export PROTOBUF_VERSION=3.7.1

# Declare the target installation system.
# export PROTOBUF_SYSTEM=osx-x86_64
$ export PROTOBUF_SYSTEM=linux-x86_64

# Get the precompiled protobuf compiler.
$ mkdir /usr/src/protoc
$ curl --location https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-${PROTOBUF_SYSTEM}.zip --output /usr/src/protoc/protoc-${PROTOBUF_VERSION}.zip
$ cd /usr/src/protoc/
$ unzip protoc-${PROTOBUF_VERSION}.zip
$ rm protoc-${PROTOBUF_VERSION}.zip

# Link the protoc to the path.
$ ln -s /usr/src/protoc/bin/protoc /usr/local/bin/protoc

# Move the common protobuf files to the local include folder.
$ cp -R /usr/src/protoc/include/* /usr/local/include/
```

[orchestrate]: https://developers.google.com/protocol-buffers/docs/reference/ruby-generated

### Set Up Your Ruby Environment

If you are a Ruby developer, then please skip ahead to the next section.

Install gem.

```sh
# Linux
$ sudo apt-get install gem
# Mac
$ brew install gem
```

Add the following to your `~/.bashrc`, then do `source ~/.bashrc`.

```sh
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem
export PATH=$PATH:$GOPATH/bin:$GEM_PATH/bin/ruby/2.5.0/bin
```

Install and set up Bundler.

```sh
$ gem install bundler
$ bundle install
$ BUNDLE_PATH=~/.gems
```

### Build and Install the Generator
This tool is in pre-alpha so it is not yet released to RubyGems. You will have to
build the generator from scratch.

```sh
$ mkdir ~/my-gapic-example
$ cd ~/my-gapic-example
$ git clone https://github.com/googleapis/gapic-generator-ruby.git
$ cd gapic-generator-ruby
$ git submodule update --init
$ bundle update
$ bundle exec rake update
$ bundle exec rake install
$ which protoc-gen-ruby_gapic
> {Non-empty path}
```

### Generate an API
Installing this generator exposes `protoc-gen-ruby_gapic` on the PATH. By doing
so, it gives the protobuf compiler the CLI option `--ruby_gapic_out` on which
you can specify an output path for this generator.

If you want to experiment with an already-existing API, you can use the cloud
vision API as an example.
Note: You need to clone the googleapis repository from GitHub, and change
to a special branch:
```sh
$ cd ~/my-gapic-example
$ git clone git@github.com:googleapis/api-common-protos.git
$ git clone git@github.com:googleapis/googleapis.git
$ cd googleapis
$ git checkout --track -b input-contract origin/input-contract
```

Currently, each API also requires a small configuration file that provides
information such as the gem name. In your `my-gapic-example` directory, create
a file `vision.yml` with the following contents:
```yaml
---
:gem:
  :name: "google-cloud-vision"
:defaults:
  :service:
    :default_host: "vision.googleapis.com"
    :oauth_scopes:
      - https://www.googleapis.com/auth/cloud-platform
      - https://www.googleapis.com/auth/cloud-vision
```

Now you're ready to compile the API client:
```sh
$ cd ~/my-gapic-example
$ mkdir dest
$ protoc googleapis/google/cloud/vision/v1/*.proto \
    --proto_path=api-common-protos --proto_path=googleapis \
    --ruby_gapic_opt=configuration=vision.yml --ruby_gapic_out=dest
```

Note that generated clients depend on the `gapic-common` 2.0 gem, which is not
yet released. To test a client, you may need to modify it to pull `gapic-common`
from the github master branch.

### Create a custom generator
If you want to customize the output, you may create a new generator using the
`gapic-generator` binary installed by the main generator. A new generator takes
the form of a gem that provides an additional `protoc-gen-ruby_$NAME` binary
that can be used by protoc.

Here's a brief example. Assuming you've already built and installed the main
generator gem as described above, we will now create a custom generator called
`acme`, by creating a gem called `gapic-generator-acme`:
```sh
$ cd ~/my-gapic-example
$ gapic-generator -g acme
$ cd gapic-generator-acme
```

The generated code will include an empty `templates/acme` directory. This is
where you can put overrides for the templates and helpers used by the code
generator. (The default templates are copied into the `example_templates/acme`
directory, although they are there only for your information. The actual
defaults being used are hosted in the main `gapic-generator` gem.)

As an example, let's modify the license header generated at the top of each
source file. This is located in the `shared/_license.erb` partial. If you look
at `example_templates/acme/shared/_license.erb`, you'll see that an MIT license
is rendered by default. Let's change that.

Create `templates/acme/shared/_license.erb` and populate it with a different
license header (maybe BSD or Apache). This will now override the MIT header
provided by the core generator.

Now let's build the custom generator gem.
```sh
$ cd ~/my-gapic-example/gapic-generator-acme
$ bundle install
$ bundle exec rake install
```

You should now have a `protoc-gen-ruby_acme` binary in your PATH. So you should
now be able to run the "Generate an API" example above using `--ruby_acme_opt=`
and `--ruby_acme_out=` options to generate a client with your custom license
header.

For more examples, see the `gapic-generator-cloud` directory in this
repository. This is the custom generator used for Google Cloud APIs.

## Contributing

Contributions to this library are always welcome and highly encouraged.

See the [CONTRIBUTING](CONTRIBUTING.md) documentation for more information on how to get started.

## Versioning

This library is currently a **preview** with no guarantees of stability or support. Please get
involved and let us know if you find it useful and we'll work towards a stable version.

## Disclaimer

This is not an official Google product.
