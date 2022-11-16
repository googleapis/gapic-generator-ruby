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

require "gapic/config"

module Testing
  module RoutingHeaders
    def self.configure
      @configure ||= begin
        namespace = ["Testing"]
        parent_config = while namespace.any?
                          parent_name = namespace.join "::"
                          parent_const = const_get parent_name
                          break parent_const.configure if parent_const.respond_to? :configure
                          namespace.pop
                        end

        default_config = Configuration.new parent_config
        default_config.bindings_override["google.cloud.location.Locations.GetLocation"] = [
          Gapic::Rest::GrpcTranscoder::HttpBinding.new(
            :get,
            "/v1beta1/{name}",
            [
              Gapic::Rest::GrpcTranscoder::HttpBinding::FieldBinding.new("name",
                                                                         %r{^projects/[^/]+/locations/[^/]+/?$}, false)
            ],
            nil
          ),
          Gapic::Rest::GrpcTranscoder::HttpBinding.new(
            :get,
            "/v1beta1/{name}/{test_name}",
            [
              Gapic::Rest::GrpcTranscoder::HttpBinding::FieldBinding.new("name",
                                                                         %r{^projects/[^/]+/locations/[^/]+/?$}, false),
              Gapic::Rest::GrpcTranscoder::HttpBinding::FieldBinding.new("test_name", %r{^testingLocations/[^/]+/?$},
                                                                         false)
            ],
            nil
          )
        ]
        default_config.bindings_override["google.cloud.location.Locations.ListLocations"] = [

          Gapic::Rest::GrpcTranscoder::HttpBinding.new(
            :get,
            "/v1beta1/{name}/locations",
            [
              Gapic::Rest::GrpcTranscoder::HttpBinding::FieldBinding.new("name", %r{^projects/[^/]+/?$}, false)
            ],
            nil
          ),
          Gapic::Rest::GrpcTranscoder::HttpBinding.new(
            :get,
            "/v1beta1/{name}/testingLocations",
            [
              Gapic::Rest::GrpcTranscoder::HttpBinding::FieldBinding.new("name",
                                                                         %r{^projects/[^/]+/locations/[^/]+/?$}, false)
            ],
            nil
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
