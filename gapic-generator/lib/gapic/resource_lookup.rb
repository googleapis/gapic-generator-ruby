# frozen_string_literal: true

# Copyright 2020 Google LLC
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

module Gapic
  # TODO: Enter docs
  # Dooooooooocs!!!
  class ResourceLookup
    # @private
    def initialize service
      @service = service
      @api = service.parent.parent
    end

    # @private
    def lookup!
      resources = @api.files.flat_map { |file| lookup_file_resource_descriptors file }
      resources.compact.uniq
    end

    # @private
    def lookup_file_resource_descriptors file
      file.messages.flat_map { |message| lookup_message_resources_descriptors message }
    end

    # @private
    def service_resource_types
      @service_resource_types ||= begin
        @service.methods.flat_map do |method|
          message_resource_types method.input
        end.uniq
      end
    end

    # @private
    def message_resource_types message
      resource_types = []
      resource_types << message.resource.type if message.resource
      resource_types += message.nested_messages.map { |nested_message| message_resource_types nested_message }
      message.fields.each do |field|
        resource_types << field.resource_reference.type if field.resource_reference
        resource_types += message_resource_types field.message if field.message?
      end
      resource_types.flatten
    end

    # @private
    def lookup_message_resources_descriptors message
      resources = []

      # We don't expect service_resource_types to iclude nil, so we can use message.resource&.type
      resources << message.resource if service_resource_types.include? message.resource&.type

      if message.nested_messages
        resources += message.nested_messages.flat_map do |nested_message|
          lookup_message_resources_descriptors nested_message
        end
      end

      resources
    end

    # Lookup all resources for a given service.
    #
    # @param service [Gapic::Service] The service to lookup on.
    #
    # @return [Array<Google::Api::ResourceDescriptor>]
    def self.for_service service
      ResourceLookup.new(service).lookup!
    end
  end
end
