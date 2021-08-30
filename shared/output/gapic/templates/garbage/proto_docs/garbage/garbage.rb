# frozen_string_literal: true

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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module So
  module Much
    module Trash
      # The get typical garbage request message.
      # @!attribute [rw] name
      #   @return [::String]
      #     The name of the garbage.
      class GetTypicalGarbageRequest
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The top-level message sent by the client for the `LongRunningGarbage`
      # method.
      # @!attribute [rw] garbage
      #   @return [::String]
      #     The name of the garbage this item belongs to.
      class LongRunningGarbageRequest
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The only message returned to the client by the `LongRunningGarbage` method.
      # @!attribute [rw] garbage
      #   @return [::String]
      #     The name of the garbage this item belongs to.
      # @!attribute [rw] items
      #   @return [::Array<::So::Much::Trash::GarbageItem>]
      #     The items of garbage.
      class LongRunningGarbageResponse
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # Describes the progress of a long-running `LongRunningGarbage` call.
      # @!attribute [rw] progress_percent
      #   @return [::Integer]
      #     Approximate percentage of garbage processed thus far. Guaranteed to be 100
      #     when the garbage is fully processed and the items are available.
      # @!attribute [rw] start_time
      #   @return [::Google::Protobuf::Timestamp]
      #     Time when the request was received.
      # @!attribute [rw] last_update_time
      #   @return [::Google::Protobuf::Timestamp]
      #     Time of the most recent processing update.
      class LongRunningGarbageMetadata
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The list garbage request message.
      # @!attribute [rw] garbage
      #   @return [::String]
      #     The name of the garbage this item belongs to.
      class ListGarbageRequest
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The list garbage response message.
      # @!attribute [rw] garbage
      #   @return [::String]
      #     The name of the garbage this item belongs to.
      # @!attribute [rw] items
      #   @return [::Array<::So::Much::Trash::GarbageItem>]
      class ListGarbageResponse
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # A literal piece of garbage. Why would you want this? What is wrong with you?
      # @!attribute [rw] garbage
      #   @return [::String]
      #     The garbage this item belongs to.
      # @!attribute [rw] a
      #   @return [::String]
      #     The string item.
      # @!attribute [rw] b
      #   @return [::Integer]
      #     The integer item.
      class GarbageItem
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # an empty garbage message
      class EmptyGarbage
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # A simple garbage resource
      # @!attribute [rw] name
      #   @return [::String]
      #     The name of this garbage.
      class SimpleGarbage
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # A simple garbage item resource
      # @!attribute [rw] garbage
      #   @return [::String]
      #     The name of the garbage this item belongs to.
      # @!attribute [rw] a
      #   @return [::String]
      # @!attribute [rw] b
      #   @return [::Integer]
      class SimpleGarbageItem
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # @!attribute [rw] name
      #   @return [::String]
      #     The name of this garbage.
      # @!attribute [rw] int32
      #   @return [::Integer]
      #     The int32 of this garbage.
      # @!attribute [rw] int64
      #   @return [::Integer]
      #     The int64 of this garbage.
      # @!attribute [rw] uint32
      #   @return [::Integer]
      #     The uint32 of this garbage.
      # @!attribute [rw] uint64
      #   @return [::Integer]
      #     The uint64 of this garbage.
      # @!attribute [rw] bool
      #   @return [::Boolean]
      #     The bool of this garbage.
      # @!attribute [rw] float
      #   @return [::Float]
      #     The float of this garbage.
      # @!attribute [rw] double
      #   @return [::Float]
      #     The double of this garbage.
      # @!attribute [rw] bytes
      #   @return [::String]
      #     The bytes of this garbage.
      # @!attribute [rw] timeout
      #   @return [::Google::Protobuf::Timestamp]
      #     When the garbage was first activated.
      # @!attribute [rw] duration
      #   @return [::Google::Protobuf::Duration]
      #     Time limit for this garbage. If not defined, the garbage endures forever.
      # @!attribute [r] msg
      #   @return [::So::Much::Trash::GarbageMap]
      #     The map of this garbage.
      # @!attribute [rw] enum
      #   @return [::So::Much::Trash::GarbageEnum]
      #     The type of this garbage.
      # @!attribute [rw] amap
      #   @return [::Google::Protobuf::Map{::String => ::String}]
      #     This is a map.
      # @!attribute [rw] oneof_singular_str
      #   @return [::String]
      #     This is a one-field oneof's string field.
      # @!attribute [rw] oneof_pair_int32
      #   @return [::Integer]
      #     This is a pair oneof's int32 field.
      # @!attribute [rw] oneof_pair_float
      #   @return [::Float]
      #     This is a pair oneof's float field.
      # @!attribute [rw] oneof_multiple_message
      #   @return [::So::Much::Trash::SimpleGarbageItem]
      #     This is a multiple-field oneof's message field.
      # @!attribute [rw] oneof_multiple_bytes
      #   @return [::String]
      #     This is a multiple-field oneof's bytes field.
      # @!attribute [rw] oneof_multiple_enum
      #   @return [::So::Much::Trash::GarbageEnum]
      #     This is a multiple-field oneof's enum field.
      # @!attribute [rw] oneof_multiple_double
      #   @return [::Float]
      #     This is a multiple-field oneof's double field.
      # @!attribute [rw] optional_int32
      #   @return [::Integer]
      class TypicalGarbage
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods

        # @!attribute [rw] key
        #   @return [::String]
        # @!attribute [rw] value
        #   @return [::String]
        class AmapEntry
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end
      end

      # This is one specific garbage, man.
      # @!attribute [rw] name
      #   @return [::String]
      #     The name of this garbage.
      # @!attribute [rw] int32
      #   @return [::Integer]
      #     The int32 of this garbage.
      # @!attribute [rw] int64
      #   @return [::Integer]
      #     The int64 of this garbage.
      # @!attribute [rw] uint32
      #   @return [::Integer]
      #     The uint32 of this garbage.
      # @!attribute [rw] uint64
      #   @return [::Integer]
      #     The uint64 of this garbage.
      # @!attribute [rw] bool
      #   @return [::Boolean]
      #     The bool of this garbage.
      # @!attribute [rw] float
      #   @return [::Float]
      #     The float of this garbage.
      # @!attribute [rw] double
      #   @return [::Float]
      #     The double of this garbage.
      # @!attribute [rw] bytes
      #   @return [::String]
      #     The bytes of this garbage.
      # @!attribute [r] msg
      #   @return [::So::Much::Trash::GarbageMap]
      #     The map of this garbage.
      # @!attribute [rw] enum
      #   @return [::So::Much::Trash::GarbageEnum]
      #     The type of this garbage.
      # @!attribute [rw] nested
      #   @return [::So::Much::Trash::SpecificGarbage::NestedGarbage]
      #     The nested garbage resource of this garbage.
      class SpecificGarbage
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods

        # The best nested garbage money can buy.
        # @!attribute [rw] name
        #   @return [::String]
        #     The name of this garbage.
        # @!attribute [rw] int32
        #   @return [::Integer]
        #     The int32 of this garbage.
        # @!attribute [rw] int64
        #   @return [::Integer]
        #     The int64 of this garbage.
        # @!attribute [rw] uint32
        #   @return [::Integer]
        #     The uint32 of this garbage.
        # @!attribute [rw] uint64
        #   @return [::Integer]
        #     The uint64 of this garbage.
        # @!attribute [rw] bool
        #   @return [::Boolean]
        #     The bool of this garbage.
        # @!attribute [rw] float
        #   @return [::Float]
        #     The float of this garbage.
        # @!attribute [rw] double
        #   @return [::Float]
        #     The double of this garbage.
        # @!attribute [rw] bytes
        #   @return [::String]
        #     The bytes of this garbage.
        # @!attribute [r] msg
        #   @return [::So::Much::Trash::GarbageMap]
        #     The map of this garbage.
        # @!attribute [rw] enum
        #   @return [::So::Much::Trash::GarbageEnum]
        #     The type of this garbage.
        class NestedGarbage
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end
      end

      # @!attribute [rw] repeated_name
      #   @return [::Array<::String>]
      #     The repeated name of this garbage.
      # @!attribute [rw] repeated_int32
      #   @return [::Array<::Integer>]
      #     The repeated int32 of this garbage.
      # @!attribute [rw] repeated_int64
      #   @return [::Array<::Integer>]
      #     The repeated int64 of this garbage.
      # @!attribute [rw] repeated_uint32
      #   @return [::Array<::Integer>]
      #     The repeated uint32 of this garbage.
      # @!attribute [rw] repeated_uint64
      #   @return [::Array<::Integer>]
      #     The repeated uint64 of this garbage.
      # @!attribute [rw] repeated_bool
      #   @return [::Array<::Boolean>]
      #     The repeated bool of this garbage.
      # @!attribute [rw] repeated_float
      #   @return [::Array<::Float>]
      #     The repeated float of this garbage.
      # @!attribute [rw] repeated_double
      #   @return [::Array<::Float>]
      #     The repeated double of this garbage.
      # @!attribute [rw] repeated_bytes
      #   @return [::Array<::String>]
      #     The repeated bytes of this garbage.
      # @!attribute [r] repeated_msg
      #   @return [::Array<::So::Much::Trash::GarbageMap>]
      #     The repeated map of this garbage.
      # @!attribute [rw] repeated_enum
      #   @return [::Array<::So::Much::Trash::GarbageEnum>]
      #     The repeated type of this garbage.
      class RepeatedGarbage
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The request for the GetPagedGarbage method.
      # @!attribute [rw] garbage
      #   @return [::String]
      #     The garbage to page.
      # @!attribute [rw] page_size
      #   @return [::Integer]
      #     The amount of garbage items to returned in each page.
      # @!attribute [rw] page_token
      #   @return [::String]
      #     The position of the page to be returned.
      class PagedGarbageRequest
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The response for the GetPagedGarbage method.
      # @!attribute [rw] items
      #   @return [::Array<::So::Much::Trash::GarbageItem>]
      #     The words that were expanded.
      # @!attribute [rw] next_page_token
      #   @return [::String]
      #     The next page token.
      class PagedGarbageResponse
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The most complex garbage you have ever seen.
      # @!attribute [rw] layer1
      #   @return [::So::Much::Trash::ComplexGarbage::Layer1Garbage]
      #     The first step to total and complete garbage.
      class ComplexGarbage
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods

        # Go deeper and the garbage will overcome you.
        # @!attribute [rw] layer2
        #   @return [::So::Much::Trash::ComplexGarbage::Layer2Garbage]
        #     The second step to total and complete garbage.
        class Layer1Garbage
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # You are too deep, can't turn back now.
        # @!attribute [rw] layer3
        #   @return [::So::Much::Trash::ComplexGarbage::Layer3Garbage]
        #     The third step to total and complete garbage.
        class Layer2Garbage
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # You must really, really love garbage.
        # @!attribute [rw] garbage
        #   @return [::So::Much::Trash::SimpleGarbage]
        #     The final step to total and complete garbage.
        class Layer3Garbage
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end
      end

      # The most recursive garbage ever made. Garbage stacked on garbage stacked on
      # garbage. All the way down.
      # @!attribute [rw] map_string_int32
      #   @return [::Google::Protobuf::Map{::String => ::Integer}]
      # @!attribute [rw] map_string_msg
      #   @return [::Google::Protobuf::Map{::String => ::So::Much::Trash::SimpleGarbage}]
      class GarbageMap
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods

        # @!attribute [rw] key
        #   @return [::String]
        # @!attribute [rw] value
        #   @return [::Integer]
        class MapStringInt32Entry
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # @!attribute [rw] key
        #   @return [::String]
        # @!attribute [rw] value
        #   @return [::So::Much::Trash::SimpleGarbage]
        class MapStringMsgEntry
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end
      end

      # A real recursive data structure.
      # @!attribute [rw] data
      #   @return [::String]
      # @!attribute [rw] parent
      #   @return [::So::Much::Trash::GarbageNode]
      class GarbageNode
        include ::Google::Protobuf::MessageExts
        extend ::Google::Protobuf::MessageExts::ClassMethods
      end

      # The type of garbage you are dealing with.
      #
      # All garbage is not treated equal. Some garbage is better than others.
      # I personally like {::So::Much::Trash::GarbageEnum::GARBAGE_HEAP heaps}.
      module GarbageEnum
        # The typical garbage. It is everywhere.
        DEFAULT_GARBAGE = 0

        # Sometimes it is given to you in a bag.
        GARBAGE_BAG = 1

        # Have you ever turned a corner and seen a heap of garbage in your way?
        GARBAGE_HEAP = 2

        # When this is on fire it resembles politics.
        DUMPSTER = 3
      end
    end
  end
end
