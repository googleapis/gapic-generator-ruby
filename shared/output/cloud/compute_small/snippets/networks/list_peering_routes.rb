# frozen_string_literal: true

# Copyright 2023 Google LLC
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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

# [START compute_v1_generated_Networks_ListPeeringRoutes_sync]
require "google/cloud/compute/v1"

##
# Snippet for the list_peering_routes call in the Networks service
#
# This is an auto-generated example demonstrating basic usage of
# Google::Cloud::Compute::V1::Networks::Rest::Client#list_peering_routes. It may
# require modification in order to execute successfully.
#
def list_peering_routes
  # Create a client object. The client can be reused for multiple calls.
  client = Google::Cloud::Compute::V1::Networks::Rest::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = Google::Cloud::Compute::V1::ListPeeringRoutesNetworksRequest.new

  # Call the list_peering_routes method.
  result = client.list_peering_routes request

  # The returned object is of type Google::Cloud::Compute::V1::ExchangedPeeringRoutesList.
  p result
end
# [END compute_v1_generated_Networks_ListPeeringRoutes_sync]
