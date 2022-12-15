# Release History for gapic-generator-cloud

### 0.18.0 / 2022-12-15

* Includes changes from gapic-generator 0.18.0
* Fix: Cross-ref links use the REST client class in REST client docs
* Feature: all fixes for the combined rest+grpc libraries
* Fix: handle only regapic errors for REST libraries
* Feature: Updated wrapper generator to support multi-transport clients

### 0.17.2 / 2022-10-27

* Includes changes from gapic-generator 0.17.2
* Fix: Update snippetgen phase 1 to conform to standard sample style

### 0.17.1 / 2022-10-26

* Includes changes from gapic-generator 0.17.1

### 0.17.0 / 2022-10-21

* Includes changes from gapic-generator 0.17.0

### 0.16.1 / 2022-09-27

* Includes changes from gapic-generator 0.16.1
* Fix: correct cause of Cloud error

### 0.16.0 / 2022-09-16

* Includes changes from gapic-generator 0.16.0
* Feature: parse details information from REST errors
* Feature: Support numeric enums

### 0.15.3 / 2022-08-18

* Includes changes from gapic-generator 0.15.3
* Fix: Fix out of date SDK auth documentation

### 0.15.2 / 2022-07-27

* Includes changes from gapic-generator 0.15.2

### 0.15.1 / 2022-07-26

* Includes changes from gapic-generator 0.15.1
* Fix: mixin proto_docs removal works for iam

### 0.15.0 / 2022-07-25

* Includes changes from gapic-generator 0.15.0
* Fix: Update default generated repo-metadata so it doesn't trigger the lint bot
* Fix: Wrapper rakefiles do not depend on credentials for generic clients
* Fix: suppress generation of mixin proto_docs and wrapper client factory methods

### 0.14.1 / 2022-06-29

* Includes changes from gapic-generator 0.14.1

### 0.14.0 / 2022-06-27

* Includes changes from gapic-generator 0.14.0
* Feature: generate code using full GRPC transcoding for rest libraries
* Feature: Update minimum Ruby version to 2.6

### 0.13.0 / 2022-05-11

* Includes changes from gapic-generator 0.13.0
* Feature: Adjust links and repo metadata based on whether the product is part of gcp/cloud

### 0.12.0 / 2022-04-29

* Includes changes from gapic-generator 0.12.0
* Feature: Generate snippet metadata files

### 0.11.1 / 2022-04-06

* Includes changes from gapic-generator 0.11.1

### 0.11.0 / 2022-03-01

* Includes changes from gapic-generator 0.11.0

### 0.10.6 / 2022-02-02

* Includes changes from gapic-generator 0.10.6
* Add api_shortname and release_level to generated repo-metadata.json file
* Point cloud client reference documentation URLs to cloud.google.com

### 0.10.5 / 2022-01-20

* Includes changes from gapic-generator 0.10.5
* Interim support for wrappers of REST clients.

### 0.10.4 / 2022-01-07

* Includes changes from gapic-generator 0.10.4
* Removes broken image links and fixes outdated content in the auth template.

### 0.10.3 / 2021-11-04

* Includes changes from gapic-generator 0.10.3

### 0.10.2 / 2021-11-01

* Includes changes from gapic-generator 0.10.2

### 0.10.1 / 2021-08-27

* Includes changes from gapic-generator 0.10.1

### 0.10.0 / 2021-08-09

* Includes changes from gapic-generator 0.10.0

### 0.9.2 / 2021-07-07

* Includes changes from gapic-generator 0.9.2
* Disable Style/BlockDelimiters check for sample acceptance tests
* Flags `--ruby-cloud-generate-standalone-snippets` and `--ruby-cloud-generate-yardoc-snippets` are now recognized

### 0.9.1 / 2021-07-07

* Includes changes from gapic-generator 0.9.1
* Clarify some text in generated authentication docs

### 0.9.0 / 2021-06-29

* Includes changes from gapic-generator 0.9.0

### 0.8.0 / 2021-06-16

* Includes changes from gapic-generator 0.8.0

### 0.7.5 / 2021-05-18

* Includes changes from gapic-generator 0.7.5

### 0.7.4 / 2021-05-07

* Includes changes from gapic-generator 0.7.4

### 0.7.3 / 2021-03-24

* Includes changes from gapic-generator 0.7.3
* Gapic metadata file generation is enabled by default for gapic-generator-cloud

### 0.7.2 / 2021-03-05

* Disable metrics-related rubocop checks in generated wrapper libraries.

### 0.7.1 / 2021-02-27

* Update generated readmes to reflect that Ruby 2.5 or later is now required.

### 0.7.0 / 2021-02-27

* Includes changes from gapic-generator 0.7.0, notably dropping Ruby 2.4 support.
* Generate special Cloud RAD yardopts file for GAPIC generated clients.

### 0.6.15 / 2021-02-22

* Really fixed encoding arguments in executable entrypoints

### 0.6.14 / 2021-02-22

* Fixed encoding arguments in executable entrypoints

### 0.6.13 / 2021-02-22

* Includes changes from gapic-generator 0.6.13.
* Fixed formatting of generated Apache license files.
* Generate Rake task and special yardopts file for Cloud RAD.
* Executable entrypoints set the default external locale to utf-8.

### 0.6.12 / 2021-02-01

* Fixed a bug in the identification of versioned clients that incorrectly flagged `google-cloud-vision`.

### 0.6.11 / 2021-02-01

* Includes changes from gapic-generator 0.6.11.
* Updated generated readmes to cover main vs versioned clients.

### 0.6.10 / 2021-01-13

* Includes changes from gapic-generator 0.6.10.
* A set of human-readable cloud-specific command-line parameters can now be specified for the gapic-generator-cloud, e.g. `ruby-cloud-gem-name`. These parameters strictly duplicate the existing behaviour of old command-line parameters, e.g. `:gem.:name`.

### 0.6.9 / 2020-12-07

* Includes changes from gapic-generator 0.6.9.

### 0.6.8 / 2020-09-16

* Includes changes from gapic-generator 0.6.8.

### 0.6.7 / 2020-08-07

* Includes changes from gapic-generator 0.6.7.

### 0.6.6 / 2020-08-05

* Includes changes from gapic-generator 0.6.6.

### 0.6.5 / 2020-07-16

* Includes changes from gapic-generator 0.6.5.

### 0.6.4 / 2020-07-13

* Includes changes from gapic-generator 0.6.4.

### 0.6.3 / 2020-06-27

* Includes changes from gapic-generator 0.6.3.

### 0.6.2 / 2020-06-18

* Includes changes from gapic-generator 0.6.2.

### 0.6.1 / 2020-06-16

* Includes changes from gapic-generator 0.6.1.
* Populate additional repo-metadata fields.
* Remove authentication file from the gemspec for generic wrappers.

### 0.6.0 / 2020-06-02

* Includes changes from gapic-generator 0.6.0.
* Support for clients with generic endpoint and credentials.
* Support for adding extra dependencies.
* Fix the logic determining whether a wrapper needs a separate entrypoint file.
* Disable Metrics/BlockLength check for all sample tests.

### 0.5.1 / 2020-05-21

* Includes changes from gapic-generator 0.5.1

### 0.5.0 / 2020-05-19

* Includes changes from gapic-generator 0.5.0
* Wrappers now support partial-gapic helpers.
* Generated configs for wrappers now include endpoint and scope.

### 0.4.3 / 2020-05-01

* Unpin minitest in the generated wrappers.

### 0.4.2 / 2020-04-28

* Includes changes from gapic-generator 0.4.2
* Eliminate a circular require in generated wrappers.

### 0.4.1 / 2020-04-23

* Wrapper templates honor overridden namespaces.
* Support setting the gem namespace from the docker interface.

### 0.4.0 / 2020-04-20

* Includes changes from gapic-generator 0.4.0
* Apply overrides to client namespaces but not proto namespaces.
* Remove common resources proto from generated files.
* Multiple overrides can be specified in the docker interface.
* Fixed: The pre-migration versions in wrapper readmes were malformed if the migration version was still 0.x.

### 0.3.3 / 2020-04-13

* Includes changes from gapic-generator 0.3.3

### 0.3.2 / 2020-04-12

* Includes changes from gapic-generator 0.3.2

### 0.3.1 / 2020-04-11

* Includes changes from gapic-generator 0.3.1

### 0.3.0 / 2020-04-10

* Includes changes from gapic-generator 0.3.0
* Generated readmes include quickstart, project/auth/billing setup instructions, and logging instructions.

### 0.2.3 / 2020-04-06

* Includes changes from gapic-generator 0.2.3
* Namespace and path overrides can be set from the docker command line.
* Temporary hack disabling paging for two specific google.cloud.talent RPCs.

### 0.2.2 / 2020-03-31

* Includes changes from gapic-generator 0.2.2

### 0.2.1 / 2020-03-26

* Includes changes from gapic-generator 0.2.1

### 0.2.0 / 2020-03-23

* Includes changes from gapic-generator 0.2.0
* The cloud generator can now be configured to generate wrapper gems.

### 0.1.7 / 2020-03-18

* Includes changes from gapic-generator 0.1.7

### 0.1.6 / 2020-03-17

* Includes changes from gapic-generator 0.1.6

### 0.1.5 / 2020-03-13

* Includes changes from gapic-generator 0.1.5

### 0.1.4 / 2020-03-12

* Includes changes from gapic-generator 0.1.4

### 0.1.3 / 2020-03-11

* Includes changes from gapic-generator 0.1.3

### 0.1.2 / 2020-03-09

* Includes changes from gapic-generator 0.1.2

### 0.1.1 / 2020-03-09

* Includes changes from gapic-generator 0.1.1
* Add grpc_service_config changes to the cloud templates.

### 0.1.0 / 2020-03-07

* Includes changes from gapic-generator 0.1.0

### 0.0.6 / 2020-03-03

* Includes changes from gapic-generator 0.0.6
* Gem homepage can be overridden from the docker command line

### 0.0.5 / 2020-02-25

* Includes changes from gapic-generator 0.0.5

### 0.0.4 / 2020-02-19

* Includes changes from gapic-generator 0.0.4
* Add documentation link to the generated repo-metadata.json.
* Set google-cloud-ruby Github repo as the default homepage.

### 0.0.3 / 2020-02-05

* Fixed crash when generating cloud libraries that have proto types but no services
