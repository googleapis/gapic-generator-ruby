# Test resources for Ruby API Client Generator gems

This directory contains test resources for the gapic generator gems, including
the "golden" outputs used as the principal test cases. Specifically includes:

* Repository submodules for source protos in the `googleapis` directory
* Input protos for test cases that are not part of `googleapis`, in the
  `protos` directory
* Configuration files for golden outputs in the `config` directory and
  `gem_defaults.rb` file
* Proto input in binary format in the `input` directory, which can be fed
  directly into the generator plugin without running `protoc`
* Test inputs for the legacy samplegen system in the `samples` directory
* Test inputs for snippetgen in the `snippet_config` directory
* Golden outputs themselves in the `output` directory
* Runtime tests of generated golden outputs in the `test` directory

## Usage

### Generating golden outputs

Regenerate all golden outputs by running:

```sh
$ cd shared
$ bundle install
$ toys gen
```

You can regenerate golden outputs for specific golden services by passing them
as arguments to `toys gen`. You can also specify which generator to use.

```sh
$ cd shared
$ bundle install
$ toys gen --generator=cloud vision_v1
```

### Generating binary input files

Regenerate all binary input files by running:

```sh
$ cd shared
$ bundle install
$ toys bin
```

You can regenerate binary inputs for specific golden services by passing them
as arguments to `toys bin`. You can also specify which generator to use.

```sh
$ cd shared
$ bundle install
$ toys bin --generator=cloud vision_v1
```

### Running Tests

This project includes a functional test suite for the Ruby GAPIC generator. See
[Showcase](https://github.com/googleapis/gapic-showcase) for more details.

```sh
$ cd shared
$ bundle install
$ toys test showcase
```

There are also a set of functional tests that use the vision golden output:

```sh
$ cd shared
$ bundle install
$ toys test vision
```

You can also run CI (test, rubocop, yard) on all generated goldens:

```sh
$ cd shared
$ bundle install
$ toys test output
```

Run all above tests by:

```sh
$ cd shared
$ bundle install
$ toys test
```
