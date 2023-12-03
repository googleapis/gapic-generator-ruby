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

require "stringio"

module Gapic
  module Schema
    ##
    # @private
    #
    # A set of logic dealing with parsing raw proto data. This is unfortunately
    # necessary for getting options extension information from proto
    # descriptors, because the google-protobuf library implementation is
    # incomplete. (Specifically, it does not expose Ruby interfaces for Service
    # and Method descriptors, the objects that normally surface extended
    # options; see https://github.com/protocolbuffers/protobuf/issues/14891.)
    #
    # We hope this code will be temporary until the above protobuf features are
    # available. In the meantime, we make it private.
    #
    module ProtoTools
      class << self
        ##
        # Parse through an options object looking for specific fields.
        #
        # The fields should be provided as a hash mapping the option name to
        # an array of the form `[id, type, flags...]` where the ID is the field
        # number, the type is the protobuf message class or one of the symbols
        # `:string`, `:bool`, `:enum`, and currently the only flag supported is
        # `:repeated`.
        #
        # Returns a hash mapping option names found to their values. Repeated
        # values are represented as arrays (not as protobuf repeated values).
        #
        def parse_options_extensions options, extension_config
          return {} unless options
          return options.dup.delete_if { |k, _v| !extension_config.key? k } if options.is_a? Hash
          bytes = options.class.encode options
          return {} if bytes.empty?
          option_data_by_id = build_option_data_by_id extension_config
          results = build_default_results extension_config
          walk_bytes bytes do |id, _wire_type, data|
            option_data = option_data_by_id[id]
            next unless option_data
            name = option_data[0]
            type = option_data[1]
            results[name] =
              if option_data[2].include? :repeated
                decode_repeated data, type, results[name]
              else
                decode_data data, type
              end
          end
          results
        end

        ##
        # Given a byte string of data, parse through it and yield each record
        # as the field number, wire type number, and data. The data is either
        # an integer (for VARINT) or byte array (for LEN). I64 and I32 records
        # are skipped.
        #
        def walk_bytes bytes
          io = StringIO.new bytes
          until io.eof?
            tag = read_varint io
            id = tag >> 3
            wire_type = tag & 7
            case wire_type
            when 0 # VARINT
              data = read_varint io
              yield id, wire_type, data
            when 1 # I64
              # Skip
              io.read 8
            when 2 # LEN
              len = read_varint io
              data = io.read len
              yield id, wire_type, data
            when 5 # I32
              # Skip
              io.read 4
            else
              raise "Wire type #{wire_type} not supported (id = #{id})"
            end
          end
        end

        ##
        # Read and return a single VARINT from the byte stream
        #
        def read_varint io
          acc = 0
          shift = 0
          loop do
            byte = io.getbyte
            acc += ((byte & 0x7f) << shift)
            shift += 7
            break if byte < 0x80
          end
          acc
        end

        ##
        # Given a data and type, return a decoded form of the data.
        # If the type is `:string`, the data must be a bytestring and is
        # returned as is. If the type is `:enum`, the data must be an integer
        # and is returned as is. If the type is `:bool`, the data must be an
        # integer and is converted to a boolean. If the type is a protobuf
        # message class, the data must be a bytestring and is decoded. Any
        # other type is not supported and results in an exception.
        #
        def decode_data data, type
          case type
          when :string, :enum
            data
          when :bool
            !data.zero?
          when ::Class
            type.decode data
          else
            raise "Type #{type} not supported"
          end
        end

        ##
        # Given a data and a repeated type, return a decoded form of the data
        # as an array.  Supports repeated `:string`, `:enum`, and protobuf
        # message class types. Any other type results in an exception.
        #
        def decode_repeated data, type, acc = nil
          acc ||= []
          case type
          when :string
            acc << data
          when :enum
            if data.is_a? ::String
              io = StringIO.new data
              acc << read_varint(io) until io.eof?
            else
              acc << data
            end
          when ::Class
            acc << type.decode(data)
          else
            raise "Type #{type} not supported"
          end
          acc
        end

        private

        # @private
        # Internal method to build a hash of default results
        def build_default_results extension_config
          extension_config.to_h do |name, config|
            default =
              if config[2..].include? :repeated
                []
              else
                case config[1]
                when :enum
                  0
                when :string
                  ""
                end
              end
            [name, default]
          end
        end

        # @private
        # Internal method to build a hash keyed by id
        def build_option_data_by_id extension_config
          extension_config.to_h { |name, config| [config[0], [name, config[1], config[2..]]] }
        end
      end
    end
  end
end
