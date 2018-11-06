# Ruby Client for Cloud Speech API

[Cloud Speech API][Product Documentation]:
Converts audio to text by applying powerful neural network models.
- [Client Library Documentation][]
- [Product Documentation][]

### Installation
```
$ gem install google-cloud-speech
```

### Preview

#### SpeechClient

```rb
require "google/cloud/speech"

speech_client = Google::Cloud::Speech.new
language_code = "en-US"
sample_rate_hertz = 44100
encoding = :FLAC
config = {
  language_code: language_code,
  sample_rate_hertz: sample_rate_hertz,
  encoding: encoding
}
uri = "gs://gapic-toolkit/hello.flac"
audio = { uri: uri }
response = speech_client.recognize(config, audio)
```

### Next Steps

- Read the [Client Library Documentation][] for Cloud Speech API
  to see other available methods on the client.
- Read the [Cloud Speech API Product documentation][Product Documentation]
  to learn more about the product and see How-to Guides.
- View this [repository's main README](https://github.com/googleapis/google-cloud-ruby/blob/master/README.md)
  to see the full list of Cloud APIs that we cover.

[Client Library Documentation]: https://googleapis.github.io/google-cloud-ruby/#/docs/google-cloud-speech/latest/google/cloud/speech/v1
[Product Documentation]: https://cloud.google.com/speech

## Supported Ruby Versions

This library is supported on Ruby 2.3+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Currently, this means Ruby 2.3
and later. Older versions of Ruby _may_ still work, but are unsupported and not
recommended. See https://www.ruby-lang.org/en/downloads/branches/ for details
about the Ruby support schedule.
