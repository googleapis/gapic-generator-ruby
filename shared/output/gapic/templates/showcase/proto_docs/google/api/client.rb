# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
