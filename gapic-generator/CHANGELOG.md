# Release History for gapic-generator

### 0.45.3 / 2025-06-21

* Fix: correct pagination heuristic for Compute
* Fix: add libyaml to checks and configure for the prebuilt binary
* Fix: update Ruby prebuilt binary (version 3.4.3)

### 0.45.2 / 2025-06-04

* Fix: update Ruby prebuilt binary, version 3.4.3

### 0.45.1 / 2025-05-01

No significant changes

### 0.45.0 / 2025-05-01

* Feature: Updated rails to 8.0
* Feature: Update protobuf to 4.30
* Feature: Update common dependencies for generated clients
* Fix: update Ruby prebuilt binary, version 3.4.3

### 0.44.0 / 2025-04-30

* Feature: Update Ruby for the generator to 3.2.8 including prebuilt binary
* Feature: Set minumum Ruby version for generated code to 3.1 and use google-style 1.31

### 0.43.0 / 2025-04-24

* Fix: Fixed typo in generated wrapper readmes
* Fix: Provide a better check for grpc when typechecking credentials
* Feature: bless "::Google::Auth::BaseClient" as an allowed by default credentials type in Config

### 0.42.1 / 2025-02-04

* Fix: Wrappers load release dependencies if local dependencies do not match

### 0.42.0 / 2025-01-30

* Feature: Change REGAPIC pagination algorithm to the standard algorithm for non-compute clients

### 0.41.0 / 2025-01-24

* Feature: Change minimum Ruby version to 3.0

### 0.40.0 / 2025-01-24

No significant changes

### 0.39.2 / 2025-01-24

* Fix: Add warning regarding external credential sourcing

### 0.39.1 / 2025-01-23

* Fix: Updated minimum gapic-common version to 0.25

### 0.39.0 / 2025-01-22

* Feature: Add clarifying notes to oneof members in proto_docs

### 0.38.3 / 2024-12-10

* Fix: Added logger methods to generated dummy stub classes in generated tests

### 0.38.2 / 2024-12-10

* Fix: Throw the correct result object for REST with nonstandard LRO

### 0.38.1 / 2024-12-09

* Fix: fix wrapper gem tests by stubbing the stub_logger method

### 0.38.0 / 2024-12-06

* Feature: Support request-response debug logging from generated GAPICs

### 0.37.0 / 2024-10-24

* Feature: Remove path tests for clients using REST without gRPC

### 0.36.1 / 2024-09-20

* Fix: Add missing local binding in resource path methods

### 0.36.0 / 2024-08-22

* Feature: Support local binding for variables with keyword collision

### 0.35.0 / 2024-08-15

* Feature: Disable xrefs for README files in wrapper gems

### 0.34.1 / 2024-08-08

No significant changes

### 0.34.0 / 2024-08-07

* Feature: Resolve keyword conflicts with path pattern variable names
* Feature: Prevent keyword collision with field names as values
* Feature: Refactor README.md and gemspec files

### 0.33.0 / 2024-07-02

* Fix: Resolve BigDecimal warning
* Feature: Format path pattern variables to snake case

### 0.32.0 / 2024-05-13

* Feature: Introduce google.api.api_version option to generated clients

### 0.31.0 / 2024-04-25

* Feature: Remove api-common-protos dependency
* Feature: Use module name to prevent keyword collision with enum values

### 0.30.0 / 2024-04-24

* Feature: support auto populating request fields with explicit presence
* Feature: avoid keyword collision for enum value names
* Fix: Start requiring ostruct in generated test helper files

### 0.29.0 / 2024-02-22

* Feature: Update minimum Ruby version of generated libraries to 2.7
* Fix: update gemfiles and set bundle platforms to x86_64-linux

### 0.28.0 / 2024-02-14

* Feature: introduce auto_populated_fields (uuid4) to generator

### 0.27.4 / 2024-01-12

No significant changes

### 0.27.3 / 2024-01-12

* Fix: Ensure the correct endpoint gets to mixin clients

### 0.27.2 / 2024-01-11

No significant changes

### 0.27.1 / 2024-01-09

* Fix: Update mixin dependencies to versions that support universe domain

### 0.27.0 / 2024-01-08

* Feature: update generated samples docs
* Feature: Update rubocop autofix to use Rubocop 1.59
* Feature: add @deprecated tags to document items
* Feature: Generate toys files
* Feature: Support universe domain in GAPIC

### 0.26.0 / 2023-12-04

* Feature: Use google-protobuf instead of third-party protobuf library
* Fix: clean up and update gem dependencies

### 0.25.1 / 2023-09-12

* Fix: Workaround for grpc windows issue during tests

### 0.25.0 / 2023-09-07

* Feature: Add support for channel pool in gapic generator
* Fix: Fix snippet generation for REGAPIC clients

### 0.24.0 / 2023-07-05

* Feature: Loosen parsing for extra_dependencies

### 0.23.4 / 2023-06-03

* Fix: Updates to the bundle locks
* Fix: Generated clients depend on gapic-common 0.19.1
* Fix: Fixes the enable_self_signed_jwt determination when the endpoint in the global configuration object (as opposed to the constructor configuration block) is modified

### 0.23.3 / 2023-05-26

* Fix: Generated clients depend on gapic-common 0.19

### 0.23.2 / 2023-03-08

* Fix: Remove html tags from description text parsed from service yaml
* Fix: Fail generation if Rubocop autoformatting fails
* Fix: Replace googleapis.dev links with equivalent cloud.google.com or rubydoc.info links
* Fix: Fix special case iam API shortname

### 0.23.1 / 2023-02-28

* Fix: update gapic-common version
* Fix: Handle empty fields in service yaml

### 0.23.0 / 2023-02-27

* Feature: Honor metadata from the service yaml

### 0.22.0 / 2023-02-14

* Feature: Update mixin dependency versions to 0.4

### 0.21.1 / 2023-02-13

* Fix: Get rubocop working in bazel

### 0.21.0 / 2023-02-09

* Feature: Load and interpret snippetgen phase 2 config data
* Feature: Added SnippetGen phase2 implementation
* Feature: Reimplemented snippetgen phase 1 using phase 2
* Feature: Implemented enough of SnippetGen phase 2 to generate the initial test case
* Feature: add a transport operation class in Rest
* Fix: yield TransportOperation class instead of Faraday's

### 0.20.0 / 2023-01-19

* Feature: migrate generator bazel (including prebuilts) to 3.1.3

### 0.19.0 / 2023-01-17

* Fix: fail on rest transport and no bindings
* Feature: Bump mixin minimum version to 0.3

### 0.18.1 / 2022-12-15

* Fix: Don't generate bindings_override.rb unless REST transport is active

### 0.18.0 / 2022-12-15

* Feature: add quota project and misc to REGAPIC templates
* Feature: use retry policy in regapic templates
* Fix: avoid creating rest default configuration for non-rest methods
* Fix: transcoding in regapic tests
* Fix: Cross-ref links use the REST client class in REST client docs
* Feature: implements template changes for REST server-streaming.
* Feature: all fixes for the combined rest+grpc libraries
* Feature: generate bindings override for REST mixins
* Fix: handle only regapic errors for REST libraries
* Feature: Recognize transport argument for bazel jobs
* Feature: Updated wrapper generator to support multi-transport clients

### 0.17.2 / 2022-10-27

* Fix: Update snippetgen phase 1 to conform to standard sample style

### 0.17.1 / 2022-10-26

* Fix: Fixed typo in rest_numeric_enums bazel field handling

### 0.17.0 / 2022-10-21

* Feature: Recognize rest_numeric_enums argument for bazel jobs

### 0.16.1 / 2022-09-27

No significant changes

### 0.16.0 / 2022-09-16

* Feature: Support numeric enums

### 0.15.3 / 2022-08-18

* Fix: Fix out of date SDK auth documentation

### 0.15.2 / 2022-07-27

* Fix: only do service config http binding override on Operations
* Fix: Apply both namespace and service overrides to service names in yard links

### 0.15.1 / 2022-07-26

* Fix: mixin proto_docs removal works for iam

### 0.15.0 / 2022-07-25

* Feature: classic (AIP-151) LROs in REST
* Feature: grpc transcoding with `additional_bindings`
* Fix: Honor service overrides in yard cross-references
* Fix: suppress generation of mixin proto_docs and wrapper client factory methods

### 0.14.1 / 2022-06-29

* Fix: fix crash when generating generic endpoints

### 0.14.0 / 2022-06-27

* Feature: generate code using full GRPC transcoding for rest libraries
* Feature: generating libraries with rest and grpc transports
* Fix: LRO-wrapped methods of the internal Operations client not working
* Feature: Update minimum Ruby version to 2.6

### 0.13.0 / 2022-05-11

* Feature: Adjust links and repo metadata based on whether the product is part of gcp/cloud
* Fix: Loosen mixin dependencies to allow 1.x versions
* Fix: Disable generation of services that are handled as mixins
* Fix: Disable mixin generation when common services are configured

### 0.12.0 / 2022-04-29

* Feature: Generate snippet metadata files

### 0.11.1 / 2022-04-06

* Updated generated grpc-google-iam-v1 dependency to ~> 1.1

### 0.11.0 / 2022-03-01

* New: Added generation of nonstandard LRO wrapper calls (currently used for Compute)
* Fixed: Examples in the doc comments for modules are now generated with `@example` tags
* Fixed: proto files without a proto service can again be generated
* Ruby prebuilt binaries used in Bazel rules updated to Ruby 2.6.6

### 0.10.6 / 2022-02-02

* Point default documentation URL to rubydoc.info.

### 0.10.5 / 2022-01-20

* No significant changes

### 0.10.4 / 2022-01-07

* Fixed: Set quota_project_id correctly for LRO clients
* Fixed: Remove old cloud-rad configs and rake tasks
* Fixed: Properly quote page titles in YARD configs

### 0.10.3 / 2021-11-04

* New: Enabled snippet-gen by default

### 0.10.2 / 2021-11-01

* New: Added support for service.yaml
* New: New mixin implementation
* New: Parse and generate explicit routing headers
* New: Preliminary support for extended operations for REST LROs
* Fixed: Potential failures in generated tests when routing headers reference sub-fields
* Fixed: Renamed service_config to grpc_service_config

### 0.10.1 / 2021-08-27

* New: Compute REST libraries are now generated with LRO wrappers
* Fixed: Rubocop is disabled for sample tests in generated versioned libraries

### 0.10.0 / 2021-08-09

* New: Enabled per-RPC configuration for generated REST libraries
* New: Generated docs include the deprecated YARD tag for deprecated protos
* New: Scopes can be passed to self-signed JWTs
* Fixed: Generated gRPC clients honor the client-default timeout config
* Fixed: Generated docs now use YARD example tags for inline samples related to configuration
* Fixed: Generated REST clients now require google/cloud/errors
* Generated libraries now require gapic-common 0.7.0 or later

### 0.9.2 / 2021-07-27

* REST libraries are now generated with pagination hepers
* REST libraries are now generated with correct examples in README.md and other documentation files
* It is now possible to generate inline snippets in yardocs
* Fixed the require path in the generated standalone snippets so it reflects the recommended require root rather than the service-specific require path.
* Prevent "duplicate" resources (with the same name but different namespaces) from producing duplicate helper methods.

### 0.9.1 / 2021-07-07

* Detect multiple resource parents for patterns used by multiple resources

### 0.9.0 / 2021-06-29

* Support for configuring the service/method used for the quickstart example
* Allow generation of libraries with no custom env prefix
* Add service override setting to the repo metadata
* Wrapper gem dependencies on pre-GA versioned gems now allow both 0.x and 1.x versions
* Scoped some String and Hash references to the global scope to avoid name collisions
* Reformat some config code to avoid rubocop indentation churn
* Bazel: Replace monolith deps with rules_gapic

### 0.8.0 / 2021-06-16

* Initial implementation of standalone snippet generation.
* Updated gapic-common dependencies to require at least 0.5 and to support future 1.x versions.
* Generated unit tests for REST clients.
* Generated proper x-goog-api-client headers for REST clients.
* Added generation arguments to generated repo metadata.
* Allow multiple versions in the extra-dependency command line argument.
* Fixed treatment of boolean-valued command line arguments to the generator.
* Fixed behavior of wrapper-gem-override if given an empty value.
* Fixed default env_prefix computation to avoid the version part of the proto namespace.
* Fixed Bazel front-end to preserve file permissions.

### 0.7.5 / 2021-05-18

* Bazel jobs now provide a prebuilt ruby binary.
* Fixed generated indentation for a few cases, by updating to Rubocop 1.15.
* Added library_type to generated repo metadata files.

### 0.7.4 / 2021-05-07

* Fixed the broken link in the generated libraries' README.md
* Generated libraries with REST transport now use presense testing instead of rejecting defaults to determine which fields to transcode into the query string parameters

### 0.7.3 / 2021-03-24
    
* Fixed gapic metadata (drift manifest) generation
* Gapic metadata generation is disabled by default in gapic-generator
    (enabled by default in gapic-generator-cloud)
* Can now generate libraries with REST transport in addition to GRPC
* gapic-common 0.4 is the default version for the generated libraries now (was 0.3)
    (required for the generated libraries with the REST transport) 

### 0.7.2 / 2021-03-05

* No changes.

### 0.7.1 / 2021-02-27

* Update generated readmes to reflect that Ruby 2.5 or later is now required.

### 0.7.0 / 2021-02-27

* Update minimum Ruby version to 2.5 for generated libraries.
* Update supported Rubocop to 1.x for generated libraries.

### 0.6.15 / 2021-02-22

* Really fixed encoding arguments in executable entrypoints

### 0.6.14 / 2021-02-22

* Fixed encoding arguments in executable entrypoints

### 0.6.13 / 2021-02-22

* Remove InputOnly and OutputOnly proto tags from docs to avoid confusing YARD.
* Generate drift manifest.
* Executable entrypoints set the default external locale to utf-8.

### 0.6.12 / 2021-02-01

* No changes.

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
