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

require 'google/gapic/schema/loader'

module Google
  module Gapic
    module Schema
      # A representation of a full API.
      #
      # @!attribute [r] files
      #   @ return [Enumerable<File>] The files represented by this API.
      # @!attribute [r] services
      #   @ return [Hash<Enumerable<String>, Service>] A mapping of an address to
      #      the services seen across all files in this API.
      # @!attribute [r] messages
      #   @ return [Hash<Enumerable<String>, Message>] A mapping of an address to
      #      the messages seen across all files in this API.
      # @!attribute [r] enums
      #   @ return [Hash<Enumerable<String>, Enum>] A mapping of an address to
      #      the enums seen across all files in this API.
      class Api
        attr_accessor :files, :services, :messages, :enums

        # Initializes an API object with the file descriptors that represent the
        # API.
        #
        # @param file_descriptors [Enumerable<Google::Protobuf::FileDescriptorProto>]
        #   The descriptors of the files this API represents.
        def initialize file_descriptors, package
          loader = Loader.new(package)
          @files = file_descriptors.map { |fd| loader.load_file(fd) }
          @services = @files.flat_map { |f| f.services }
          @messages = @files.flat_map { |f| f.messages }
          @enums = @files.flat_map { |f| f.enums }
        end
      end
    end
  end
end
