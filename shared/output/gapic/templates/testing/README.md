# Ruby Client for the Testing API

Typical ServiceWithLoc and ServiceWithLocAndOps.

ServiceWithLoc and ServiceWithLocAndOps.

https://github.com/googleapis/googleapis

## Installation

```
$ gem install testing
```

## Quick Start

```ruby
require "testing/empty_service"

client = ::Testing::GrpcServiceConfig::ServiceNoRetry::Client.new
request = ::Testing::GrpcServiceConfig::Request.new # (request fields as keyword arguments...)
response = client.no_retry_method request
```

## Supported Ruby Versions

This library is supported on Ruby 3.2+.

Google provides official support for Ruby versions as described in the
[Supported Ruby versions](https://docs.cloud.google.com/ruby/getting-started/supported-ruby-versions)
policy. Older versions of Ruby _may_ still work, but are unsupported and not
recommended.
