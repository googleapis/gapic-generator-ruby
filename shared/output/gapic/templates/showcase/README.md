# Ruby Client for the Client Libraries Showcase API

Showcase represents both a model API and an integration testing surface for client library generator consumption.

Showcase represents both a model API and an integration testing surface for client library generator consumption.

https://github.com/googleapis/googleapis

## Installation

```
$ gem install google-showcase
```

## Quick Start

```ruby
require "google/showcase/v1beta1"

client = ::Google::Showcase::V1beta1::Compliance::Client.new
request = ::Google::Showcase::V1beta1::RepeatRequest.new # (request fields as keyword arguments...)
response = client.repeat_data_body request
```

## Supported Ruby Versions

This library is supported on Ruby 3.2+.

Google provides official support for Ruby versions as described in the
[Supported Ruby versions](https://docs.cloud.google.com/ruby/getting-started/supported-ruby-versions)
policy. Older versions of Ruby _may_ still work, but are unsupported and not
recommended.
