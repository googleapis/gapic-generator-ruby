# Release History for gapic-generator

### 0.6.11 / 2021-02-01

* Generated clients determine whether to use self-signed JWT credentials.

### 0.6.10 / 2021-01-13

* A set of human-readable command-line parameters can now be specified for the gapic-generator, e.g. `gem-name`. These parameters strictly duplicate the existing behaviour of old command-line parameters, e.g. `:gem.:name`.
* Documentation for the `timeout` parameter in some templates has been fixed to correctly specify 'seconds' where previously it incorrectly sais 'milliseconds'. This is a purely documentation update, no functionality changes.

### 0.6.9 / 2020-12-07

* Load package-level handwritten helpers.
* Disable Names/PredicateName rubocop rule.
* Fix generated client tests when a request field name collides with a Ruby superclass method.

### 0.6.8 / 2020-09-16

* Add samples tasks to generated gapic rakefiles.
* Disable Style/AsciiComments rule.

### 0.6.7 / 2020-08-07

* Generated credentials config allows symbols.

### 0.6.6 / 2020-08-05

* Use numeric error codes rather than strings in generated retry configs.

### 0.6.5 / 2020-07-16

* Examples in auth, rakefile, and readme should pick a non-common service.
* Emit a warning if common_services config references a nonexistent service.

### 0.6.4 / 2020-07-13

* Fix rubocop warning on a generated multi-path helper if it could take no arguments.
* Run the rubocop file formatting step without caching.
* Fix an issue where generating a service with no options would fail.

### 0.6.3 / 2020-06-27

* Fixes for generated tests for some cases involving proto maps.
* Fix a Ruby 2.7 keyword arguments warning in generated tests.
* Clean up bundler references in gemspecs and Gemfiles.

### 0.6.2 / 2020-06-18

* Support for the proto3_optional
* Fixed an issue where tests for the oneof fields were not generating correctly
* Removed ruby <2.5 pin for the protobuf dependency since new protobuf supports it again
* Generated libraries now depend on gapic-common 0.3

### 0.6.1 / 2020-06-16

* Add auto-generated disclaimer to generated tests.
* Support shortname and issue tracker URL configs.
* Refactors and minor fixes around resource template parsing.

### 0.6.0 / 2020-06-02

* Support for clients with generic endpoint and credentials.
* Support for adding extra dependencies.
* Fixed a Ruby warning when looking up RPC-scoped configs with no parent.
* Internal: Presenters reference their parent rather than creating new objects.

### 0.5.1 / 2020-05-21

* Support a configuration for overriding service module names.
* Operations client honors the quota_project setting.

### 0.5.0 / 2020-05-19

* Add quota_project to the generated configs.
* Allow resource patterns with a star as a segment template.
* Generate tests for resource path helpers.
* Pin protobuf dependency for Ruby < 2.5.
* Create a test helper in for generated tests.

### 0.4.2 / 2020-04-28

* Prepend double-colon to absolute/global namespaces to prevent conflicts.
* Fix documentation/examples of timeouts to clarify they are in seconds.

### 0.4.0 / 2020-04-20

* Support generating clients of "common" interfaces by delegating to another service config.
* Added an accessor for the long-running-operation client from the main client.
* Generate tests for the configure method and operations client accessor.
* Prevent generation of RPC or factory methods with reserved names.
* Fixed: LRO clients weren't inheriting custom endpoints from the main client.
* Fixed: Cross-references weren't interpreted if the text included backticks, spaces, or hyphens.

### 0.3.3 / 2020-04-13

* Fix cross-reference links to multi-word enum values.

### 0.3.2 / 2020-04-12

* Fix the talent.v4beta1 hack.

### 0.3.1 / 2020-04-11

* Disable ModuleLength metric for generated code.
* Omit nonconforming resource patterns instead of crashing.

### 0.3.0 / 2020-04-10

* Detect when a resource is referenced implicitly via child_type, and generate path helpers.
* Update grpc-google-iam-v1 dependency to require the latest version.
* Generated require graph is more sane and does not include cycles.
* The bundler entrypoint now loads the entire gem for wrapper gems.
* Generated readmes are more useful and include a quickstart.
* Package and service modules now have basic documentation.
* Overloads for methods now have basic explanatory documentation, including how to pass an empty request.
* Request object documentation no longer duplicates the method documentation.

### 0.2.3 / 2020-04-06

* No changes

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
