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

require "test_helper"

# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength
class GapicDumpTest < Minitest::Test
  def test_gapic_dump
    provider = ActionController::Base.new
    provider.prepend_view_path "templates/gapic_dump"
    output_files = {}
    provider.render_to_string(
      template: "gapic_dump",
      formats: :text,
      layout: nil,
      assigns: { api: api, output_files: output_files }
    )
    file_name = "gapic_dump.txt"
    assert_equal expected_content(file_name), output_files[file_name]
  end

  # Test fixtures
  # TODO: Replace OpenStruct with correct proto types from
  # lib/google/gapic/schema/wrappers.rb

  def api
    OpenStruct.new(
      messages: messages("Http"),
      enums: enums("FieldBehavior"),
      services: services("Operations")
    )
  end

  def messages names
    Array(names).map do |name|
      message_fields = [
        [
          "rules",
          { message: "#<Google::Gapic::Schema::Message:0x00007fd89e97b7c8>" }
        ],
        [
          "fully_decode_reserved_expansion",
          { type: 8 }
        ]
      ]
      OpenStruct.new(
        address: address(name),
        fields: fields(name, message_fields),
        leading_comments: leading_comments(name),
        name: name,
        trailing_comments: trailing_comments(name)
      )
    end
  end

  def fields parent_path, names_and_types
    Array(names_and_types).map do |name_and_type|
      name = name_and_type[0]
      type = name_and_type[1].keys.first
      f = OpenStruct.new(
        address: address([parent_path, name]),
        leading_comments: leading_comments(name),
        name: name,
        trailing_comments: trailing_comments(name)
      )
      f.send "#{type}=", name_and_type[1][type]
      f
    end
  end

  def enums names
    Array(names).map do |name|
      OpenStruct.new(
        address: address(name),
        leading_comments: leading_comments(name),
        name: name,
        trailing_comments: trailing_comments(name),
        values: values(name, %w[FIELD_BEHAVIOR_UNSPECIFIED OPTIONAL])
      )
    end
  end

  def values parent_path, names
    Array(names).each_with_index.map do |name, i|
      OpenStruct.new(
        address: address([parent_path, name]),
        leading_comments: leading_comments(name),
        name: name,
        number: i,
        trailing_comments: trailing_comments(name)
      )
    end
  end

  def services names
    Array(names).map do |name|
      service_methods = [
        [
          "ListOperations",
          { message: "#<Google::Gapic::Schema::Message:0x00007fd89e97b7c8>" }
        ]
      ]
      smethods = methods name, service_methods
      s = OpenStruct.new(
        address: address(name),
        leading_comments: leading_comments(name),
        name: name,
        trailing_comments: trailing_comments(name)
      )
      s.define_singleton_method :methods do
        smethods
      end
      s
    end
  end

  def methods parent_path, names_and_types
    Array(names_and_types).map do |name_and_type|
      name = name_and_type[0]
      # type = name_and_type[1].keys.first
      OpenStruct.new(
        address: address([parent_path, name]),
        input: OpenStruct.new(name: "ListOperationsRequest"),
        leading_comments: leading_comments(name),
        name: name,
        output: OpenStruct.new(name: "ListOperationsResponse"),
        trailing_comments: trailing_comments(name)
      )
    end
  end

  def input_or_output name
    OpenStruct.new name: name
  end

  def address path
    %w[google api] + Array(path)
  end

  def leading_comments name
    "The leading comments for #{name}."
  end

  def trailing_comments name
    "The trailing comments for #{name}."
  end
end
# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/MethodLength
