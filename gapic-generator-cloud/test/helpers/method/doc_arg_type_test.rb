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
require "protobuf/descriptors"
require "google/gapic/schema"
require_relative "../../../templates/cloud/helpers/method_helper"

# rubocop:disable Metrics/BlockLength
describe MethodHelper, :method_doc_arg_type do
  include MethodHelper

  def descriptor **args
    Google::Protobuf::FieldDescriptorProto.new args
  end

  def field descriptor, address, docs = nil, message = nil, enum = nil
    Google::Gapic::Schema::Field.new descriptor, address, docs, message, enum
  end

  it "knows the TYPE_DOUBLE type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_DOUBLE # 1
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String # Decimal
  end

  it "knows the TYPE_FLOAT type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_FLOAT # 2
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String # Float
  end

  it "knows the TYPE_INT64 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_INT64 # 3
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_UINT64 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_UINT64 # 4
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_INT32 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_INT32 # 5
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_FIXED64 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_FIXED64 # 6
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_FIXED32 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_FIXED32 # 7
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_BOOL type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_BOOL # 8
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_STRING type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_STRING # 9
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_GROUP type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_GROUP # 10
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_MESSAGE type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_MESSAGE # 11
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_BYTES type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_BYTES # 12
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_UINT32 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_UINT32 # 13
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_ENUM type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_ENUM # 14
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_SFIXED32 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_SFIXED32 # 15
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_SFIXED64 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_SFIXED64 # 16
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_SINT32 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_SINT32 # 17
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  it "knows the TYPE_SINT64 type" do
    type = Google::Protobuf::FieldDescriptorProto::Type::TYPE_SINT64 # 18
    arg = field(
      descriptor(name: "some_method", number: 2, label: 1, type: type),
      %w[Some Gem some_method]
    )

    method_doc_arg_type(arg).must_equal String
  end

  # TODO: Add test for streaming types.
end
# rubocop:enable Metrics/BlockLength
