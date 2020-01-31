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

  def initialize api, message, field
    @api = api
    @message = message
    @field = field
  end

  def name
    @field.name
  end

  def doc_types
    field_doc_types @field, false
  end

  def doc_attribute_type
    mode = @field.output_only? ? "r" : "rw"
    "@!attribute [#{mode}] #{@field.name}"
  end

  def output_doc_types
    field_doc_types @field, true
  end

  def doc_description
    @field.docs_leading_comments
  end

  def default_value
    single = default_singular_value
    return "[#{single}]" if @field.repeated? && !@field.map?
    single
  end

  def as_kwarg value: nil
    "#{name}: #{value || name}"
  end

  # TODO: remove, only used in tests
  def type_name
    @field.type_name
  end

  def type_name_full
    return nil if type_name.blank?
    ruby_namespace @api, type_name
  end

  def message?
    @field.message?
  end

  def enum?
    @field.enum?
  end

  def repeated?
    @field.repeated?
  end

  protected

  def field_doc_types field, output
    return field_map_type field.message, output if field.map?
    base_type =
      if field.message?
        type = message_ruby_type field.message
        output ? type : "#{type} | Hash"
      elsif field.enum?
        # TODO: handle when arg message is nil and enum is the type
        "ENUM(#{field.enum.name})"
      else
        case field.type
        when 1, 2                              then "Float"
        when 3, 4, 5, 6, 7, 13, 15, 16, 17, 18 then "Integer"
        when 9, 12                             then "String"
        when 8                                 then "Boolean"
        else
          "Object"
        end
      end
    field.repeated? ? "Array<#{base_type}>" : base_type
  end

  def field_map_type entry_message, output
    key_field = value_field = nil
    entry_message.fields.each do |field|
      key_field = field if field.name == "key"
      value_field = field if field.name == "value"
    end
    class_name = output ? "Google::Protobuf::Map" : "Hash"
    if key_field && value_field
      key_type = field_doc_types key_field, output
      value_type = field_doc_types value_field, output
      "#{class_name}{#{key_type} => #{value_type}}"
    else
      class_name
    end
  end

  def default_singular_value
    if @field.message?
      "{}"
    elsif @field.enum?
      # TODO: select the first non-0 enum value
      ":#{@field.enum.values.first.name}"
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

  def message_ruby_type message
    ruby_namespace @api, message.address.join(".")
  end
end
