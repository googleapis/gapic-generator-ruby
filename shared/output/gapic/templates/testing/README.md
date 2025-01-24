# Ruby Client for the Testing API

Typical Garbage Service.


https://github.com/googleapis/googleapis

## Installation

```
$ gem install testing
```

## Quick Start

```ruby
require "testing/grpc_service_config"

client = ::Testing::GrpcServiceConfig::ServiceNoRetry::Client.new
request = ::Testing::GrpcServiceConfig::Request.new # (request fields as keyword arguments...)
response = client.no_retry_method request
```

## Supported Ruby Versions

This library is supported on Ruby 3.0+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Older versions of Ruby _may_
still work, but are unsupported and not recommended. See
https://www.ruby-lang.org/en/downloads/branches/ for details about the Ruby
support schedule.
