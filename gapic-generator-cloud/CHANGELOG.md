# Release History for gapic-generator-cloud

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
