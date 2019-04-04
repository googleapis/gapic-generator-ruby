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

class FieldPresenter
  include NamespaceHelper

  def initialize message, field
    @message = message
    @field = field
  end

  def name
    @field.name
  end

  def doc_types
    if @field.message?
      "#{message_ruby_type @field.message} | Hash"
    elsif @field.enum?
      # TODO: handle when arg message is nil and enum is the type
      "ENUM(#{@field.enum.name})"
    else
      case @field.type
      when 1, 2                              then "Float"
      when 3, 4, 5, 6, 7, 13, 15, 16, 17, 18 then "Integer"
      when 9, 12                             then "String"
      when 8                                 then "Boolean"
      else
        "Object"
      end
    end
  end

  def output_doc_types
    return message_ruby_type @field.message if @field.message?
    doc_types
  end

  def doc_description
    return nil if @field.docs.leading_comments.empty?

    @field.docs.leading_comments
  end

  def default_value
    if @field.message?
      "{}"
    elsif @field.enum?
      # TODO: select the first non-0 enum value
      # ":ENUM"
      @field.enum.values.first
    else
      case @field.type
      when 1, 2                              then "3.14"
      when 3, 4, 5, 6, 7, 13, 15, 16, 17, 18 then "42"
      when 9, 12                             then "\"hello world\""
      when 8                                 then "true"
      else
        "Object"
      end
    end
  end

  # TODO: remove, only used in tests
  def type_name
    @field.type_name
  end

  def type_name_full
    ruby_namespace @field.type_name
  end

  protected

  def message_ruby_type message
    message.address.map do |namespace_node|
      ActiveSupport::Inflector.classify namespace_node
    end.join "::"
  end
end
