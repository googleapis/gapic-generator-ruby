# frozen_string_literal: true

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

require "test_helper"
require "faraday"
require "pp"
#
# Tests for the ThreadedEnumerator.
#
class ThreadedEnumeratorTest < Minitest::Test
  def test_thread_enumerator
    in_q = Queue.new
    out_q = Queue.new

    te = Gapic::Rest::ThreadedEnumerator.new do |in_q, out_q|
      (0..9).each do |i|
        in_q.deq
        out_q.enq i
      end

      out_q.enq nil
    end

    (0..9).each do |i|
      assert_equal i, te.next
    end

    assert_raises(StopIteration) do
      te.next
    end
  end

  def test_errors
    in_q = Queue.new
    out_q = Queue.new

    a = (0..9)

    te = Gapic::Rest::ThreadedEnumerator.new do |in_q, out_q|
      a.each do |i|
        in_q.deq
        out_q.enq i
        if i == 9
            raise RuntimeError.new
        end
      end
      out_q.enq nil
    end

    (0..8).each do |i|
        assert_equal i, te.next
    end


    assert_raises(RuntimeError) do 
        te.next
    end

    assert_raises(StopIteration) do
        x = te.next
        pp x
    end
  end
end
