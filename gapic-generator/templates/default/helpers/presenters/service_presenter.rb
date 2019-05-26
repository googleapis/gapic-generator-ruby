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
require_relative "gem_presenter"
require_relative "package_presenter"
require_relative "resource_presenter"
require_relative "method_presenter"

class ServicePresenter
  include FilepathHelper
  include NamespaceHelper

  def initialize service
    @service = service
  end

  def gem
    GemPresenter.new @service.parent.parent
  end

  def package
    PackagePresenter.new @service.parent.parent, @service.parent.package
  end

  def methods
    @methods ||= begin
      @service.methods.map { |m| MethodPresenter.new m }
    end
  end

  def namespaces
    @service.address
  end

  def version
    ActiveSupport::Inflector.camelize @service.address[-2]
  end

  def name
    @service.name
  end

  def proto_service_name_full
    ruby_namespace @service.address
  end

  def proto_service_file_path
    if @service.parent
      @service.parent.name.sub ".proto", "_pb.rb"
    else
      ruby_file_path(@service).sub ".rb", "_pb.rb"
    end
  end

  def proto_service_file_name
    proto_service_file_path.split("/").last
  end

  def proto_service_require
    proto_service_file_path.sub ".rb", ""
  end

  def proto_services_file_path
    if @service.parent
      @service.parent.name.sub ".proto", "_services_pb.rb"
    else
      ruby_file_path(@service).sub ".rb", "_services_pb.rb"
    end
  end

  def proto_services_file_name
    proto_services_file_path.split("/").last
  end

  def proto_services_require
    proto_services_file_path.sub ".rb", ""
  end

  def proto_service_stub_name_full
    "#{proto_service_name_full}::Stub"
  end

  def service_file_path
    ruby_file_path @service
  end

  def service_file_name
    service_file_path.split("/").last
  end

  def service_require
    service_file_path.sub ".rb", ""
  end

  def client_name
    "Client"
  end

  def client_name_full
    "#{proto_service_name_full}::#{client_name}"
  end

  def client_require
    class_namespace = @service.address.dup
    class_namespace.push client_name
    class_namespace.map(&:underscore).join "/"
  end

  def client_file_path
    client_require + ".rb"
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
    @service.scopes || default_config(:oauth_scopes)
  end

  def client_proto_name
    @service.address.join(".")
  end

  def credentials_name
    "Credentials"
  end

  def credentials_name_full
    "#{proto_service_name_full}::#{credentials_name}"
  end

  def credentials_file_path
    credentials_require + ".rb"
  end

  def credentials_file_name
    "#{credentials_name.underscore}.rb"
  end

  def credentials_require
    credentials_namespace = @service.address.dup
    credentials_namespace.push credentials_name
    credentials_namespace.map(&:underscore).join "/"
  end

  def helpers_file_path
    helpers_require + ".rb"
  end

  def helpers_file_name
    "helpers.rb"
  end

  def helpers_require
    helpers_namespace = @service.address.dup
    helpers_namespace.push "helpers"
    helpers_namespace.map(&:underscore).join "/"
  end

  def references
    @references ||= begin
      m = @service.parent.messages.select { |m| m.fields.select(&:resource).any? }
      pairs = m.map { |m1| [m1.name, m1.fields.map(&:resource).compact.first.pattern] }
      pairs.sort_by! { |name, tmplt| name }
      pairs.map { |name, tmplt| ResourcePresenter.new name, tmplt }
    end
  end

  def paths?
    references.any?
  end

  def paths_name
    "Paths"
  end

  def paths_name_full
    "#{proto_service_name_full}::#{paths_name}"
  end

  def paths_file_path
    paths_require + ".rb"
  end

  def paths_file_name
    "#{paths_name.underscore}.rb"
  end

  def paths_require
    helpers_namespace = @service.address.dup
    helpers_namespace.push paths_name
    helpers_namespace.map(&:underscore).join "/"
  end

  def test_client_file_path
    service_file_path.sub ".rb", "_test.rb"
  end

  def stub_name
    "#{ActiveSupport::Inflector.underscore name}_stub"
  end

  def lro?
    methods.find(&:lro?)
  end

  def lro_client_var
    "operations_client"
  end

  def lro_client_ivar
    "@#{lro_client_var}"
  end

  def operations_name
    "Operations"
  end

  def operations_name_full
    "#{proto_service_name_full}::#{operations_name}"
  end

  def operations_file_path
    operations_require + ".rb"
  end

  def operations_file_name
    "#{operations_name.underscore}.rb"
  end

  def operations_require
    operations_namespace = @service.address.dup
    operations_namespace.push operations_name
    operations_namespace.map(&:underscore).join "/"
  end

  def lro_service
    lro = @service.parent.parent.files.find { |file| file.name == "google/longrunning/operations.proto" }

    return ServicePresenter.new lro.services.first unless lro.nil?
  end

  private

  def lookup_default_host
    @service.host || default_config(:default_host) || "localhost"
  end

  def default_config key
    return unless @service.parent.parent.configuration[:defaults]
    return unless @service.parent.parent.configuration[:defaults][:service]

    @service.parent.parent.configuration[:defaults][:service][key]
  end
end
