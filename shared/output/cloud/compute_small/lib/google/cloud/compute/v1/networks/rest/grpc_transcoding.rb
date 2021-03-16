# frozen_string_literal: true

# Copyright 2021 Google LLC
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


module Google
  module Cloud
    module Compute
      module V1
        module Networks
          module Rest
            # GRPC transcoding helper methods for the Networks REST API.
            module GrpcTranscoding
              # @param request_pb [::Google::Cloud::Compute::V1::ListPeeringRoutesNetworksRequest]
              #   A request object representing the call parameters. Required.
              # @return [Array(String, [String, nil], Hash{String => String})]
              #   Uri, Body, Query string parameters
              def transcode_list_peering_routes request_pb
                uri = "/compute/v1/projects/#{request_pb.project}/global/networks/#{request_pb.network}/listPeeringRoutes"
                body = nil
                query_string_params = {}
                query_string_params["direction"] = request_pb.direction.to_s if request_pb.direction && request_pb.direction != :UNDEFINED_DIRECTION
                query_string_params["filter"] = request_pb.filter.to_s if request_pb.filter && request_pb.filter != ""
                query_string_params["maxResults"] = request_pb.max_results.to_s if request_pb.max_results && request_pb.max_results != 0
                query_string_params["orderBy"] = request_pb.order_by.to_s if request_pb.order_by && request_pb.order_by != ""
                query_string_params["pageToken"] = request_pb.page_token.to_s if request_pb.page_token && request_pb.page_token != ""
                query_string_params["peeringName"] = request_pb.peering_name.to_s if request_pb.peering_name && request_pb.peering_name != ""
                query_string_params["region"] = request_pb.region.to_s if request_pb.region && request_pb.region != ""
                query_string_params["returnPartialSuccess"] = request_pb.return_partial_success.to_s if request_pb.return_partial_success && request_pb.return_partial_success != false

                [uri, body, query_string_params]
              end
              extend self
            end
          end
        end
      end
    end
  end
end
