# Ruby Client for the Google Cloud Speech V1 API

API Client library for the Google Cloud Speech V1 API

google-cloud-speech-v1 is the official client library for the Google Cloud Speech V1 API.

https://github.com/googleapis/google-cloud-ruby

This gem is a _versioned_ client. It provides basic client classes for a
specific version of the Google Cloud Speech V1 API. Most users should consider the
[google-cloud-speech](https://rubygems.org/gems/google-cloud-speech)
gem, a convenience wrapper that may also include higher-level interface classes.
See the section below titled *Which client should I use?* for more information.

## Installation

```
$ gem install google-cloud-speech-v1
```

## Before You Begin

In order to use this library, you first need to go through the following steps:

1. [Select or create a Cloud Platform project.](https://console.cloud.google.com/project)
1. [Enable billing for your project.](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
1. {file:AUTHENTICATION.md Set up authentication.}

## Quick Start

```ruby
require "google/cloud/speech/v1"

client = ::Google::Cloud::Speech::V1::Speech::Client.new
request = my_create_request
response = client.recognize request
```

View the [Client Library Documentation](https://googleapis.dev/ruby/google-cloud-speech-v1/latest)
for class and method documentation.

## Enabling Logging

To enable logging for this library, set the logger for the underlying [gRPC](https://github.com/grpc/grpc/tree/master/src/ruby) library.
The logger that you set may be a Ruby stdlib [`Logger`](https://ruby-doc.org/stdlib/libdoc/logger/rdoc/Logger.html) as shown below,
or a [`Google::Cloud::Logging::Logger`](https://googleapis.dev/ruby/google-cloud-logging/latest)
that will write logs to [Cloud Logging](https://cloud.google.com/logging/). See [grpc/logconfig.rb](https://github.com/grpc/grpc/blob/master/src/ruby/lib/grpc/logconfig.rb)
and the gRPC [spec_helper.rb](https://github.com/grpc/grpc/blob/master/src/ruby/spec/spec_helper.rb) for additional information.

Configuring a Ruby stdlib logger:

```ruby
require "logger"

module MyLogger
  LOGGER = Logger.new $stderr, level: Logger::WARN
  def logger
    LOGGER
  end
end

# Define a gRPC module-level logger method before grpc/logconfig.rb loads.
module GRPC
  extend MyLogger
end
```

## Supported Ruby Versions

This library is supported on Ruby 2.4+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Currently, this means Ruby 2.4
and later. Older versions of Ruby _may_ still work, but are unsupported and not
recommended. See https://www.ruby-lang.org/en/downloads/branches/ for details
about the Ruby support schedule.

## Which client should I use?

Most modern Ruby client libraries for Google APIs come in two flavors:
lower-level _versioned clients_ and higher-level _main clients_. As a TL;DR,
for _most_ cases, you should install the main client.

A _versioned client_ has a name such as `google-cloud-speech-v1`,
and provides a basic set of client classes for a _single version_ of a specific
service. Some services publish multiple versions of their API, with potentially
different interfaces including differences in field names, types, or method
calls. For such services, there may be a separate versioned client library for
each service version. Most versioned clients are created and maintained by a
code generator, based on the service's published interface descriptions.

The _main client_ for a service has a name such as `google-cloud-speech`.
There will be only one main client for any given service, even a service with
multiple versions. For most services, the main client does not directly include
API client classes. Instead, it lists the service's versioned client(s) as
dependencies, and provides convenient factory methods for constructing client
classes provided by the underlying versioned client libraries. It will choose
which service version to use by default (although it will generally let you
override its recommendation if you need to talk to a specific version of the
service.) For some services, the main client also provides a higher-level
interface with additional features, convenience methods, or best practices
built in.

In _most_ cases, we recommend installing the main client gem rather than a
versioned client gem. This is because the main client will embody the best
practices for accessing the service, and may also be easier to use. In
addition, documentation and samples published by Google will generally use the
main client. However, alternately, if you need to access a specific version of
a service, and you want to use a lower-level interface, you can bypass the main
client and instead install a versioned client directly.

Note that some services may not yet have a modern client library (neither a
main nor a versioned client) available. For these services, there might be a
_legacy client_ (with a name of the form `google-apis-<service>_<version>`).
Legacy client libraries have wide coverage across Google services, but may be
more difficult to use or lack features provided by modern clients.
