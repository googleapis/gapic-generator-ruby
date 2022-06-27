# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: testing/routing_headers/routing_headers.proto

require 'google/protobuf'

require 'google/api/client_pb'
require 'google/api/annotations_pb'
require 'google/api/routing_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("testing/routing_headers/routing_headers.proto", :syntax => :proto3) do
    add_message "testing.routingheaders.Request" do
      optional :table_name, :string, 1
      optional :app_profile_id, :string, 2
      optional :resource, :message, 3, "testing.routingheaders.RequestResource"
    end
    add_message "testing.routingheaders.RequestResource" do
      optional :resource_name, :string, 1
      optional :inner, :message, 2, "testing.routingheaders.InnerResource"
    end
    add_message "testing.routingheaders.InnerResource" do
      optional :inner_name, :string, 1
    end
    add_message "testing.routingheaders.Response" do
    end
  end
end

module Testing
  module RoutingHeaders
    Request = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.Request").msgclass
    RequestResource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.RequestResource").msgclass
    InnerResource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.InnerResource").msgclass
    Response = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.Response").msgclass
  end
end
