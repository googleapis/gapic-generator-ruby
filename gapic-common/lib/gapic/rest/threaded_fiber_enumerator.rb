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
    # Wraps a fiber-block (a block that contains Fiber.yield) of code into
    # a Fiber that is wrapped into it's own thread and presents an iterable
    # interface to it.
    #
    class ThreadedFiberEnumerator
      FIBER_ERROR_SIGNAL = :fiber_error

      # @param fiber Fiber
      def initialize &block
        @input_q = Queue.new
        @output_q = Queue.new
        @fiber_error_received = false

        @t = Thread.new do
          fiber = Fiber.new(&block)
          loop do
            _ = @input_q.pop # ignore
            out = nil

            begin
              out = fiber.resume
            rescue FiberError
              out = FIBER_ERROR_SIGNAL
            ensure
              @output_q << out
            end

            break if out == FIBER_ERROR_SIGNAL
          end
        end
      end

      def next
        begin
          raise StopIteration if @fiber_error_received
          @input_q << :resume
          chunk = @output_q.pop
          if chunk == FIBER_ERROR_SIGNAL
            @fiber_error_received = true
            raise StopIteration
          end
          chunk
        end
      end
    end
  end
end
