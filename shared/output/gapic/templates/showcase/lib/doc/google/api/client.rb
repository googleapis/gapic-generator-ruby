# frozen_string_literal: true

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

raise "This file is for documentation purposes only."

module Google
  module Api
    # Information about the API as a whole.
    # This is generally used for client library packaging and documentation, and
    # only needs to be set when correct values can not be inferred from the proto
    # package.
    #
    # For example, Pub/Sub sets this to:
    #
    #     option (google.api.package) = {
    #       title: "Pub/Sub"
    #       namespace: ["Google", "Cloud"]
    #       version: "v1"
    #     };
    #
    # If this is set, then the `title`, `namespace`, and `version` fields
    # should all be set.
    # @!attribute [rw] title
    #   @return [String]
    #     Required. The title of the package (and, by default, the product).
    #
    #     This should be set to the colloquial name of the API, and is used
    #     for things such as determining the package name.
    #
    #     Specify this in appropriate title casing, with space as the word
    #     separator (e.g. "Speech", "BigQuery", "Video Intelligence", "Pub/Sub").
    #
    #     This value may be used as-is in documentation, and code generators should
    #     normalize it appropriately for idiomatic package, module, etc. names in
    #     their language.
    # @!attribute [rw] namespace
    #   @return [String]
    #     Required. The namespace.
    #
    #     This should be set to the package namespace, using appropriate title
    #     casing (the same casing as `title`, above). Client libraries
    #     should normalize it appropriately for package, module, etc. names in
    #     their language.
    #
    #       Example: ["Google", "Cloud"]
    #
    #     This is used to inform the prefix for package manager names, and the code
    #     layout in cases where the language-specific protobuf options are not set.
    #
    #     The "required" note above is "soft". This *should* be set, but an empty
    #     namespace is technically valid.
    # @!attribute [rw] version
    #   @return [String]
    #     Required. The version.
    #     This should be set to the API version, such as "v1".
    # @!attribute [rw] product_title
    #   @return [String]
    #     The title of the product, if different from the package title above.
    #     This may be used in documentation and package metadata.
    class Package
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
