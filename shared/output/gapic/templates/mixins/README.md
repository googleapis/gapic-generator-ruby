# Ruby Client for the Testing Mixins API

API Client library for the Testing Mixins API

testing-mixins is the official client library for the Testing Mixins API.

https://github.com/googleapis/googleapis

## Installation

```
$ gem install testing-mixins
```

## Quick Start

```ruby
require "testing/mixins"

client = ::Testing::Mixins::FirstServiceWithLoc::Client.new
request = my_create_request
response = client.call_method request
```

## Supported Ruby Versions

This library is supported on Ruby 2.5+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Currently, this means Ruby 2.5
and later. Older versions of Ruby _may_ still work, but are unsupported and not
recommended. See https://www.ruby-lang.org/en/downloads/branches/ for details
about the Ruby support schedule.
