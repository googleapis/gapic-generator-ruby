# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/showcase/v1beta1/testing.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/resource_pb'
require 'google/protobuf/empty_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/showcase/v1beta1/testing.proto", :syntax => :proto3) do
    add_message "google.showcase.v1beta1.Session" do
      optional :name, :string, 1
      optional :version, :enum, 2, "google.showcase.v1beta1.Session.Version"
    end
    add_enum "google.showcase.v1beta1.Session.Version" do
      value :VERSION_UNSPECIFIED, 0
      value :V1_LATEST, 1
      value :V1_0, 2
    end
    add_message "google.showcase.v1beta1.CreateSessionRequest" do
      optional :session, :message, 1, "google.showcase.v1beta1.Session"
    end
    add_message "google.showcase.v1beta1.GetSessionRequest" do
      optional :name, :string, 1
    end
    add_message "google.showcase.v1beta1.ListSessionsRequest" do
      optional :page_size, :int32, 1
      optional :page_token, :string, 2
    end
    add_message "google.showcase.v1beta1.ListSessionsResponse" do
      repeated :sessions, :message, 1, "google.showcase.v1beta1.Session"
      optional :next_page_token, :string, 2
    end
    add_message "google.showcase.v1beta1.DeleteSessionRequest" do
      optional :name, :string, 1
    end
    add_message "google.showcase.v1beta1.ReportSessionRequest" do
      optional :name, :string, 1
    end
    add_message "google.showcase.v1beta1.ReportSessionResponse" do
      optional :result, :enum, 1, "google.showcase.v1beta1.ReportSessionResponse.Result"
      repeated :test_runs, :message, 2, "google.showcase.v1beta1.TestRun"
    end
    add_enum "google.showcase.v1beta1.ReportSessionResponse.Result" do
      value :RESULT_UNSPECIFIED, 0
      value :PASSED, 1
      value :FAILED, 2
      value :INCOMPLETE, 3
    end
    add_message "google.showcase.v1beta1.Test" do
      optional :name, :string, 1
      optional :expectation_level, :enum, 2, "google.showcase.v1beta1.Test.ExpectationLevel"
      optional :description, :string, 3
      repeated :blueprints, :message, 4, "google.showcase.v1beta1.Test.Blueprint"
    end
    add_message "google.showcase.v1beta1.Test.Blueprint" do
      optional :name, :string, 1
      optional :description, :string, 2
      optional :request, :message, 3, "google.showcase.v1beta1.Test.Blueprint.Invocation"
      repeated :additional_requests, :message, 4, "google.showcase.v1beta1.Test.Blueprint.Invocation"
    end
    add_message "google.showcase.v1beta1.Test.Blueprint.Invocation" do
      optional :method, :string, 1
      optional :serialized_request, :bytes, 2
    end
    add_enum "google.showcase.v1beta1.Test.ExpectationLevel" do
      value :EXPECTATION_LEVEL_UNSPECIFIED, 0
      value :REQUIRED, 1
      value :RECOMMENDED, 2
      value :OPTIONAL, 3
    end
    add_message "google.showcase.v1beta1.Issue" do
      optional :type, :enum, 1, "google.showcase.v1beta1.Issue.Type"
      optional :severity, :enum, 2, "google.showcase.v1beta1.Issue.Severity"
      optional :description, :string, 3
    end
    add_enum "google.showcase.v1beta1.Issue.Type" do
      value :TYPE_UNSPECIFIED, 0
      value :SKIPPED, 1
      value :PENDING, 2
      value :INCORRECT_CONFIRMATION, 3
    end
    add_enum "google.showcase.v1beta1.Issue.Severity" do
      value :SEVERITY_UNSPECIFIED, 0
      value :ERROR, 1
      value :WARNING, 2
    end
    add_message "google.showcase.v1beta1.ListTestsRequest" do
      optional :parent, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "google.showcase.v1beta1.ListTestsResponse" do
      repeated :tests, :message, 1, "google.showcase.v1beta1.Test"
      optional :next_page_token, :string, 2
    end
    add_message "google.showcase.v1beta1.TestRun" do
      optional :test, :string, 1
      optional :issue, :message, 2, "google.showcase.v1beta1.Issue"
    end
    add_message "google.showcase.v1beta1.DeleteTestRequest" do
      optional :name, :string, 1
    end
    add_message "google.showcase.v1beta1.VerifyTestRequest" do
      optional :name, :string, 1
      optional :answer, :bytes, 2
      repeated :answers, :bytes, 3
    end
    add_message "google.showcase.v1beta1.VerifyTestResponse" do
      optional :issue, :message, 1, "google.showcase.v1beta1.Issue"
    end
  end
end

module Google
  module Showcase
    module V1beta1
      Session = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Session").msgclass
      Session::Version = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Session.Version").enummodule
      CreateSessionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.CreateSessionRequest").msgclass
      GetSessionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.GetSessionRequest").msgclass
      ListSessionsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListSessionsRequest").msgclass
      ListSessionsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListSessionsResponse").msgclass
      DeleteSessionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.DeleteSessionRequest").msgclass
      ReportSessionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ReportSessionRequest").msgclass
      ReportSessionResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ReportSessionResponse").msgclass
      ReportSessionResponse::Result = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ReportSessionResponse.Result").enummodule
      Test = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Test").msgclass
      Test::Blueprint = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Test.Blueprint").msgclass
      Test::Blueprint::Invocation = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Test.Blueprint.Invocation").msgclass
      Test::ExpectationLevel = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Test.ExpectationLevel").enummodule
      Issue = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Issue").msgclass
      Issue::Type = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Issue.Type").enummodule
      Issue::Severity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Issue.Severity").enummodule
      ListTestsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListTestsRequest").msgclass
      ListTestsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListTestsResponse").msgclass
      TestRun = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.TestRun").msgclass
      DeleteTestRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.DeleteTestRequest").msgclass
      VerifyTestRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.VerifyTestRequest").msgclass
      VerifyTestResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.VerifyTestResponse").msgclass
    end
  end
end
