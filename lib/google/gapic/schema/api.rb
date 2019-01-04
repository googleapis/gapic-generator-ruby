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

require "google/gapic/schema/loader"

module Google
  module Gapic
    module Schema
      # A representation of a full API.
      #
      # @!attribute [r] files
      #   @return [Array<File>] The files represented by this API.
      # @!attribute [r] services
      #   @return [<Array<Service>] The services seen across all files in this
      #     API.
      # @!attribute [r] messages
      #   @return [Array<Message>] The top level messages seen across all files
      #     in this API.
      # @!attribute [r] enums
      #   @return [Array<Enum>] The top level enums seen across all files in
      #     this API.
      class Api
        attr_accessor :files, :services, :messages, :enums

        # Initializes an API object with the file descriptors that represent the
        # API.
        #
        # @param file_descriptors [Array<Google::Protobuf::FileDescriptorProto>]
        #   The descriptors of the files this API represents.
        # @param files_to_generate [Array<String>] The .proto files that
        #   should be generated.
        def initialize file_descriptors, files_to_generate
          loader = Loader.new
          @files = file_descriptors.map do |fd|
            loader.load_file fd, files_to_generate.include?(fd.name)
          end
          @services = @files.flat_map(&:services)
          @messages = @files.flat_map(&:messages)
          @enums = @files.flat_map(&:enums)
        end
      end
    end
  end
end
