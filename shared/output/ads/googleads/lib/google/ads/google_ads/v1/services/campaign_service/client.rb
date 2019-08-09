# frozen_string_literal: true

# Copyright 2019 Google LLC
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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

# require "google/ads/google_ads/error"

require "google/ads/google_ads/version"
require "google/ads/googleads/v1/services/campaign_service_pb"
require "google/ads/google_ads/v1/services/campaign_service/credentials"

module Google
  module Ads
    module GoogleAds
      module V1
        module Services
          module CampaignService
            # Service that implements CampaignService API.
            class Client
              # @private
              attr_reader :campaign_service_stub

              ##
              # Configuration for the CampaignService Client API.
              #
              # @yield [config] Configure the Client client.
              # @yieldparam config [Client::Configuration]
              #
              # @return [Client::Configuration]
              #
              def self.configure
                @configure ||= Client::Configuration.new
                yield @configure if block_given?
                @configure
              end

              ##
              # Configure the CampaignService Client instance.
              #
              # The configuration is set to the derived mode, meaning that values can be changed,
              # but structural changes (adding new fields, etc.) are not allowed. Structural changes
              # should be made on {Client.configure}.
              #
              # @yield [config] Configure the Client client.
              # @yieldparam config [Client::Configuration]
              #
              # @return [Client::Configuration]
              #
              def configure
                yield @config if block_given?
                @config
              end

              ##
              # Create a new Client client object.
              #
              # @yield [config] Configure the Client client.
              # @yieldparam config [Client::Configuration]
              #
              def initialize
                # These require statements are intentionally placed here to initialize
                # the gRPC module only when it's required.
                # See https://github.com/googleapis/toolkit/issues/446
                require "gapic/grpc"
                require "google/ads/googleads/v1/services/campaign_service_services_pb"

                # Create the configuration object
                @config = Configuration.new Client.configure

                # Yield the configuration if needed
                yield @config if block_given?

                # Create credentials
                credentials = @config.credentials
                credentials ||= Credentials.default scope: @config.scope
                if credentials.is_a?(String) || credentials.is_a?(Hash)
                  credentials = Credentials.new credentials, scope: @config.scope
                end


                @campaign_service_stub = Gapic::Grpc::Stub.new(
                  Google::Ads::GoogleAds::V1::Services::CampaignService::Stub,
                  credentials:  credentials,
                  endpoint:     @config.endpoint,
                  channel_args: @config.channel_args,
                  interceptors: @config.interceptors
                )
              end

              # Service calls

              ##
              # Returns the requested campaign in full detail.
              #
              # @overload get_campaign(request, options = nil)
              #   @param request [Google::Ads::GoogleAds::V1::Services::GetCampaignRequest | Hash]
              #     Returns the requested campaign in full detail.
              #   @param options [Gapic::ApiCall::Options, Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload get_campaign(resource_name: nil)
              #   @param resource_name [String]
              #     The resource name of the campaign to fetch.
              #
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [Google::Ads::GoogleAds::V1::Resources::Campaign]
              # @yieldparam operation [GRPC::ActiveCall::Operation]
              #
              # @return [Google::Ads::GoogleAds::V1::Resources::Campaign]
              #
              # @raise [Google::Ads::GoogleAdsError] if the RPC is aborted.
              #
              # @example
              #   TODO
              #
              def get_campaign request, options = nil, &block
                raise ArgumentError, "request must be provided" if request.nil?

                request = Gapic::Protobuf.coerce request, to: Google::Ads::GoogleAds::V1::Services::GetCampaignRequest

                # Converts hash and nil to an options object
                options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.get_campaign.metadata.to_h

                # Set x-goog-api-client header
                metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: Google::Ads::GoogleAds::VERSION

                header_params = {
                  "resource_name" => request.resource_name
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.get_campaign.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.get_campaign.retry_policy
                options.apply_defaults timeout:      @config.timeout,
                                       metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @campaign_service_stub.call_rpc :get_campaign, request, options: options, operation_callback: block
                # rescue Gapic::GapicError => gax_error
                #  raise Doogle::Ads::GoogleAds::Error.new gax_error.message
              end

              ##
              # Creates, updates, or removes campaigns. Operation statuses are returned.
              #
              # @overload mutate_campaigns(request, options = nil)
              #   @param request [Google::Ads::GoogleAds::V1::Services::MutateCampaignsRequest | Hash]
              #     Creates, updates, or removes campaigns. Operation statuses are returned.
              #   @param options [Gapic::ApiCall::Options, Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
              #
              # @overload mutate_campaigns(customer_id: nil, operations: nil, partial_failure: nil, validate_only: nil)
              #   @param customer_id [String]
              #     The ID of the customer whose campaigns are being modified.
              #   @param operations [Google::Ads::GoogleAds::V1::Services::CampaignOperation | Hash]
              #     The list of operations to perform on individual campaigns.
              #   @param partial_failure [Boolean]
              #     If true, successful operations will be carried out and invalid
              #     operations will return errors. If false, all operations will be carried
              #     out in one transaction if and only if they are all valid.
              #     Default is false.
              #   @param validate_only [Boolean]
              #     If true, the request is validated but not executed. Only errors are
              #     returned, not results.
              #
              #
              # @yield [response, operation] Access the result along with the RPC operation
              # @yieldparam response [Google::Ads::GoogleAds::V1::Services::MutateCampaignsResponse]
              # @yieldparam operation [GRPC::ActiveCall::Operation]
              #
              # @return [Google::Ads::GoogleAds::V1::Services::MutateCampaignsResponse]
              #
              # @raise [Google::Ads::GoogleAdsError] if the RPC is aborted.
              #
              # @example
              #   TODO
              #
              def mutate_campaigns request, options = nil, &block
                raise ArgumentError, "request must be provided" if request.nil?

                request = Gapic::Protobuf.coerce request, to: Google::Ads::GoogleAds::V1::Services::MutateCampaignsRequest

                # Converts hash and nil to an options object
                options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

                # Customize the options with defaults
                metadata = @config.rpcs.mutate_campaigns.metadata.to_h

                # Set x-goog-api-client header
                metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: Google::Ads::GoogleAds::VERSION

                header_params = {
                  "customer_id" => request.customer_id
                }
                request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
                metadata[:"x-goog-request-params"] ||= request_params_header

                options.apply_defaults timeout:      @config.rpcs.mutate_campaigns.timeout,
                                       metadata:     metadata,
                                       retry_policy: @config.rpcs.mutate_campaigns.retry_policy
                options.apply_defaults timeout:      @config.timeout,
                                       metadata:     @config.metadata,
                                       retry_policy: @config.retry_policy

                @campaign_service_stub.call_rpc :mutate_campaigns, request, options: options, operation_callback: block
                # rescue Gapic::GapicError => gax_error
                #  raise Doogle::Ads::GoogleAds::Error.new gax_error.message
              end

              class Configuration
                extend Gapic::Config

                config_attr :endpoint,     "googleads.googleapis.com", String
                config_attr :credentials,  nil do |value|
                  allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
                  allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
                  allowed.any? { |klass| klass === value }
                end
                config_attr :scope,        nil, String, Array, nil
                config_attr :lib_name,     nil, String, nil
                config_attr :lib_version,  nil, String, nil
                config_attr(:channel_args, { "grpc.service_config_disable_resolution"=>1 }, Hash, nil)
                config_attr :interceptors, nil, Array, nil
                config_attr :timeout,      nil, Numeric, nil
                config_attr :metadata,     nil, Hash, nil
                config_attr :retry_policy, nil, Hash, Proc, nil

                def initialize parent_config = nil
                  @parent_config = parent_config unless parent_config.nil?

                  yield self if block_given?
                end

                def rpcs
                  @rpcs ||= begin
                    parent_rpcs = nil
                    parent_rpcs = @parent_config.rpcs if @parent_config&.respond_to? :rpcs
                    Rpcs.new parent_rpcs
                  end
                end

                class Rpcs
                  attr_reader :get_campaign
                  attr_reader :mutate_campaigns

                  def initialize parent_rpcs = nil
                    get_campaign_config = nil
                    get_campaign_config = parent_rpcs&.get_campaign if parent_rpcs&.respond_to? :get_campaign
                    @get_campaign = Gapic::Config::Method.new get_campaign_config
                    mutate_campaigns_config = nil
                    mutate_campaigns_config = parent_rpcs&.mutate_campaigns if parent_rpcs&.respond_to? :mutate_campaigns
                    @mutate_campaigns = Gapic::Config::Method.new mutate_campaigns_config

                    yield self if block_given?
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/ads/google_ads/v1/services/campaign_service/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
