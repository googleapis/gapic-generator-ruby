# frozen_string_literal: true

# Copyright 2021 Google LLC
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

require "active_support/inflector"
require "gapic/helpers/filepath_helper"
require "gapic/helpers/namespace_helper"

module Gapic
  module Presenters
    ##
    # A presenter for proto service (REST submethods)
    #
    class ServiceRestPresenter
      include Gapic::Helpers::FilepathHelper
      include Gapic::Helpers::NamespaceHelper

      ##
      # @param main_service [Gapic::Presenters::ServicePresenter]
      # @param api [Gapic::Schema::Api]
      #
      def initialize main_service, api
        @main_service = main_service
        @api = api
      end

      ##
      # @return [String]
      #
      def service_name_full
        fix_namespace api, "#{main_service.service_name_full}::Rest"
      end

      ##
      # @return [String]
      #
      def client_name
        main_service.client_name
      end

      ##
      # @return [String]
      #
      def client_name_full
        fix_namespace api, "#{service_name_full}::#{client_name}"
      end

      ##
      # @return [String]
      #
      def client_require
        ruby_file_path api, client_name_full
      end

      ##
      # @return [String]
      #
      def client_file_path
        "#{client_require}.rb"
      end

      ##
      # @return [String]
      #
      def create_client_call
        "#{client_name_full}.new"
      end

      ##
      # @return [String]
      #
      def service_rest_require
        ruby_file_path api, service_name_full
      end

      ##
      # @return [String]
      #
      def service_rest_file_path
        "#{service_rest_require}.rb"
      end

      ##
      # @return [String]
      #
      def transcoding_helper_name
        "GrpcTranscoding"
      end

      ##
      # @return [String]
      #
      def transcoding_helper_name_full
        fix_namespace api, "#{service_name_full}::#{transcoding_helper_name}"
      end

      ##
      # @return [String]
      #
      def transcoding_helper_require
        ruby_file_path api, transcoding_helper_name_full
      end

      ##
      # @return [String]
      #
      def transcoding_helper_file_path
        "#{transcoding_helper_require}.rb"
      end

      ##
      # @return [String]
      #
      def test_client_file_path
        main_service.service_file_path.sub ".rb", "_test.rb"
      end

      ##
      # @return [String]
      #
      def credentials_class_xref
        main_service.credentials_class_xref
      end

      ##
      # @return [String]
      #
      def configure_client_call
        "#{client_name_full}.configure"
      end

      ##
      # The method to use for quick start samples. Normally this is simply the
      # first non-client-streaming method defined, but it can be overridden via
      # a gem config.
      #
      # @return [Gapic::Presenters::MethodRestPresenter] if there is a method
      #     appropriatke for quick start
      # @return [nil] if there is no method appropriate for quick start
      #
      def quick_start_method
        main_service.quick_start_method&.rest
      end

      private

      # @return [Gapic::Presenters::ServicePresenter]
      attr_reader :main_service
      # @return [Gapic::Schema::Api]
      attr_reader :api
    end
  end
end
