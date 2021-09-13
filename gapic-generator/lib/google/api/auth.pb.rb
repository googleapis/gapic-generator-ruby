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
    class Authentication < ::Protobuf::Message; end
    class AuthenticationRule < ::Protobuf::Message; end
    class JwtLocation < ::Protobuf::Message; end
    class AuthProvider < ::Protobuf::Message; end
    class OAuthRequirements < ::Protobuf::Message; end
    class AuthRequirement < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "AuthProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Authentication
      repeated ::Google::Api::AuthenticationRule, :rules, 3
      repeated ::Google::Api::AuthProvider, :providers, 4
    end

    class AuthenticationRule
      optional :string, :selector, 1
      optional ::Google::Api::OAuthRequirements, :oauth, 2
      optional :bool, :allow_without_credential, 5
      repeated ::Google::Api::AuthRequirement, :requirements, 7
    end

    class JwtLocation
      optional :string, :header, 1
      optional :string, :query, 2
      optional :string, :value_prefix, 3
    end

    class AuthProvider
      optional :string, :id, 1
      optional :string, :issuer, 2
      optional :string, :jwks_uri, 3
      optional :string, :audiences, 4
      optional :string, :authorization_url, 5
      repeated ::Google::Api::JwtLocation, :jwt_locations, 6
    end

    class OAuthRequirements
      optional :string, :canonical_scopes, 1
    end

    class AuthRequirement
      optional :string, :provider_id, 1
      optional :string, :audiences, 2
    end

  end

end

