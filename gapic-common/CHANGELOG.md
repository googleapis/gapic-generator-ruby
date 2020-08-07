# Release History

### 0.3.4 / 2020-08-07

* Support the :this_channel_is_insecure gRPC pseudo-credential, used by tests and emulators.

### 0.3.3 / 2020-08-05

* Retry configs properly handle error name strings.

### 0.3.2 / 2020-07-30

* Alias PagedEnumerable#next_page to PagedEnumerable#next_page!

### 0.3.1 / 2020-06-19

* Fix file permissions

### 0.3.0 / 2020-06-18

* Update the dependency on google-protobuf to 3.12.2

### 0.2.1 / 2020-06-02

* Fix a crash when resetting a config field to nil when it has a parent but no default

### 0.2.0 / 2020-03-17

* Support default call options in Gapic::Operation
* Fix implicit kwarg warnings under Ruby 2.7

### 0.1.0 / 2020-01-09

Initial release
