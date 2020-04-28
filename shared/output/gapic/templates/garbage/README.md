# Ruby Client for the Google Garbage API

API Client library for the Google Garbage API

google-garbage is the official client library for the Google Garbage API.

https://github.com/googleapis/googleapis

## Installation

```
$ gem install google-garbage
```

## Quick Start

```ruby
require "so/much/trash"

client = ::So::Much::Trash::GarbageService::Client.new
request = my_create_request
response = client.get_empty_garbage request
```

## Supported Ruby Versions

This library is supported on Ruby 2.4+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Currently, this means Ruby 2.4
and later. Older versions of Ruby _may_ still work, but are unsupported and not
recommended. See https://www.ruby-lang.org/en/downloads/branches/ for details
about the Ruby support schedule.
