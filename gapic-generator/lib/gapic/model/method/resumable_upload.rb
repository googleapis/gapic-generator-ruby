# frozen_string_literal: true

# Copyright 2026 Google LLC
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

require "gapic/model/model_error"

module Gapic
  module Model
    module Method
      ##
      # Resumable upload method-level model.
      #
      # A resumable upload RPC does not send its payload in the initiation request. The request it
      # describes only creates an upload session; the bytes travel afterwards, over REST, in chunks
      # addressed to a URL the server hands back. Generated clients therefore return an upload handle
      # from such a method rather than a response message.
      #
      # Until the upload annotation is published, the set of such RPCs is carried here as a table, and
      # so is the URL prefix each one's initiation request is sent under. When the annotation lands,
      # {.url_prefix_for} keeps the table and detection moves to `http.media_upload.enabled`.
      #
      # @!attribute [r] url_prefix
      #   @return [String] The path prefix prepended to the transcoded initiation URL, without
      #     surrounding slashes, e.g. `resumable/upload`.
      #
      class ResumableUpload
        # @return [String]
        attr_reader :url_prefix

        ##
        # @param url_prefix [String] The upload URL prefix for the matched RPC.
        #
        def initialize url_prefix
          @url_prefix = url_prefix
        end

        ##
        # Exact matches, keyed by the full gRPC name of the RPC.
        #
        EXACT_PREFIXES = {
          "google.showcase.v1beta1.ResumableUploadService.UploadMedia" => "resumable/upload"
        }.freeze

        ##
        # Version-family matches, for protos that are republished under a new version regularly.
        # Anchored on the left at the package and on the right at the service and method, with the
        # intervening segments (e.g. `.services.`) unconstrained.
        #
        VERSIONED_PREFIXES = [
          {
            left:   /\Agoogle\.ads\.googleads\.v[0-9_]+\./,
            right:  ".YouTubeVideoUploadService.CreateYouTubeVideoUpload",
            prefix: "resumable/upload"
          }
        ].freeze

        class << self
          ##
          # Inspects a method and returns its resumable upload model, or `nil` if it does not perform
          # resumable uploads.
          #
          # @param method [Gapic::Presenters::MethodPresenter]
          #
          # @raise [Gapic::Model::ModelError] if the method is a resumable upload RPC that the
          #   generator cannot generate an upload surface for.
          #
          # @return [Gapic::Model::Method::ResumableUpload, nil]
          #
          def create method
            prefix = url_prefix_for method.grpc_full_name
            return nil if prefix.nil?
            validate! method
            new prefix
          end

          ##
          # The upload URL prefix for an RPC, or `nil` if the RPC does not perform resumable uploads.
          #
          # @param full_name [String] The full gRPC name of the RPC,
          #   e.g. `google.showcase.v1beta1.ResumableUploadService.UploadMedia`.
          #
          # @return [String, nil]
          #
          def url_prefix_for full_name
            EXACT_PREFIXES[full_name] ||
              VERSIONED_PREFIXES.find do |match|
                match[:left].match?(full_name) && full_name.end_with?(match[:right])
              end&.fetch(:prefix)
          end

          ##
          # Verifies that an upload surface can be generated for the given method. A resumable upload
          # is a single unary POST that carries a body, and anything else in the table is a
          # misconfiguration that must fail the build rather than generate code that cannot work.
          #
          # @param method [Gapic::Presenters::MethodPresenter]
          #
          # @raise [Gapic::Model::ModelError]
          #
          # @return [void]
          #
          def validate! method
            reason = unsupported_reason method
            return if reason.nil?
            raise ModelError, "The method #{method.grpc_full_name} performs resumable uploads, " \
                              "which the generator supports only for #{reason}."
          end

          private

          ##
          # @param method [Gapic::Presenters::MethodPresenter]
          # @return [String, nil] What the method would have had to be, or `nil` if it is supported.
          #
          def unsupported_reason method
            return "non-streaming methods" if method.client_streaming? || method.server_streaming?
            return "non-paginated methods" if method.paged?
            return "methods that are not long-running operations" if method.lro? || method.nonstandard_lro?

            binding = method.http_bindings.first
            return "methods with an HTTP binding" if binding.nil?
            return "methods bound to POST" unless binding.verb == :post
            return "methods whose HTTP binding has a body" unless binding.body?

            nil
          end
        end
      end
    end
  end
end
