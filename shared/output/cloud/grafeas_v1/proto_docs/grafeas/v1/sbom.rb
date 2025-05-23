# frozen_string_literal: true

# Copyright 2025 Google LLC
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


module Grafeas
  module V1
    # The note representing an SBOM reference.
    # @!attribute [rw] format
    #   @return [::String]
    #     The format that SBOM takes. E.g. may be spdx, cyclonedx, etc...
    # @!attribute [rw] version
    #   @return [::String]
    #     The version of the format that the SBOM takes. E.g. if the format
    #     is spdx, the version may be 2.3.
    class SBOMReferenceNote
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods
    end

    # The occurrence representing an SBOM reference as applied to a specific
    # resource. The occurrence follows the DSSE specification. See
    # https://github.com/secure-systems-lab/dsse/blob/master/envelope.md for more
    # details.
    # @!attribute [rw] payload
    #   @return [::Grafeas::V1::SbomReferenceIntotoPayload]
    #     The actual payload that contains the SBOM reference data.
    # @!attribute [rw] payload_type
    #   @return [::String]
    #     The kind of payload that SbomReferenceIntotoPayload takes. Since it's in
    #     the intoto format, this value is expected to be
    #     'application/vnd.in-toto+json'.
    # @!attribute [rw] signatures
    #   @return [::Array<::Grafeas::V1::EnvelopeSignature>]
    #     The signatures over the payload.
    class SBOMReferenceOccurrence
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods
    end

    # The actual payload that contains the SBOM Reference data.
    # The payload follows the intoto statement specification. See
    # https://github.com/in-toto/attestation/blob/main/spec/v1.0/statement.md
    # for more details.
    # @!attribute [rw] type
    #   @return [::String]
    #     Identifier for the schema of the Statement.
    # @!attribute [rw] predicate_type
    #   @return [::String]
    #     URI identifying the type of the Predicate.
    # @!attribute [rw] subject
    #   @return [::Array<::Grafeas::V1::Subject>]
    #     Set of software artifacts that the attestation applies to. Each element
    #     represents a single software artifact.
    # @!attribute [rw] predicate
    #   @return [::Grafeas::V1::SbomReferenceIntotoPredicate]
    #     Additional parameters of the Predicate. Includes the actual data about the
    #     SBOM.
    class SbomReferenceIntotoPayload
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods
    end

    # A predicate which describes the SBOM being referenced.
    # @!attribute [rw] referrer_id
    #   @return [::String]
    #     The person or system referring this predicate to the consumer.
    # @!attribute [rw] location
    #   @return [::String]
    #     The location of the SBOM.
    # @!attribute [rw] mime_type
    #   @return [::String]
    #     The mime type of the SBOM.
    # @!attribute [rw] digest
    #   @return [::Google::Protobuf::Map{::String => ::String}]
    #     A map of algorithm to digest of the contents of the SBOM.
    class SbomReferenceIntotoPredicate
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods

      # @!attribute [rw] key
      #   @return [::String]
      # @!attribute [rw] value
      #   @return [::String]
      class DigestEntry
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end
    end
  end
end
