# frozen_string_literal: true

# Copyright 2019 Google LLC
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

require "active_support/inflector"
require_relative "api_presenter"
require_relative "package_presenter"
require_relative "method_presenter"

class ServicePresenter
  include FilepathHelper
  include NamespaceHelper

  def initialize service
    @service = service
  end

  def api
    ApiPresenter.new @service.parent.parent
  end

  def package
    PackagePresenter.new @service.parent.parent, service.package
  end

  def methods
    @methods ||= begin
      @service.methods.map { |m| MethodPresenter.new m }
    end
  end

  def namespaces
    @service.address.map do |node|
      ActiveSupport::Inflector.classify node
    end
  end

  def version
    ActiveSupport::Inflector.classify @service.address[-2]
  end

  def name
    @service.name
  end

  def service_proto_name_full
    ruby_namespace @service.address
  end

  def service_proto_file_path
    if @service.parent
      @service.parent.name.sub ".proto", "_pb.rb"
    else
      ruby_file_path(@service).sub ".rb", "_pb.rb"
    end
  end

  def service_proto_file_name
    service_proto_file_path.split("/").last
  end

  def service_proto_require
    service_proto_file_path.sub ".rb", ""
  end


  def services_proto_name_full
    ruby_namespace @service.address
  end

  def services_proto_file_path
    if @service.parent
      @service.parent.name.sub ".proto", "_services_pb.rb"
    else
      ruby_file_path(@service).sub ".rb", "_services_pb.rb"
    end
  end

  def services_proto_file_name
    services_proto_file_path.split("/").last
  end

  def services_proto_require
    services_proto_file_path.sub ".rb", ""
  end

  def services_stub_name_full
    "#{services_proto_name_full}::Stub"
  end

  def client_file_path
    ruby_file_path @service
  end

  def client_file_name
    client_file_path.split("/").last
  end

  def client_require
    client_file_path.sub ".rb", ""
  end

  def client_name_full
    service_proto_name_full
  end

  def client_class_name
    "Client"
  end

  def client_class_name_full
    "#{service_proto_name_full}::#{client_class_name}"
  end

  def client_lro?
    true # TODO: Make not fake
  end

  def client_address
    lookup_default_host.split(":").first
  end

  def client_port
    host, *ports = lookup_default_host.split ":"
    ports << "443" # push the default port on in case there is none
    ports.first
  end

  def client_scopes
    @service.scopes || configuration[:oauth_scopes]
  end

  def client_proto_name
    @service.address.join(".")
  end

  def credentials_class_name
    "Credentials"
  end

  def credentials_class_full
    "#{service_proto_name_full}::#{credentials_class_name}"
  end

  def helpers_require
    helpers_namespace = @service.address.dup
    helpers_namespace.push "helpers"
    helpers_namespace.map(&:underscore).join "/"
  end

  def helpers_file_path
    helpers_require(service) + ".rb"
  end

  def client_test_file_path
    client_file_path.sub ".rb", "_test.rb"
  end

  protected

  def configuration
    @service.parent.parent.configuration
  end

  def lookup_default_host
    @service.host || configuration[:default_host] || "localhost"
  end
end
