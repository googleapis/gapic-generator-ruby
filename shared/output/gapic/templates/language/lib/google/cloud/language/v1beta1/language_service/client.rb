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

# Auto-generated by gapic-generator-ruby v0.0.1.dev.1. DO NOT EDIT!

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/cloud/language/version"
require "google/cloud/language/v1beta1/language_service_pb"
require "google/cloud/language/v1beta1/language_service/credentials"


module Google
  module Cloud
    module Language
      module V1beta1
        module LanguageService
          # Service that implements LanguageService API.
          class Client
            # @private
            attr_reader :language_service_stub

            ##
            # Configuration for the LanguageService Client API.
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
            # Configure the LanguageService Client instance.
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
              require "google/cloud/language/v1beta1/language_service_services_pb"

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


              @language_service_stub = Gapic::ServiceStub.new(
                Google::Cloud::Language::V1beta1::LanguageService::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Analyzes the sentiment of the provided text.
            #
            # @overload analyze_sentiment(request, options = nil)
            #   @param request [Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest | Hash]
            #     Analyzes the sentiment of the provided text.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload analyze_sentiment(document: nil, encoding_type: nil)
            #   @param document [Google::Cloud::Language::V1beta1::Document | Hash]
            #     Input document.
            #   @param encoding_type [ENUM(EncodingType)]
            #     The encoding type used by the API to calculate sentence offsets for the
            #     sentence sentiment.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Language::V1beta1::AnalyzeSentimentResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Language::V1beta1::AnalyzeSentimentResponse]
            #
            # @raise [GRPC::BadStatus] if the RPC is aborted.
            #
            def analyze_sentiment request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.analyze_sentiment.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Language::VERSION

              options.apply_defaults timeout:      @config.rpcs.analyze_sentiment.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.analyze_sentiment.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :analyze_sentiment, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            end

            ##
            # Finds named entities (currently proper names and common nouns) in the text
            # along with entity types, salience, mentions for each entity, and
            # other properties.
            #
            # @overload analyze_entities(request, options = nil)
            #   @param request [Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest | Hash]
            #     Finds named entities (currently proper names and common nouns) in the text
            #     along with entity types, salience, mentions for each entity, and
            #     other properties.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload analyze_entities(document: nil, encoding_type: nil)
            #   @param document [Google::Cloud::Language::V1beta1::Document | Hash]
            #     Input document.
            #   @param encoding_type [ENUM(EncodingType)]
            #     The encoding type used by the API to calculate offsets.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Language::V1beta1::AnalyzeEntitiesResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Language::V1beta1::AnalyzeEntitiesResponse]
            #
            # @raise [GRPC::BadStatus] if the RPC is aborted.
            #
            def analyze_entities request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.analyze_entities.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Language::VERSION

              options.apply_defaults timeout:      @config.rpcs.analyze_entities.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.analyze_entities.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :analyze_entities, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            end

            ##
            # Analyzes the syntax of the text and provides sentence boundaries and
            # tokenization along with part of speech tags, dependency trees, and other
            # properties.
            #
            # @overload analyze_syntax(request, options = nil)
            #   @param request [Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest | Hash]
            #     Analyzes the syntax of the text and provides sentence boundaries and
            #     tokenization along with part of speech tags, dependency trees, and other
            #     properties.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload analyze_syntax(document: nil, encoding_type: nil)
            #   @param document [Google::Cloud::Language::V1beta1::Document | Hash]
            #     Input document.
            #   @param encoding_type [ENUM(EncodingType)]
            #     The encoding type used by the API to calculate offsets.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Language::V1beta1::AnalyzeSyntaxResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Language::V1beta1::AnalyzeSyntaxResponse]
            #
            # @raise [GRPC::BadStatus] if the RPC is aborted.
            #
            def analyze_syntax request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.analyze_syntax.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Language::VERSION

              options.apply_defaults timeout:      @config.rpcs.analyze_syntax.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.analyze_syntax.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :analyze_syntax, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            end

            ##
            # A convenience method that provides all the features that analyzeSentiment,
            # analyzeEntities, and analyzeSyntax provide in one call.
            #
            # @overload annotate_text(request, options = nil)
            #   @param request [Google::Cloud::Language::V1beta1::AnnotateTextRequest | Hash]
            #     A convenience method that provides all the features that analyzeSentiment,
            #     analyzeEntities, and analyzeSyntax provide in one call.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload annotate_text(document: nil, features: nil, encoding_type: nil)
            #   @param document [Google::Cloud::Language::V1beta1::Document | Hash]
            #     Input document.
            #   @param features [Google::Cloud::Language::V1beta1::AnnotateTextRequest::Features | Hash]
            #     The enabled features.
            #   @param encoding_type [ENUM(EncodingType)]
            #     The encoding type used by the API to calculate offsets.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Language::V1beta1::AnnotateTextResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Language::V1beta1::AnnotateTextResponse]
            #
            # @raise [GRPC::BadStatus] if the RPC is aborted.
            #
            def annotate_text request, options = nil
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Language::V1beta1::AnnotateTextRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.annotate_text.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Language::VERSION

              options.apply_defaults timeout:      @config.rpcs.annotate_text.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.annotate_text.retry_policy
              options.apply_defaults metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :annotate_text, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            end

            ##
            # Configuration class for the LanguageService API.
            class Configuration
              extend Gapic::Config

              config_attr :endpoint,     "language.googleapis.com", String
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

              ##
              # Configuration RPC class for the LanguageService API.
              class Rpcs
                attr_reader :analyze_sentiment
                attr_reader :analyze_entities
                attr_reader :analyze_syntax
                attr_reader :annotate_text

                def initialize parent_rpcs = nil
                  analyze_sentiment_config = parent_rpcs&.analyze_sentiment if parent_rpcs&.respond_to? :analyze_sentiment
                  @analyze_sentiment = Gapic::Config::Method.new analyze_sentiment_config
                  analyze_entities_config = parent_rpcs&.analyze_entities if parent_rpcs&.respond_to? :analyze_entities
                  @analyze_entities = Gapic::Config::Method.new analyze_entities_config
                  analyze_syntax_config = parent_rpcs&.analyze_syntax if parent_rpcs&.respond_to? :analyze_syntax
                  @analyze_syntax = Gapic::Config::Method.new analyze_syntax_config
                  annotate_text_config = parent_rpcs&.annotate_text if parent_rpcs&.respond_to? :annotate_text
                  @annotate_text = Gapic::Config::Method.new annotate_text_config

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

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/cloud/language/v1beta1/language_service/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
