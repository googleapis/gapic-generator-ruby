# Ruby Client for the Google Cloud Compute V1 API

API Client library (ALPHA) for the Google Cloud Compute V1 API.

google-cloud-compute-v1 is the official client library for the Google Cloud Compute V1 API. This library is considered to be in alpha. This means it is still a work-in-progress and under active development. Any release is subject to backwards-incompatible changes at any time.

https://github.com/googleapis/google-cloud-ruby

## Installation

```
$ gem install google-cloud-compute-v1
```

## Before You Begin

In order to use this library, you first need to go through the following steps:

1. [Select or create a Cloud Platform project.](https://console.cloud.google.com/project)
1. [Enable billing for your project.](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
1. [Set up authentication.](AUTHENTICATION.md)

## Quick Start

```ruby
require "google/cloud/firestore/v1"

client = ::Google::Cloud::Firestore::V1::Firestore::Rest::Client.new
request = ::Google::Cloud::Firestore::V1::GetDocumentRequest.new # (request fields as keyword arguments...)
response = client.get_document request
```

View the [Client Library Documentation](https://cloud.google.com/ruby/docs/reference/google-cloud-compute-v1/latest)
for class and method documentation.


## Google Cloud Samples

To browse ready to use code samples check [Google Cloud Samples](https://cloud.google.com/docs/samples).

## Supported Ruby Versions

This library is supported on Ruby 2.6+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Older versions of Ruby _may_
still work, but are unsupported and not recommended. See
https://www.ruby-lang.org/en/downloads/branches/ for details about the Ruby
support schedule.
