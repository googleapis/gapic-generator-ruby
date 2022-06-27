# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/showcase/v1beta1/compliance.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/showcase/v1beta1/compliance.proto", :syntax => :proto3) do
    add_message "google.showcase.v1beta1.RepeatRequest" do
      optional :name, :string, 1
      optional :info, :message, 2, "google.showcase.v1beta1.ComplianceData"
      optional :server_verify, :bool, 3
      optional :f_int32, :int32, 4
      optional :f_int64, :int64, 5
      optional :f_double, :double, 6
      proto3_optional :p_int32, :int32, 7
      proto3_optional :p_int64, :int64, 8
      proto3_optional :p_double, :double, 9
    end
    add_message "google.showcase.v1beta1.RepeatResponse" do
      optional :request, :message, 1, "google.showcase.v1beta1.RepeatRequest"
    end
    add_message "google.showcase.v1beta1.ComplianceSuite" do
      repeated :group, :message, 1, "google.showcase.v1beta1.ComplianceGroup"
    end
    add_message "google.showcase.v1beta1.ComplianceGroup" do
      optional :name, :string, 1
      repeated :rpcs, :string, 2
      repeated :requests, :message, 3, "google.showcase.v1beta1.RepeatRequest"
    end
    add_message "google.showcase.v1beta1.ComplianceData" do
      optional :f_string, :string, 1
      optional :f_int32, :int32, 2
      optional :f_sint32, :sint32, 3
      optional :f_sfixed32, :sfixed32, 4
      optional :f_uint32, :uint32, 5
      optional :f_fixed32, :fixed32, 6
      optional :f_int64, :int64, 7
      optional :f_sint64, :sint64, 8
      optional :f_sfixed64, :sfixed64, 9
      optional :f_uint64, :uint64, 10
      optional :f_fixed64, :fixed64, 11
      optional :f_double, :double, 12
      optional :f_float, :float, 13
      optional :f_bool, :bool, 14
      optional :f_bytes, :bytes, 15
      optional :f_kingdom, :enum, 22, "google.showcase.v1beta1.ComplianceData.LifeKingdom"
      optional :f_child, :message, 16, "google.showcase.v1beta1.ComplianceDataChild"
      proto3_optional :p_string, :string, 17
      proto3_optional :p_int32, :int32, 18
      proto3_optional :p_double, :double, 19
      proto3_optional :p_bool, :bool, 20
      proto3_optional :p_kingdom, :enum, 23, "google.showcase.v1beta1.ComplianceData.LifeKingdom"
      proto3_optional :p_child, :message, 21, "google.showcase.v1beta1.ComplianceDataChild"
    end
    add_enum "google.showcase.v1beta1.ComplianceData.LifeKingdom" do
      value :LIFE_KINGDOM_UNSPECIFIED, 0
      value :ARCHAEBACTERIA, 1
      value :EUBACTERIA, 2
      value :PROTISTA, 3
      value :FUNGI, 4
      value :PLANTAE, 5
      value :ANIMALIA, 6
    end
    add_message "google.showcase.v1beta1.ComplianceDataChild" do
      optional :f_string, :string, 1
      optional :f_float, :float, 2
      optional :f_double, :double, 3
      optional :f_bool, :bool, 4
      optional :f_continent, :enum, 11, "google.showcase.v1beta1.Continent"
      optional :f_child, :message, 5, "google.showcase.v1beta1.ComplianceDataGrandchild"
      proto3_optional :p_string, :string, 6
      proto3_optional :p_float, :float, 7
      proto3_optional :p_double, :double, 8
      proto3_optional :p_bool, :bool, 9
      optional :p_continent, :enum, 12, "google.showcase.v1beta1.Continent"
      proto3_optional :p_child, :message, 10, "google.showcase.v1beta1.ComplianceDataGrandchild"
    end
    add_message "google.showcase.v1beta1.ComplianceDataGrandchild" do
      optional :f_string, :string, 1
      optional :f_double, :double, 2
      optional :f_bool, :bool, 3
    end
    add_enum "google.showcase.v1beta1.Continent" do
      value :CONTINENT_UNSPECIFIED, 0
      value :AFRICA, 1
      value :AMERICA, 2
      value :ANTARTICA, 3
      value :AUSTRALIA, 4
      value :EUROPE, 5
    end
  end
end

module Google
  module Showcase
    module V1beta1
      RepeatRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.RepeatRequest").msgclass
      RepeatResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.RepeatResponse").msgclass
      ComplianceSuite = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceSuite").msgclass
      ComplianceGroup = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceGroup").msgclass
      ComplianceData = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceData").msgclass
      ComplianceData::LifeKingdom = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceData.LifeKingdom").enummodule
      ComplianceDataChild = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceDataChild").msgclass
      ComplianceDataGrandchild = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceDataGrandchild").msgclass
      Continent = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Continent").enummodule
    end
  end
end
