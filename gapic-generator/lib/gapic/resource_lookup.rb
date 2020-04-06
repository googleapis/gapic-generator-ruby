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
      resources = []
      @service.methods.each do |method|
        add_message_resources method.input, resources
        add_message_resources method.output, resources if @api.generate_path_helpers_output?
      end
      resources.uniq
    end

    # @private
    def add_message_resources message, resources, seen_messages = []
      return resources if seen_messages.include? message
      seen_messages << message
      resources << message.resource if message.resource
      message.nested_messages.each do |nested_message|
        add_message_resources nested_message, resources, seen_messages
      end
      message.fields.each do |field|
        add_reference field.resource_reference, resources if field.resource_reference
        add_message_resources field.message, resources, seen_messages if field.message?
      end
      resources
    end

    # @private
    def add_reference reference, resources
      if (type = reference.type) && !type.empty?
        resource = @api.lookup_resource_type type
        resources << resource if resource
      elsif (child_type = reference.child_type) && !child_type.empty?
        child_resource = @api.lookup_resource_type child_type
        resources.concat child_resource.parent_resources if child_resource
      end
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
