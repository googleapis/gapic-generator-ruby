# Release History for gapic-generator

### 0.2.2 / 2020-03-31

* Updates to common protos, especially core types which were more than a year old.

### 0.2.1 / 2020-03-26

* Fix service address for LRO operation clients.
* Tweak sample task names for wrapper-gem Rakefiles.

### 0.2.0 / 2020-03-23

Generation updates:

* Proto service documentation is rendered into client class YARD docs.
* Generated Apache license is now well-formatted markdown.
* YARD titles updated with the word "API".
* Tweaks to the default summary and description text.
* Generated rakefiles can run acceptance tests if present.
* Switch the order of summary and description in the readmes.
* Exempt a few more files (notably gemspec and rakefile) from rubocop.
* Several formatting tweaks, including removal of redundant whitespace.

Internal changes:

* New configuration allows path helpers to be generated from outputs.
* Moved presenters into lib so they can be changed/subclassed more easily.
* Several additions to GemPresenter to support new features.

### 0.1.7 / 2020-03-18

* Path modules extend self so helpers can be invoked on them directly
* Trigger IAM dependency for IAM V1 files other than iam_policy.proto

### 0.1.6 / 2020-03-17

* Generated libraries now depend on gapic-common 0.2
* Convert cross-reference syntax in proto docs to YARD cross-reference links.
* Preserve call options in LROs
* Fix implicit kwarg warnings under Ruby 2.7

### 0.1.5 / 2020-03-13

* More improvements to escaping of curly braces.

### 0.1.4 / 2020-03-12

* Fixed over-escaping of curly braces in preformatted blocks in the yardocs.
* Fixed typo in authentication document.

### 0.1.3 / 2020-03-11

* Generated numeric constants are formatted with underscores if necessary.

### 0.1.2 / 2020-03-09

* Support multiple grpc service config files

### 0.1.1 / 2020-03-09

* Relax rake dependency.

### 0.1.0 / 2020-03-07

* Generate default timeout and retry configs based on GRPC service configs.
* Send x-goog-user-project header based on quota_project_id.

### 0.0.6 / 2020-03-03

* Generated config classes now have full yardoc
* Yardoc types for enums reference the fully namespaced module

### 0.0.5 / 2020-02-25

* Require simplecov explicitly from generated test files

### 0.0.4 / 2020-02-19

* Fixed generation of methods with empty requests.
* Fixed references to the gem version constant if the library name doesn't match the proto path.
* Disable line length cop for the generated gemspec file.

### 0.0.3 / 2020-02-05

* Fixed generated test failures on map fields
* Fixed generated test failures on single-precision float fields
