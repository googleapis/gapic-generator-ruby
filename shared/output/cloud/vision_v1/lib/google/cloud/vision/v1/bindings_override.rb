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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "gapic/config"

module Google
  module Cloud
    module Vision
      module V1
        def self.configure
          @configure ||= begin
            namespace = ["Google", "Cloud", "Vision"]
            parent_config = while namespace.any?
                              parent_name = namespace.join "::"
                              parent_const = const_get parent_name
                              break parent_const.configure if parent_const.respond_to? :configure
                              namespace.pop
                            end

            default_config = Configuration.new parent_config
            default_config.bindings_override["google.cloud.location.Locations.GetLocation"] = [
              Gapic::Rest::GrpcTranscoder::HttpBinding.create_with_validation(
                uri_method: :get,
                uri_template: "/v1/{name}",
                matches: [
                  ["name", %r{^projects/[^/]+/visionLocations/[^/]+/?$}, false]
                ],
                body: nil
              )
            ]
            default_config.bindings_override["google.cloud.location.Locations.ListLocations"] = [

              Gapic::Rest::GrpcTranscoder::HttpBinding.create_with_validation(
                uri_method: :get,
                uri_template: "/v1/{name}/visionLocations",
                matches: [
                  ["name", %r{^projects/[^/]+/?$}, false]
                ],
                body: nil
              )
            ]
            default_config
          end
          yield @configure if block_given?
          @configure
        end

        class Configuration
          extend ::Gapic::Config

          config_attr :bindings_override, {}, ::Hash, nil

          # @private
          def initialize parent_config = nil
            @parent_config = parent_config unless parent_config.nil?

            yield self if block_given?
          end
        end
      end
    end
  end
end
