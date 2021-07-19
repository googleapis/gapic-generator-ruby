# frozen_string_literal: true

# Copyright 2018 Google LLC
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

require "gapic/helpers/namespace_helper"

module Gapic
  module Presenters
    ##
    # A presenter for proto messages.
    #
    class MessagePresenter
      include Gapic::Helpers::NamespaceHelper

      def initialize api, message
        @api = api
        @message = message
      end

      def name
        @message.name
      end

      def doc_types
        type_name_full
      end

      def doc_description
        @message.docs_leading_comments
      end

      def default_value
        "{}"
      end

      def type_name_full
        message_ruby_type @message
      end

      def fields
        @fields = @message.fields.map { |f| FieldPresenter.new @api, @message, f }
      end

      def nested_enums
        @nested_enums ||= @message.nested_enums.map { |e| EnumPresenter.new e }
      end

      def nested_messages
        @nested_messages ||= @message.nested_messages.map { |m| MessagePresenter.new @api, m }
      end

      protected

      def message_ruby_type message
        ruby_namespace @api, message.address.join(".")
      end
    end
  end
end
