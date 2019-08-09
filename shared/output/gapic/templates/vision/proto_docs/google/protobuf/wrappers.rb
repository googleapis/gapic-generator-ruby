# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Google
  module Protobuf
    # Wrapper message for `double`.
    #
    # The JSON representation for `DoubleValue` is JSON number.
    # @!attribute [rw] value
    #   @return [Float]
    #     The double value.
    class DoubleValue
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `float`.
    #
    # The JSON representation for `FloatValue` is JSON number.
    # @!attribute [rw] value
    #   @return [Float]
    #     The float value.
    class FloatValue
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `int64`.
    #
    # The JSON representation for `Int64Value` is JSON string.
    # @!attribute [rw] value
    #   @return [Integer]
    #     The int64 value.
    class Int64Value
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `uint64`.
    #
    # The JSON representation for `UInt64Value` is JSON string.
    # @!attribute [rw] value
    #   @return [Integer]
    #     The uint64 value.
    class UInt64Value
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `int32`.
    #
    # The JSON representation for `Int32Value` is JSON number.
    # @!attribute [rw] value
    #   @return [Integer]
    #     The int32 value.
    class Int32Value
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `uint32`.
    #
    # The JSON representation for `UInt32Value` is JSON number.
    # @!attribute [rw] value
    #   @return [Integer]
    #     The uint32 value.
    class UInt32Value
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `bool`.
    #
    # The JSON representation for `BoolValue` is JSON `true` and `false`.
    # @!attribute [rw] value
    #   @return [Boolean]
    #     The bool value.
    class BoolValue
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `string`.
    #
    # The JSON representation for `StringValue` is JSON string.
    # @!attribute [rw] value
    #   @return [String]
    #     The string value.
    class StringValue
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Wrapper message for `bytes`.
    #
    # The JSON representation for `BytesValue` is JSON string.
    # @!attribute [rw] value
    #   @return [String]
    #     The bytes value.
    class BytesValue
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
