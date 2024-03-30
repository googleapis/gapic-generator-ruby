# API Client Generator for Ruby

Create Ruby clients from a protocol buffer description of an API.

## Getting started

The easiest way to use this generator is to clone the github repo (either at
HEAD or at a release tag) and run the generator using the provided command line
tool. The following steps describe how do this.

### Prepare your Ruby environment

The GAPIC Generator for Ruby is written in Ruby and requires the Ruby runtime
and several related tools.

First, install Ruby, version 3.1 or later, if you have not already done so.
[This page](https://www.ruby-lang.org/en/documentation/installation/) on the
official Ruby website includes installation information. We recommend using a
Ruby version manager such as
[ASDF](https://www.ruby-lang.org/en/documentation/installation/#asdf-vm).

You will need the [Bundler](https://rubygems.org/gems/bundler) and
[Toys](https://rubygems.org/gems/toys) gems. Install them if you haven't done
so already:

```sh
$ gem install bundler
$ gem install toys
```

### Clone the Ruby GAPIC Generator repo

The generator itself is present in the repo
https://github.com/googleapis/gapic-generator-ruby. Clone it to your local
workstation. The following steps will use it at HEAD, but you can also check
out a recent release tag.

```sh
$ git clone https://github.com/googleapis/gapic-generator-ruby.git
$ cd gapic-generator-ruby
```

There are submodules in this repo, so you will need to initialize those.

```sh
$ git submodule init
$ git submodule update
```

### Generating the Showcase client

In this section we'll generate a client for the
[Showcase API](https://github.com/googleapis/gapic-showcase), a sample API used
for demoing and testing GAPIC.

(The following section will demonstrate how to generate a client for a Google
API from the [Googleapis repo](https://github.com/googleapis/googleapis).)

#### Obtain Showcase protos

The GAPIC Generator uses protobuf files as input. We will obtain the protos for
Showcase from its repository on GitHub.

Clone the Showcase repo. For this example, we will assume we are starting
inside the gapic-generator-ruby clone directory (see above). We'll move up one
directory, clone the showcase repo and then move *back* into the
gapic-generator-ruby directory for subsequent steps.

```sh
$ cd ..
$ git clone https://github.com/googleapis/gapic-showcase.git
$ cd gapic-generator-ruby
```

#### Configure the client for the Echo service

Each client requires a configuration. The Ruby GAPIC Generator can get this
configuration from a YAML-formatted config file, or from the BUILD.bazel file
used to generate Google APIs. For Showcase, we have neither, so we'll write a
YAML file.

Create a file called `showcase.yml` and copy the following into it:

```
:transports: ["rest", "grpc"]
:gem:
  :name: google-showcase
```

Note that all the keys begin with a colon, which signals to Ruby that they
should be deserialized as Symbol keys rather than String keys.

#### Generate the Echo client

We can now run the generator, by using a Toys tool provided in the repo. This
run will generate a client of the "Echo" service, one of the services in the
Showcase API. It will read the source protos from the gapic-showcase clone,
and write the result into a `tmp` directory within the gapic-generator-ruby
clone. It will also get the configuration from the `showcase.yml` file you
created above.

Make sure you have moved into the gapic-generator-ruby directory, then run:

```sh
$ toys run --input-dir=../gapic-showcase/schema --output-dir=tmp \
  --config-file=showcase.yml google/showcase/v1beta1/echo.proto
```

Now you can see the results in the `tmp` directory.

```sh
$ cd tmp
$ ls
```

### Generating a client for Google Cloud Language V2

In this section we'll generate a client for the Natural Language service that
is part of Google Cloud. This will be very similar to the above Showcase
example, but we will get the input protos and configuration from the googleapis
repository, which is brought into gapic-generator-ruby as a submodule.

Within the gapic-generator-ruby directory, run:

```sh
$ toys run --output-dir=tmp --clean google/cloud/language/v2
```

That's it! The generator's proto lookup defaults to searching the submodule
in `shared/googleapis` so you do not need to provide `--input-dir`. It also
finds its configuration in the `BUILD.bazel` file colocated with the protos.
The `--clean` flag clears out the old `tmp` directory (in case you previously
had generated the showcase client there.)

## Contributing

The Ruby GAPIC Generator is maintained internally at Google by the Ruby Cloud
SDK team. The roadmap is generally driven by the needs of the Google API client
libraries for Ruby. However, contributions will be considered. Before opening
a pull request, please open an issue describing the change that you are
proposing; unless it is an obvious or trivial fix, it is best to discuss and
get agreement on the change before making it.

### Testing

The CI runs on GitHub Actions and comprises four types of tests:

* Unit tests for the various components
* Comparative tests against golden outputs
* Functional tests for some golden outputs
* Lint and style checks using rubocop

To run the tests, execute this in the repo:

```sh
$ toys ci
```

Note that the functional tests require Docker because they involve spinning up
a temporary service for a generated client to talk to.

### Updating golden outputs

If you make changes that result in changes to the generated client code, you
will need to regenerate the golden outputs to match. To do that, run the
following in the repo:

```sh
$ toys gen
```

Include both the generator and golden output changes in the same pull request.

Golden outputs are generated from input protos in the `shared/googleapis`
submodule. Their configurations are provided by YAML files in the
`shared/config` directory. Finally, there is an index of those outputs in the
`shared/gem_defaults.rb` file.

If any of these inputs are modified, or if the submodule is updated, you should
update the "binary inputs" in the `shared/input` directory. These are binary
encodings of that input and configuration data, used in some tests. To update
the binary inputs, execute:

```sh
$ toys bin
```

## Disclaimer

While Google uses this product internally to produce API client libraries, this
generator itself is not an official Google product. You can use it to produce
your own clients for Google services or your own, but Google does not provide
official support for use of this generator.
