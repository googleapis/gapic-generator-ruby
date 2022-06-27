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
request = ::So::Much::Trash::EmptyGarbage.new # (request fields as keyword arguments...)
response = client.get_empty_garbage request
```

## Supported Ruby Versions

This library is supported on Ruby 2.6+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Older versions of Ruby _may_
still work, but are unsupported and not recommended. See
https://www.ruby-lang.org/en/downloads/branches/ for details about the Ruby
support schedule.
