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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module Google
  module Api
    # A simple descriptor of a resource type.
    #
    # ResourceDescriptor annotates a resource message (either by means of a
    # protobuf annotation or use in the service config), and associates the
    # resource's schema, the resource type, and the pattern of the resource name.
    #
    # Example:
    #
    #     message Topic \\\{
    #       // Indicates this message defines a resource schema.
    #       // Declares the resource type in the format of \\\{service\}/\\\{kind\}.
    #       // For Kubernetes resources, the format is \\\{api group\}/\\\{kind\}.
    #       option (google.api.resource) = \\\{
    #         type: "pubsub.googleapis.com/Topic"
    #         name_descriptor: \\\{
    #           pattern: "projects/\\\{project\}/topics/\\\{topic\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Project"
    #           parent_name_extractor: "projects/\\\{project\}"
    #         \}
    #       \};
    #     \}
    #
    # The ResourceDescriptor Yaml config will look like:
    #
    #    resources:
    #    - type: "pubsub.googleapis.com/Topic"
    #      name_descriptor:
    #        - pattern: "projects/\\\{project\}/topics/\\\{topic\}"
    #          parent_type: "cloudresourcemanager.googleapis.com/Project"
    #          parent_name_extractor: "projects/\\\{project\}"
    #
    # Sometimes, resources have multiple patterns, typically because they can
    # live under multiple parents.
    #
    # Example:
    #
    #     message LogEntry \\\{
    #       option (google.api.resource) = \\\{
    #         type: "logging.googleapis.com/LogEntry"
    #         name_descriptor: \\\{
    #           pattern: "projects/\\\{project\}/logs/\\\{log\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Project"
    #           parent_name_extractor: "projects/\\\{project\}"
    #         \}
    #         name_descriptor: \\\{
    #           pattern: "folders/\\\{folder\}/logs/\\\{log\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Folder"
    #           parent_name_extractor: "folders/\\\{folder\}"
    #         \}
    #         name_descriptor: \\\{
    #           pattern: "organizations/\\\{organization\}/logs/\\\{log\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Organization"
    #           parent_name_extractor: "organizations/\\\{organization\}"
    #         \}
    #         name_descriptor: \\\{
    #           pattern: "billingAccounts/\\\{billing_account\}/logs/\\\{log\}"
    #           parent_type: "billing.googleapis.com/BillingAccount"
    #           parent_name_extractor: "billingAccounts/\\\{billing_account\}"
    #         \}
    #       \};
    #     \}
    #
    # The ResourceDescriptor Yaml config will look like:
    #
    #     resources:
    #     - type: 'logging.googleapis.com/LogEntry'
    #       name_descriptor:
    #         - pattern: "projects/\\\{project\}/logs/\\\{log\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Project"
    #           parent_name_extractor: "projects/\\\{project\}"
    #         - pattern: "folders/\\\{folder\}/logs/\\\{log\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Folder"
    #           parent_name_extractor: "folders/\\\{folder\}"
    #         - pattern: "organizations/\\\{organization\}/logs/\\\{log\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Organization"
    #           parent_name_extractor: "organizations/\\\{organization\}"
    #         - pattern: "billingAccounts/\\\{billing_account\}/logs/\\\{log\}"
    #           parent_type: "billing.googleapis.com/BillingAccount"
    #           parent_name_extractor: "billingAccounts/\\\{billing_account\}"
    #
    # For flexible resources, the resource name doesn't contain parent names, but
    # the resource itself has parents for policy evaluation.
    #
    # Example:
    #
    #     message Shelf \\\{
    #       option (google.api.resource) = \\\{
    #         type: "library.googleapis.com/Shelf"
    #         name_descriptor: \\\{
    #           pattern: "shelves/\\\{shelf\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Project"
    #         \}
    #         name_descriptor: \\\{
    #           pattern: "shelves/\\\{shelf\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Folder"
    #         \}
    #       \};
    #     \}
    #
    # The ResourceDescriptor Yaml config will look like:
    #
    #     resources:
    #     - type: 'library.googleapis.com/Shelf'
    #       name_descriptor:
    #         - pattern: "shelves/\\\{shelf\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Project"
    #         - pattern: "shelves/\\\{shelf\}"
    #           parent_type: "cloudresourcemanager.googleapis.com/Folder"
    # @!attribute [rw] type
    #   @return [String]
    #     The resource type. It must be in the format of
    #     \\\{service_name\}/\\\{resource_type_kind\}. The `resource_type_kind` must be
    #     singular and must not include version numbers.
    #
    #     Example: `storage.googleapis.com/Bucket`
    #
    #     The value of the resource_type_kind must follow the regular expression
    #     /[A-Za-z][a-zA-Z0-9]+/. It should start with an upper case character and
    #     should use PascalCase (UpperCamelCase). The maximum number of
    #     characters allowed for the `resource_type_kind` is 100.
    # @!attribute [rw] pattern
    #   @return [String]
    #     Optional. The relative resource name pattern associated with this resource
    #     type. The DNS prefix of the full resource name shouldn't be specified here.
    #
    #     The path pattern must follow the syntax, which aligns with HTTP binding
    #     syntax:
    #
    #         Template = Segment \\\{ "/" Segment \} ;
    #         Segment = LITERAL | Variable ;
    #         Variable = "\\\{" LITERAL "\}" ;
    #
    #     Examples:
    #
    #         - "projects/\\\{project\}/topics/\\\{topic\}"
    #         - "projects/\\\{project\}/knowledgeBases/\\\{knowledge_base\}"
    #
    #     The components in braces correspond to the IDs for each resource in the
    #     hierarchy. It is expected that, if multiple patterns are provided,
    #     the same component name (e.g. "project") refers to IDs of the same
    #     type of resource.
    # @!attribute [rw] name_field
    #   @return [String]
    #     Optional. The field on the resource that designates the resource name
    #     field. If omitted, this is assumed to be "name".
    # @!attribute [rw] history
    #   @return [ENUM(History)]
    #     Optional. The historical or future-looking state of the resource pattern.
    #
    #     Example:
    #
    #         // The InspectTemplate message originally only supported resource
    #         // names with organization, and project was added later.
    #         message InspectTemplate \\\{
    #           option (google.api.resource) = \\\{
    #             type: "dlp.googleapis.com/InspectTemplate"
    #             pattern:
    #             "organizations/\\\{organization\}/inspectTemplates/\\\{inspect_template\}"
    #             pattern: "projects/\\\{project\}/inspectTemplates/\\\{inspect_template\}"
    #             history: ORIGINALLY_SINGLE_PATTERN
    #           \};
    #         \}
    # @!attribute [rw] plural
    #   @return [String]
    #     The plural name used in the resource name, such as 'projects' for
    #     the name of 'projects/\\\{project\}'. It is the same concept of the `plural`
    #     field in k8s CRD spec
    #     https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/
    # @!attribute [rw] singular
    #   @return [String]
    #     The same concept of the `singular` field in k8s CRD spec
    #     https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/
    #     Such as "project" for the `resourcemanager.googleapis.com/Project` type.
    class ResourceDescriptor
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # A description of the historical or future-looking state of the
      # resource pattern.
      module History
        # The "unset" value.
        HISTORY_UNSPECIFIED = 0

        # The resource originally had one pattern and launched as such, and
        # additional patterns were added later.
        ORIGINALLY_SINGLE_PATTERN = 1

        # The resource has one pattern, but the API owner expects to add more
        # later. (This is the inverse of ORIGINALLY_SINGLE_PATTERN, and prevents
        # that from being necessary once there are multiple patterns.)
        FUTURE_MULTI_PATTERN = 2
      end
    end

    # Defines a proto annotation that describes a string field that refers to
    # an API resource.
    # @!attribute [rw] type
    #   @return [String]
    #     The resource type that the annotated field references.
    #
    #     Example:
    #
    #         message Subscription \\\{
    #           string topic = 2 [(google.api.resource_reference) = \\\{
    #             type: "pubsub.googleapis.com/Topic"
    #           \}];
    #         \}
    # @!attribute [rw] child_type
    #   @return [String]
    #     The resource type of a child collection that the annotated field
    #     references. This is useful for annotating the `parent` field that
    #     doesn't have a fixed resource type.
    #
    #     Example:
    #
    #       message ListLogEntriesRequest \\\{
    #         string parent = 1 [(google.api.resource_reference) = \\\{
    #           child_type: "logging.googleapis.com/LogEntry"
    #         \};
    #       \}
    class ResourceReference
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
