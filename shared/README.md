# Shared files and tasks for Ruby API Client Generator gems

This directory contains the tasks and files used for the gapic generator gems.
Including the repository for the shared protos and their binary files, as well
as the mechanism to generate new binary files.

## Usage

### Generating Binary Input files

The binary input files can be generated using the `gen` rake task:

```sh
$ cd shared
$ bundle update
$ bundle exec rake gen
```

## Showcase Tests

This project includes a functional test suite for the Ruby GAPIC generator. See
[Showcase](https://github.com/googleapis/gapic-showcase) for more details.

```sh
$ cd shared
$ bundle update
$ bundle exec rake test:showcase
```
