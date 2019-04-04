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

require_relative "field_presenter"

class MessagePresenter
  def initialize message
    @message = message
  end

  def name
    @message.name
  end

  def doc_types
    message_ruby_type @message
  end

  def doc_description
    return nil if @message.docs.leading_comments.empty?

    @message
      .docs
      .leading_comments
      .each_line
      .map { |line| (line.start_with? " ") ? line[1..-1] : line }
      .join
  end

  def default_value
    "{}"
  end

  def type_name_full
    message_ruby_type @message
  end

  def fields
    @fields = @message.fields.map { |f| FieldPresenter.new @message, f }
  end

  def nested_enums
    @nested_enums ||= @message.nested_enums.map { |e| EnumPresenter.new e }
  end

  def nested_messages
    @nested_messages ||= @message.nested_messages.map { |m| MessagePresenter.new m }
  end

  protected

  def message_ruby_type message
    message.address.map do |namespace_node|
      ActiveSupport::Inflector.classify namespace_node
    end.join "::"
  end
end
