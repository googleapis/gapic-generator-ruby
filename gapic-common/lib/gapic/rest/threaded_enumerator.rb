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
    ##
    # A class to provide the Enumerable interface to an incoming stream of data.
    #
    # ThreadedEnumerator provides the enumerations over the individual chunks of data received from the server.
    #
    # @example normal iteration over resources.
    #   chunk = threaded_enumerator.next
    #
    # @attribute [r] in_q
    #   @return [Queue] Input queue.
    # @attribute [r] out_q
    #   @return [Queue] Output queue.
    class ThreadedEnumerator
      attr_reader :in_q
      attr_reader :out_q

      # Spawns a new thread and does appropriate clean-up
      # in case thread fails. Propagates exception back
      # to main thread.
      #
      # @yield None
      # @yieldparam in_q[Queue] input queue
      # @yieldparam out_q[Queue] output queue
      def initialize &block
        @in_q = Queue.new
        @out_q = Queue.new
        @block = block

        t = Thread.new do
          begin
            @block.call @in_q, @out_q
            @in_q.close
            @out_q.close
          rescue Exception => detail
            @out_q.clear
            @in_q.clear
            raise detail
          end
        end
      end

      def next
        @in_q.enq :next
        chunk = @out_q.deq
        raise StopIteration if chunk.nil?
        chunk
      end
    end
  end
end
