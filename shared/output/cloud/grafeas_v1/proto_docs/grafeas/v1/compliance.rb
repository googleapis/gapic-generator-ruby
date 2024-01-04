# frozen_string_literal: true

# Copyright 2024 Google LLC
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
    # @!attribute [rw] title
    #   @return [::String]
    #     The title that identifies this compliance check.
    # @!attribute [rw] description
    #   @return [::String]
    #     A description about this compliance check.
    # @!attribute [rw] version
    #   @return [::Array<::Grafeas::V1::ComplianceVersion>]
    #     The OS and config versions the benchmark applies to.
    # @!attribute [rw] rationale
    #   @return [::String]
    #     A rationale for the existence of this compliance check.
    # @!attribute [rw] remediation
    #   @return [::String]
    #     A description of remediation steps if the compliance check fails.
    # @!attribute [rw] cis_benchmark
    #   @return [::Grafeas::V1::ComplianceNote::CisBenchmark]
    # @!attribute [rw] scan_instructions
    #   @return [::String]
    #     Serialized scan instructions with a predefined format.
    class ComplianceNote
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods

      # A compliance check that is a CIS benchmark.
      # @!attribute [rw] profile_level
      #   @return [::Integer]
      # @!attribute [rw] severity
      #   @return [::Grafeas::V1::Severity]
      class CisBenchmark
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Describes the CIS benchmark version that is applicable to a given OS and
    # os version.
    # @!attribute [rw] cpe_uri
    #   @return [::String]
    #     The CPE URI (https://cpe.mitre.org/specification/) this benchmark is
    #     applicable to.
    # @!attribute [rw] benchmark_document
    #   @return [::String]
    #     The name of the document that defines this benchmark, e.g. "CIS
    #     Container-Optimized OS".
    # @!attribute [rw] version
    #   @return [::String]
    #     The version of the benchmark. This is set to the version of the OS-specific
    #     CIS document the benchmark is defined in.
    class ComplianceVersion
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods
    end

    # An indication that the compliance checks in the associated ComplianceNote
    # were not satisfied for particular resources or a specified reason.
    # @!attribute [rw] non_compliant_files
    #   @return [::Array<::Grafeas::V1::NonCompliantFile>]
    # @!attribute [rw] non_compliance_reason
    #   @return [::String]
    class ComplianceOccurrence
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods
    end

    # Details about files that caused a compliance check to fail.
    # @!attribute [rw] path
    #   @return [::String]
    #     Empty if `display_command` is set.
    # @!attribute [rw] display_command
    #   @return [::String]
    #     Command to display the non-compliant files.
    # @!attribute [rw] reason
    #   @return [::String]
    #     Explains why a file is non compliant for a CIS check.
    class NonCompliantFile
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
