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

module Gapic
  module Presenters
    ##
    # A presenter for snippets.
    #
    class SnippetPresenter
      def initialize method_presenter, api
        @method_presenter = method_presenter
        @api = api
      end

      def client_streaming?
        @method_presenter.client_streaming?
      end

      def bidi_streaming?
        @method_presenter.client_streaming? && @method_presenter.server_streaming?
      end

      def response_kind
        if @method_presenter.server_streaming?
          :streaming
        elsif @method_presenter.paged?
          :paged
        elsif @method_presenter.lro?
          :lro
        else
          :simple
        end
      end

      def snippet_file_path
        "#{@method_presenter.service.service_require.split('/').last}/#{@method_presenter.name}.rb"
      end

      def require_path
        @method_presenter.service.service_require
      end

      def client_type
        @method_presenter.service.client_name_full.sub(/^::/, "")
      end

      def request_type
        @method_presenter.request_type.sub(/^::/, "")
      end

      def return_type
        base_type = @method_presenter.return_type.sub(/^::/, "")
        @method_presenter.server_streaming? ? "Enumerable<#{base_type}>" : base_type
      end

      def paged_response_type
        @method_presenter.paged_response_type
      end

      def base_response_type
        @method_presenter.return_type
      end

      # TODO: Determine type of LRO response

      def method_name
        @method_presenter.name
      end

      def region_tag
        gem_presenter = @method_presenter.service.gem
        api_id = gem_presenter.api_shortname || gem_presenter.api_id&.split(".")&.first
        names = gem_presenter.name.split "-"
        final_name = names.pop
        if final_name =~ /^v\d/
          api_version = final_name
          api_id ||= names.last
        else
          api_id ||= final_name
          api_version = "v0"
        end
        service_name = @method_presenter.service.module_name
        method_name = @method_presenter.method.name
        "#{api_id}_#{api_version}_generated_#{service_name}_#{method_name}_sync"
      end
    end
  end
end
