# Copyright 2023 Google LLC
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

require "gapic/common/error"

module Gapic
  ##
  # A mixin module that provides methods for obtaining the effective universe
  # domain, endpoint, and credentials for a stub. This is included in
  # Grpc::ServiceStub and Rest::ClientStub.
  #
  module UniverseDomainConcerns
    ##
    # A substitution string for the universe domain in an endpoint template
    # @return [String]
    #
    ENDPOINT_SUBSTITUTION = "$UNIVERSE_DOMAIN$".freeze

    ##
    # The effective endpoint
    # @return [String]
    #
    attr_reader :endpoint

    ##
    # The effective universe domain
    # @return [String]
    #
    attr_reader :universe_domain

    ##
    # The effective credentials
    #
    # @return [Google::Auth::Credentials, Signet::OAuth2::Client, Proc,
    #   ::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials]
    #
    attr_reader :credentials

    protected

    ##
    # @private
    # Called from the stub constructor to populate the data.
    #
    def setup_universe_domain universe_domain: nil,
                              endpoint: nil,
                              endpoint_template: nil,
                              credentials: nil
      raise ArgumentError, "endpoint or endpoint_template is required" if endpoint.nil? && endpoint_template.nil?
      raise ArgumentError, "credentials is required" if credentials.nil?

      universe_domain ||= ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] || "googleapis.com"
      endpoint ||= endpoint_template.sub ENDPOINT_SUBSTITUTION, universe_domain

      if !(credentials.respond_to?(:disable_universe_domain_check) && credentials.disable_universe_domain_check) &&
         credentials.respond_to?(:universe_domain) && credentials.universe_domain != universe_domain
        raise UniverseDomainMismatch,
              "Universe domain is #{universe_domain} but credentials are in #{credentials.universe_domain}"
      end

      @universe_domain = universe_domain
      @endpoint = endpoint
      @credentials = credentials
    end
  end

  ##
  # Raised when the configured universe domain does not match the universe
  # domain of the credentials.
  #
  class UniverseDomainMismatch < ::Gapic::Common::Error
  end
end
