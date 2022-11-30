# frozen_string_literal: true

# Copyright 2022 Google LLC
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
  module Presenters
    module Service
      ##
      # @private
      # Base class for the presenter for the generation of the clients
      # for sub-services (mixins, lros) inside a host service's client class
      #
      # @!attribute [r] service
      #   Full name of the service providing the nonstandard LRO functionality
      #   @return [String]
      # @!attribute [r] client_class_name
      #   Full name of the class of the client of the service
      #   @return [String]
      # @!attribute [r] client_class_docname
      #   Name of the class as it should appear in the documentation
      #   @return [String]
      # @!attribute [r] client_var_name
      #   Name for the variable for the client of the service
      #   @return [String]
      # @!attribute [r] require_str
      #   Path to `require` the client of the service
      #   @return [String]
      # @!attribute [r] service_description
      #   The description to place in the comments to this client's
      #   attribute in the library services's client class
      #   @return [String]
      #
      class SubClientPresenter
        attr_reader :service
        attr_reader :client_class_name
        attr_reader :client_class_docname
        attr_reader :client_var_name
        attr_reader :require_str
        attr_reader :service_description

        ##
        # @param service [String]
        #   Full name of the service providing the nonstandard LRO functionality
        # @param client_class_name [String]
        #   Full name of the class of the client of the service
        # @param client_class_docname [String]
        #   Name of the class as it should appear in the documentation
        # @param client_var_name [String]
        #   Name for the variable for the client of the service
        # @param require_str [String]
        #   Path to `require` the client of the service
        # @param service_description [String]
        #   The description to place in the comments to this client's
        #   attribute in the library services's client class
        #
        def initialize service:,
                       client_class_name:,
                       client_class_docname:,
                       client_var_name:,
                       require_str:,
                       service_description:
          @service = service
          @client_class_name = client_class_name
          @client_class_docname = client_class_docname
          @client_var_name = client_var_name
          @require_str = require_str
          @service_description = service_description
        end
      end
    end
  end
end
