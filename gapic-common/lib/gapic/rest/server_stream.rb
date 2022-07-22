# Copyright 2022 Google LLC
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

module Gapic
  module Rest
    class ServerStream
      include Enumerable

      # @return Enumerable<String>
      attr_reader :bodies

      # @return Enumerable<String>
      attr_reader :enumberable

      # @param fiber Enumerable<String>
      def initialize enumerable
        @enumerable = enumerable
        @_level = 0
        @_obj = ""
        @ready_objs = []
      end

      def next_json!(chunk)
        for char in chunk.split("")
          if char == "{"
            if @_level == 1
              @_obj = ""
            end
            if not @_in_string
              @_level += 1
            end
            @_obj += char
          elsif char == "}"
            @_obj += char
            if not @_in_string
              @_level -= 1
            end
            if not @_in_string and @_level == 1
              @ready_objs.append(@_obj)
            end
          elsif char == '"'
            @_in_string = !@_in_string
            @_obj += char
          elsif char == "["
            if @_level == 0
              @_level += 1
            else
              @_obj += char
            end
          elsif char == "]"
            if @_level == 1
              @_level -= 1
            else
              @_obj += char
            end
          else
            @_obj += char
          end
        end
      end

      #
      # Iterate over JSON objects in the streamed response.
      # TODO: Conver to Protobuf.
      #
      # @yield [String] Gives JSON string for one complete object.
      #
      # @return [Enumerator] if no block is provided
      #
      # ?return nil when done.
      def each &block
        return enum_for :each unless block_given?
        loop do
          while @ready_objs.length == 0
            begin
              chunk = @enumerable.next
              next_json!(chunk)
            rescue StopIteration
              return  
            end
          end
          yield @ready_objs.shift
        end
      end
    end
  end
end
