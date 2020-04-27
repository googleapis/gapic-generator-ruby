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

client = ::Google::Showcase::V1beta1::Echo::Client.new
request = my_create_request
response = client.echo request
```

## Supported Ruby Versions

This library is supported on Ruby 2.4+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Currently, this means Ruby 2.4
and later. Older versions of Ruby _may_ still work, but are unsupported and not
recommended. See https://www.ruby-lang.org/en/downloads/branches/ for details
about the Ruby support schedule.
