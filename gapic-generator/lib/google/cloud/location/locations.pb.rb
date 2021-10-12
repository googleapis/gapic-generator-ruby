# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'
require 'protobuf/rpc/service'


##
# Imports
#
require 'google/api/annotations.pb'
require 'google/protobuf/any.pb'

module Google
  module Cloud
    module Location
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class ListLocationsRequest < ::Protobuf::Message; end
      class ListLocationsResponse < ::Protobuf::Message; end
      class GetLocationRequest < ::Protobuf::Message; end
      class Location < ::Protobuf::Message
      end



      ##
      # File Options
      #
      set_option :java_package, "com.google.cloud.location"
      set_option :java_outer_classname, "LocationsProto"
      set_option :java_multiple_files, true
      set_option :go_package, "google.golang.org/genproto/googleapis/cloud/location;location"
      set_option :cc_enable_arenas, true


      ##
      # Message Fields
      #
      class ListLocationsRequest
        optional :string, :name, 1
        optional :string, :filter, 2
        optional :int32, :page_size, 3
        optional :string, :page_token, 4
      end

      class ListLocationsResponse
        repeated ::Google::Cloud::Location::Location, :locations, 1
        optional :string, :next_page_token, 2
      end

      class GetLocationRequest
        optional :string, :name, 1
      end

      class Location
        optional :string, :name, 1
        optional :string, :location_id, 4
        optional :string, :display_name, 5
        map :string, :string, :labels, 2
        optional ::Google::Protobuf::Any, :metadata, 3
      end


      ##
      # Service Classes
      #
      class Locations < ::Protobuf::Rpc::Service
        rpc :list_locations, ::Google::Cloud::Location::ListLocationsRequest, ::Google::Cloud::Location::ListLocationsResponse do
          set_option :".google.api.http", { :get => "/v1/{name=projects/*}/locations" }
        end
        rpc :get_location, ::Google::Cloud::Location::GetLocationRequest, ::Google::Cloud::Location::Location do
          set_option :".google.api.http", { :get => "/v1/{name=projects/*/locations/*}" }
        end
      end

    end

  end

end

