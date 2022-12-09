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
  ##
  # To load just the REST part of this package, including all its services, and instantiate a REST client:
  #
  # @example
  #
  #     require "testing/nonstandard_lro_grpc/rest"
  #     client = ::Testing::NonstandardLroGrpc::PlainLroConsumer::Rest::Client.new
  #
  module NonstandardLroGrpc
    ##
    # @private
    # Initialize the mixin bindings configuration
    #
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
          Gapic::Rest::GrpcTranscoder::HttpBinding.create_with_validation(
            uri_method: :get,
            uri_template: "/v1beta1/{name}",
            matches: [
              ["name", %r{^projects/[^/]+/locations/[^/]+/?$}, false]
            ],
            body: nil
          ),
          Gapic::Rest::GrpcTranscoder::HttpBinding.create_with_validation(
            uri_method: :get,
            uri_template: "/v1beta1/{name}/{test_name}",
            matches: [
              ["name", %r{^projects/[^/]+/locations/[^/]+/?$}, false],
              ["test_name", %r{^testingLocations/[^/]+/?$}, false]
            ],
            body: nil
          )
        ]
        default_config.bindings_override["google.cloud.location.Locations.ListLocations"] = [

          Gapic::Rest::GrpcTranscoder::HttpBinding.create_with_validation(
            uri_method: :get,
            uri_template: "/v1beta1/{name}/locations",
            matches: [
              ["name", %r{^projects/[^/]+/?$}, false]
            ],
            body: nil
          ),
          Gapic::Rest::GrpcTranscoder::HttpBinding.create_with_validation(
            uri_method: :get,
            uri_template: "/v1beta1/{name}/testingLocations",
            matches: [
              ["name", %r{^projects/[^/]+/locations/[^/]+/?$}, false]
            ],
            body: nil
          )
        ]
        default_config
      end
      yield @configure if block_given?
      @configure
    end

    ##
    # @private
    # Configuration class for the testing.nonstandardlrogrpc package.
    #
    # This class contains common configuration for all services
    # of the testing.nonstandardlrogrpc package.
    #
    # This configuration is for internal use of the client library classes,
    # and it is not intended that the end-users will read or change it.
    #
    class Configuration
      extend ::Gapic::Config

      # @private
      # Overrides for http bindings for the RPC of the mixins for this package.
      # Services in this package should use these when creating clients for the mixin services.
      # @return [::Hash{::Symbol=>::Array<::Gapic::Rest::GrpcTranscoder::HttpBinding>}]
      config_attr :bindings_override, {}, ::Hash, nil

      # @private
      def initialize parent_config = nil
        @parent_config = parent_config unless parent_config.nil?

        yield self if block_given?
      end
    end
  end
end
