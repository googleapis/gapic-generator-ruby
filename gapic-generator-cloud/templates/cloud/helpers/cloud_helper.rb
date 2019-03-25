# frozen_string_literal: true

# Copyright 2018 Google LLC
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

module CloudHelper
  def gem_name api
    api.configuration[:gem_name] || gem_address(api).join("-")
  end

  def gem_path api
    gem_address(api).join "/"
  end

  def gem_address api
    s = api_services(api).first
    version = s.address.find { |x| x =~ /^v[0-9][0-9a-z.]*\z/ }
    version_index = s.address.index version
    version_index ||= -2 # service and version
    s.address[0...version_index]
  end

  def gem_title api, service = nil
    if service && service.client_package
      title = service.client_package.title
      return title unless title.empty?
    end

    api.configuration[:gem_title] || gem_address(api).map(&:classify).join(" ")
  end

  def gem_authors api
    api.configuration[:gem_authors] || ["Google LLC"]
  end

  def gem_email api
    api.configuration[:gem_email] || "googleapis-packages@google.com"
  end

  def gem_description api, service = nil
    api.configuration[:gem_description] ||
      "#{gem_name api} is the official library for #{gem_title api, service} API."
  end

  def gem_summary api
    api.configuration[:gem_summary] || "API Client library for #{gem_title api} API"
  end

  def gem_homepage api
    api.configuration[:gem_homepage] || "https://github.com/googleapis/googleapis"
  end

  def client_lro? _service
    true # TODO
  end

  def service_name service
    service.name
  end


  def service_proto_name_full service
    ruby_namespace service.address
  end

  def service_proto_file_path service
    if service.parent
      service.parent.name.sub ".proto", "_pb.rb"
    else
      ruby_file_path(service).sub ".rb", "_pb.rb"
    end
  end

  def service_proto_file_name service
    service_proto_file_path(service).split("/").last
  end

  def service_proto_require service
    service_proto_file_path(service).sub ".rb", ""
  end


  def services_proto_name_full service
    ruby_namespace service.address
  end

  def services_proto_file_path service
    if service.parent
      service.parent.name.sub ".proto", "_services_pb.rb"
    else
      ruby_file_path(service).sub ".rb", "_services_pb.rb"
    end
  end

  def services_proto_file_name service
    services_proto_file_path(service).split("/").last
  end

  def services_proto_require service
    services_proto_file_path(service).sub ".rb", ""
  end


  def services_stub_name_full service
    "#{services_proto_name_full service}::Stub"
  end


  def client_file_path service
    ruby_file_path service
  end

  def client_file_name service
    client_file_path(service).split("/").last
  end

  def client_require service
    client_file_path(service).sub ".rb", ""
  end


  def client_name_full service
    service_proto_name_full service
  end

  def client_test_file_path service
    client_file_path(service).sub ".rb", "_test.rb"
  end

  def helpers_require service
    helpers_namespace = service.address.dup
    helpers_namespace.pop
    helpers_namespace.push "helpers"
    helpers_namespace.map(&:underscore).join "/"
  end

  def helpers_file_path service
    helpers_require(service) + ".rb"
  end

  def client_address service
    address = service.host
    address ||= service.parent.parent.configuration[:default_host]

    raise "Unknown default_host for #{service.name}" if address.nil?

    address.split(":").first
  end

  def client_port service
    address = service.host
    address ||= service.parent.parent.configuration[:default_host]

    raise "Unknown default_host for #{service.name}" if address.nil?

    host, *port = address.split ":"
    port << 443 # push the default port on in case there is none
    port.first
  end

  def client_scopes service
    service.scopes || service.parent.parent.configuration[:oauth_scopes]
  end

  def client_proto_name service
    service.address.join(".")
  end


  def credentials_file_path api
    s = api_services(api).first
    path_nodes = ruby_file_path(s).split "/"
    path_nodes.pop
    path_nodes << "credentials.rb"
    path_nodes.join "/"
  end

  def credentials_class_name _service
    "Credentials"
  end

  def credentials_class_full service
    credentials_class_namespace = service.address.dup
    credentials_class_namespace.pop
    credentials_class_namespace.push credentials_class_name(service)
    ruby_namespace credentials_class_namespace
  end

  def credentials_require service
    credentials_class_namespace = service.address.dup
    credentials_class_namespace.pop
    credentials_class_namespace.push credentials_class_name(service)
    credentials_class_namespace.map(&:underscore).join "/"
  end

  def credentials_file_path service
    credentials_require(service) + ".rb"
  end
end
