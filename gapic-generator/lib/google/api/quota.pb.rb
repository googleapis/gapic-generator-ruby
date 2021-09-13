# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Quota < ::Protobuf::Message; end
    class MetricRule < ::Protobuf::Message
    end

    class QuotaLimit < ::Protobuf::Message
    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "QuotaProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Quota
      repeated ::Google::Api::QuotaLimit, :limits, 3
      repeated ::Google::Api::MetricRule, :metric_rules, 4
    end

    class MetricRule
      optional :string, :selector, 1
      map :string, :int64, :metric_costs, 2
    end

    class QuotaLimit
      optional :string, :name, 6
      optional :string, :description, 2
      optional :int64, :default_limit, 3
      optional :int64, :max_limit, 4
      optional :int64, :free_tier, 7
      optional :string, :duration, 5
      optional :string, :metric, 8
      optional :string, :unit, 9
      map :string, :int64, :values, 10
      optional :string, :display_name, 12
    end

  end

end

