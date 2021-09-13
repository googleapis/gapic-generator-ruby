# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/api/label.pb'
require 'google/api/launch_stage.pb'
require 'google/protobuf/duration.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class MetricDescriptor < ::Protobuf::Message
      class MetricKind < ::Protobuf::Enum
        define :METRIC_KIND_UNSPECIFIED, 0
        define :GAUGE, 1
        define :DELTA, 2
        define :CUMULATIVE, 3
      end

      class ValueType < ::Protobuf::Enum
        define :VALUE_TYPE_UNSPECIFIED, 0
        define :BOOL, 1
        define :INT64, 2
        define :DOUBLE, 3
        define :STRING, 4
        define :DISTRIBUTION, 5
        define :MONEY, 6
      end

      class MetricDescriptorMetadata < ::Protobuf::Message; end

    end

    class Metric < ::Protobuf::Message
    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "MetricProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/metric;metric"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class MetricDescriptor
      class MetricDescriptorMetadata
        optional ::Google::Api::LaunchStage, :launch_stage, 1, :deprecated => true
        optional ::Google::Protobuf::Duration, :sample_period, 2
        optional ::Google::Protobuf::Duration, :ingest_delay, 3
      end

      optional :string, :name, 1
      optional :string, :type, 8
      repeated ::Google::Api::LabelDescriptor, :labels, 2
      optional ::Google::Api::MetricDescriptor::MetricKind, :metric_kind, 3
      optional ::Google::Api::MetricDescriptor::ValueType, :value_type, 4
      optional :string, :unit, 5
      optional :string, :description, 6
      optional :string, :display_name, 7
      optional ::Google::Api::MetricDescriptor::MetricDescriptorMetadata, :metadata, 10
      optional ::Google::Api::LaunchStage, :launch_stage, 12
    end

    class Metric
      optional :string, :type, 3
      map :string, :string, :labels, 2
    end

  end

end

