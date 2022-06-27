# Ruby Client for the Google Showcase API

API Client library for the Google Showcase API

google-showcase is the official client library for the Google Showcase API.

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

This library is supported on Ruby 2.6+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Older versions of Ruby _may_
still work, but are unsupported and not recommended. See
https://www.ruby-lang.org/en/downloads/branches/ for details about the Ruby
support schedule.
