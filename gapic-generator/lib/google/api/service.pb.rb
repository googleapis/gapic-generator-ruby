# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/api/auth.pb'
require 'google/api/backend.pb'
require 'google/api/billing.pb'
require 'google/api/context.pb'
require 'google/api/control.pb'
require 'google/api/documentation.pb'
require 'google/api/endpoint.pb'
require 'google/api/http.pb'
require 'google/api/label.pb'
require 'google/api/log.pb'
require 'google/api/logging.pb'
require 'google/api/metric.pb'
require 'google/api/monitored_resource.pb'
require 'google/api/monitoring.pb'
require 'google/api/quota.pb'
require 'google/api/resource.pb'
require 'google/api/source_info.pb'
require 'google/api/system_parameter.pb'
require 'google/api/usage.pb'
require 'google/protobuf/any.pb'
require 'google/protobuf/api.pb'
require 'google/protobuf/type.pb'
require 'google/protobuf/wrappers.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Service < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "ServiceProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Service
      optional ::Google::Protobuf::UInt32Value, :config_version, 20
      optional :string, :name, 1
      optional :string, :id, 33
      optional :string, :title, 2
      optional :string, :producer_project_id, 22
      repeated ::Google::Protobuf::Api, :apis, 3
      repeated ::Google::Protobuf::Type, :types, 4
      repeated ::Google::Protobuf::Enum, :enums, 5
      optional ::Google::Api::Documentation, :documentation, 6
      optional ::Google::Api::Backend, :backend, 8
      optional ::Google::Api::Http, :http, 9
      optional ::Google::Api::Quota, :quota, 10
      optional ::Google::Api::Authentication, :authentication, 11
      optional ::Google::Api::Context, :context, 12
      optional ::Google::Api::Usage, :usage, 15
      repeated ::Google::Api::Endpoint, :endpoints, 18
      optional ::Google::Api::Control, :control, 21
      repeated ::Google::Api::LogDescriptor, :logs, 23
      repeated ::Google::Api::MetricDescriptor, :metrics, 24
      repeated ::Google::Api::MonitoredResourceDescriptor, :monitored_resources, 25
      optional ::Google::Api::Billing, :billing, 26
      optional ::Google::Api::Logging, :logging, 27
      optional ::Google::Api::Monitoring, :monitoring, 28
      optional ::Google::Api::SystemParameters, :system_parameters, 29
      optional ::Google::Api::SourceInfo, :source_info, 37
    end

  end

end

