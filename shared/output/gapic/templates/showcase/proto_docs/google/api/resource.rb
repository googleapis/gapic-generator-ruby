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

module Google
  module Api
    # An annotation designating that this field designates a One Platform
    # resource.
    #
    # Example:
    #
    #     message Topic {
    #       string name = 1 [(google.api.resource) = {
    #         name: "projects/{project}/topics/{topic}"
    #       }];
    #     }
    # @!attribute [rw] pattern
    #   @return [String]
    #     Required. The resource's name template.
    #
    #     Examples:
    #       - "projects/{project}/topics/{topic}"
    #       - "projects/{project}/knowledgeBases/{knowledge_base}"
    # @!attribute [rw] symbol
    #   @return [String]
    #     The name that should be used in code to describe the resource,
    #     in PascalCase.
    #
    #     If omitted, this is inferred from the name of the message.
    #     This is required if the resource is being defined without the context
    #     of a message (see `resource_definition`, below).
    #
    #     Example:
    #       option (google.api.resource_definition) = {
    #         pattern: "projects/{project}"
    #         symbol: "Project"
    #       };
    class Resource
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # An annotation designating that this field designates a set of One Platform
    # resources.
    # @!attribute [rw] symbol
    #   @return [String]
    #     The colloquial name of the resource.
    #     If omitted, this is the name of the message.
    # @!attribute [rw] resources
    #   @return [Google::Api::Resource]
    #     Component resources that are part of the set.
    #     Resources declared within a resource set must have `name` set.
    #
    #     The final set of resources in the resource set is the union of
    #     `resources` and `resource_references`.
    #
    #     Resources defined here are only scoped within the parent ResourceSet;
    #     i.e. other messages cannot reference these contained Resources by name.
    # @!attribute [rw] resource_references
    #   @return [String]
    #     References to existing resources (messages of resource definitions)
    #     that are part of the set.
    #
    #     These may be specified as fully-qualified (e.g. "google.pubsub.v1.Topic")
    #     or just the resource/proto name if it is defined within the same package.
    #
    #     The final set of resources in the resource set is the union of
    #     `resources` and `resource_references`.
    class ResourceSet
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
