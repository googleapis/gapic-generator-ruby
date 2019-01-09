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


require "json"
require "pathname"

require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

require "google/cloud/operations/v1/cloud_operations_pb"
require "google/cloud/operations/v1/credentials"


module Google
module Longrunning
##
# Manages long-running operations with an API service.
#
# When an API method normally takes long time to complete, it can be designed
# to return [Operation][google.longrunning.Operation] to the client, and the client can use this
# interface to receive the real response asynchronously by polling the
# operation resource, or pass the operation resource to another API (such as
# Google Cloud Pub/Sub API) to receive the response.  Any API service that
# returns long-running operations should implement the `Operations` interface
# so developers can have a consistent client experience.
class OperationsClient
  # @private
  attr_reader :operations_stub

  # The default address of the service.
  SERVICE_ADDRESS = "operations.googleapis.com"

  # The default port of the service.
  DEFAULT_SERVICE_PORT = 443

  # The default set of gRPC interceptors.
  GRPC_INTERCEPTORS = [].freeze

  DEFAULT_TIMEOUT = 30

  # The scopes needed to make gRPC calls to all of the methods defined in
  # this service.
  ALL_SCOPES = [
    "https://www.googleapis.com/auth/cloud-platform"
  ].freeze

  # @private
  class OperationsClient < Google::Longrunning::OperationsClient
    SERVICE_ADDRESS = OperationsClient::SERVICE_ADDRESS
    GRPC_INTERCEPTORS = OperationsClient::GRPC_INTERCEPTORS.dup
  end

  ##
  # @param credentials [Google::Auth::Credentials, String, Hash,
  #   GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
  #   Provides the means for authenticating requests made by the client. This parameter can
  #   be many types.
  #   A `Google::Auth::Credentials` uses a the properties of its represented keyfile for
  #   authenticating requests made by this client.
  #   A `String` will be treated as the path to the keyfile to be used for the construction of
  #   credentials for this client.
  #   A `Hash` will be treated as the contents of a keyfile to be used for the construction of
  #   credentials for this client.
  #   A `GRPC::Core::Channel` will be used to make calls through.
  #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The channel credentials
  #   should already be composed with a `GRPC::Core::CallCredentials` object.
  #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc transforms the
  #   metadata for requests, generally, to give OAuth credentials.
  # @param scopes [Array<String>]
  #   The OAuth scopes for this service. This parameter is ignored if
  #   an updater_proc is supplied.
  # @param client_config [Hash]
  #   A Hash for call options for each method. See
  #   Google::Gax#construct_settings for the structure of
  #   this data. Falls back to the default config if not specified
  #   or the specified config is missing data points.
  # @param timeout [Numeric]
  #   The default timeout, in seconds, for calls made through this client.
  # @param metadata [Hash]
  #   Default metadata to be sent with each request. This can be overridden on a per call basis.
  # @param exception_transformer [Proc]
  #   An optional proc that intercepts any exceptions raised during an API call to inject
  #   custom error handling.
  #
  def initialize \
      credentials: nil,
      scopes: ALL_SCOPES,
      client_config: {},
      timeout: DEFAULT_TIMEOUT,
      metadata: nil,
      exception_transformer: nil,
      lib_name: nil,
      lib_version: ""
    # These require statements are intentionally placed here to initialize
    # the gRPC module only when it's required.
    # See https://github.com/googleapis/toolkit/issues/446
    require "google/gax/grpc"
    require "google/cloud/operations/v1/cloud_operations_services_pb"

    credentials ||= Google::Cloud::Operations::V1::Credentials.default

    @operations_client = OperationsClient.new(
      credentials: credentials,
      scopes: scopes,
      client_config: client_config,
      timeout: timeout,
      lib_name: lib_name,
      lib_version: lib_version
    )
    @operations_stub = create_stub credentials, scopes

    defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

@list_operations = Google::Gax.create_api_call(
@operations_stub.method(:list_operations),
defaults["list_operations"],
exception_transformer: exception_transformer
)
@get_operation = Google::Gax.create_api_call(
@operations_stub.method(:get_operation),
defaults["get_operation"],
exception_transformer: exception_transformer
)
@delete_operation = Google::Gax.create_api_call(
@operations_stub.method(:delete_operation),
defaults["delete_operation"],
exception_transformer: exception_transformer
)
@cancel_operation = Google::Gax.create_api_call(
@operations_stub.method(:cancel_operation),
defaults["cancel_operation"],
exception_transformer: exception_transformer
)
  end

  # Service calls

  ##
  #  Lists operations that match the specified filter in the request. If the
  #  server doesn't support this method, it returns `UNIMPLEMENTED`.
  # 
  #  NOTE: the `name` binding below allows API services to override the binding
  #  to use different resource name schemes, such as `users/*/operations`.
  def list_operations \
      name,
      filter,
      page_size,
      page_token,
      options: nil,
      &block
    request = {
      name: name,
      filter: filter,
      page_size: page_size,
      page_token: page_token,
    }.delete_if { |_, v| v.nil? }
    request = Google::Gax.to_proto request, Google::Longrunning::ListOperationsRequest
    @list_operations.call(request, options, &block)
  end
  ##
  #  Gets the latest state of a long-running operation.  Clients can use this
  #  method to poll the operation result at intervals as recommended by the API
  #  service.
  def get_operation \
      name,
      options: nil,
      &block
    request = {
      name: name,
    }.delete_if { |_, v| v.nil? }
    request = Google::Gax.to_proto request, Google::Longrunning::GetOperationRequest
    @get_operation.call(request, options, &block)
  end
  ##
  #  Deletes a long-running operation. This method indicates that the client is
  #  no longer interested in the operation result. It does not cancel the
  #  operation. If the server doesn't support this method, it returns
  #  `google.rpc.Code.UNIMPLEMENTED`.
  def delete_operation \
      name,
      options: nil,
      &block
    request = {
      name: name,
    }.delete_if { |_, v| v.nil? }
    request = Google::Gax.to_proto request, Google::Longrunning::DeleteOperationRequest
    @delete_operation.call(request, options, &block)
  end
  ##
  #  Starts asynchronous cancellation on a long-running operation.  The server
  #  makes a best effort to cancel the operation, but success is not
  #  guaranteed.  If the server doesn't support this method, it returns
  #  `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
  #  [Operations.GetOperation][google.longrunning.Operations.GetOperation] or
  #  other methods to check whether the cancellation succeeded or whether the
  #  operation completed despite cancellation. On successful cancellation,
  #  the operation is not deleted; instead, it becomes an operation with
  #  an [Operation.error][google.longrunning.Operation.error] value with a [google.rpc.Status.code][google.rpc.Status.code] of 1,
  #  corresponding to `Code.CANCELLED`.
  def cancel_operation \
      name,
      options: nil,
      &block
    request = {
      name: name,
    }.delete_if { |_, v| v.nil? }
    request = Google::Gax.to_proto request, Google::Longrunning::CancelOperationRequest
    @cancel_operation.call(request, options, &block)
  end

  protected

  def create_stub credentials, scopes
    if credentials.is_a?(String) || credentials.is_a?(Hash)
      updater_proc = Google::Cloud::Operations::V1::Credentials.new(credentials).updater_proc
    elsif credentials.is_a? GRPC::Core::Channel
      channel = credentials
    elsif credentials.is_a? GRPC::Core::ChannelCredentials
      chan_creds = credentials
    elsif credentials.is_a? Proc
      updater_proc = credentials
    elsif credentials.is_a? Google::Auth::Credentials
      updater_proc = credentials.updater_proc
    end

    # Allow overriding the service path/port in subclasses.
    service_path = self.class::SERVICE_ADDRESS
    port = self.class::DEFAULT_SERVICE_PORT
    interceptors = self.class::GRPC_INTERCEPTORS
    stub_new = Google::Cloud::Operations::V1::Operations::Stub.method :new
    Google::Gax::Grpc.create_stub(
      service_path,
      port,
      chan_creds: chan_creds,
      channel: channel,
      updater_proc: updater_proc,
      scopes: scopes,
      interceptors: interceptors,
      &stub_new
    )
  end

  def default_settings client_config, timeout, metadata, lib_name, lib_version
    package_version = Gem.loaded_specs["google-cloud-operations"].version.version

    google_api_client = ["gl-ruby/#{RUBY_VERSION}"]
    google_api_client << " #{lib_name}/#{lib_version}" if lib_name
    google_api_client << " gapic/#{package_version} gax/#{Google::Gax::VERSION}"
    google_api_client << " grpc/#{GRPC::VERSION}"
    google_api_client.join

    headers = { "x-goog-api-client": google_api_client }
    headers.merge! metadata unless metadata.nil?
    client_config_file = Pathname.new(__dir__).join(
      "operations_client_config.json"
    )
    client_config_file.open do |f|
      Google::Gax.construct_settings(
        "google.cloud.operations.v1.Operations",
        JSON.parse(f.read),
        client_config,
        Google::Gax::Grpc::STATUS_CODE_NAMES,
        timeout,
        errors: Google::Gax::Grpc::API_ERRORS,
        metadata: headers
      )
    end
  end
end
end
end

