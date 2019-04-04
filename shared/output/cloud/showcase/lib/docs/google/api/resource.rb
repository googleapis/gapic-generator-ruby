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

module Google
  module Api
    # An annotation designating that this field designates a One Platform
    #  resource.
    #
    #  Example:
    #
    #      message Topic {
    #        string name = 1 [(google.api.resource) = {
    #          name: "projects/{project}/topics/{topic}"
    #        }];
    #      }
    # @!attribute [rw] pattern
    #   @return [String]
    #     Required. The resource's name template.
    #
    #      Examples:
    #        - "projects/{project}/topics/{topic}"
    #        - "projects/{project}/knowledgeBases/{knowledge_base}"
    # @!attribute [rw] symbol
    #   @return [String]
    #     The name that should be used in code to describe the resource,
    #      in PascalCase.
    #
    #      If omitted, this is inferred from the name of the message.
    #      This is required if the resource is being defined without the context
    #      of a message (see `resource_definition`, below).
    #
    #      Example:
    #        option (google.api.resource_definition) = {
    #          pattern: "projects/{project}"
    #          symbol: "Project"
    #        };
    class Resource
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # An annotation designating that this field designates a set of One Platform
    #  resources.
    # @!attribute [rw] symbol
    #   @return [String]
    #     The colloquial name of the resource.
    #      If omitted, this is the name of the message.
    # @!attribute [rw] resources
    #   @return [Google::Api::Resource]
    #     Component resources that are part of the set.
    #      Resources declared within a resource set must have `name` set.
    #
    #      The final set of resources in the resource set is the union of
    #      `resources` and `resource_references`.
    #
    #      Resources defined here are only scoped within the parent ResourceSet;
    #      i.e. other messages cannot reference these contained Resources by name.
    # @!attribute [rw] resource_references
    #   @return [String]
    #     References to existing resources (messages of resource definitions)
    #      that are part of the set.
    #
    #      These may be specified as fully-qualified (e.g. "google.pubsub.v1.Topic")
    #      or just the resource/proto name if it is defined within the same package.
    #
    #      The final set of resources in the resource set is the union of
    #      `resources` and `resource_references`.
    class ResourceSet
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
