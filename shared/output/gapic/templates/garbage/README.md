# Ruby Client for the Google Garbage API

Typical Garbage Service Summary.

## Overview

Typical Garbage Service overview.

## Resources

Typical Garbage Service \\{typical.garbage}

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

This library is supported on Ruby 3.2+.

Google provides official support for Ruby versions as described in the
[Supported Ruby versions](https://docs.cloud.google.com/ruby/getting-started/supported-ruby-versions)
policy. Older versions of Ruby _may_ still work, but are unsupported and not
recommended.
