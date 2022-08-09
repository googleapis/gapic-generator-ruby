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

class ThreadedFiberEnumeratorTest < Minitest::Test
  # Test for the ThreadedFiberEnumerator where it's
  # created and read from the same thread
  def test_threaded_fiber_enum_in_thread
    iterator = Gapic::Rest::ThreadedFiberEnumerator.new do 
      10.times do |ix|
        Fiber.yield ix
      end
      nil
    end

    stop_iteration_triggered = false
    vals = []
    loop do
      val = iterator.next
      vals << val
    rescue StopIteration
      stop_iteration_triggered = true
      break
    end
    assert stop_iteration_triggered
    assert_equal (0..9).to_a + [nil], vals
  end

  # Test for the ThreadedFiberEnumerator where it's
  # created from one thread and read from another
  def test_threaded_fiber_enum_separate_thread
    iterator = Gapic::Rest::ThreadedFiberEnumerator.new do 
      10.times do |ix|
        Fiber.yield ix
      end
      nil
    end

    queue = Queue.new
    thread = Thread.new do
      loop do
        val = iterator.next
        queue << val
      rescue StopIteration
        queue << :stop_iteration_triggered
        break
      end
    end
    assert thread.alive?

    stop_iteration_triggered = false
    vals = []
    loop do
      val = queue.pop
      if val == :stop_iteration_triggered
        stop_iteration_triggered = true
        break
      end
      vals << val
    end

    assert stop_iteration_triggered
    assert_equal (0..9).to_a + [nil], vals
    refute thread.alive?
  end

  # Test for the ThreadedFiberEnumerator where it's
  # read from multiple threads in a round-robin fashion
  def test_threaded_fiber_enum_multiple_threads_rr
    def start_thread name, t2q, queue_out, iterator
      queue_in = t2q[name]
      Thread.new do
        vals = []
        loop do
          _ = queue_in.pop
          vals << iterator.next
          queue_out << [name, :ongoing]
        rescue StopIteration
          queue_out << [name, vals]
          break
        end
      end
    end

    iterator = Gapic::Rest::ThreadedFiberEnumerator.new do 
      10.times do |ix|
        Fiber.yield ix
      end
      nil
    end

    t2q = {
      thread1: Queue.new,
      thread2: Queue.new,
      thread3: Queue.new
    }
    queue_out = Queue.new

    threads = {}
    threads[:thread1] = start_thread(:thread1, t2q, queue_out, iterator)
    threads[:thread2] = start_thread(:thread2, t2q, queue_out, iterator)
    threads[:thread3] = start_thread(:thread3, t2q, queue_out, iterator)
    active_threads = threads.keys.to_a
    
    [:thread1, :thread2, :thread3].each do |name|
      assert threads[name].alive?
    end

    vals = {}
    loop do
      next_thread = active_threads.shift
      break unless next_thread
      next_queue = t2q[next_thread]
      next_queue << :go

      name, result = queue_out.pop
      assert_equal next_thread, name

      if result == :ongoing
        active_threads << name
      else
        vals[name] = result
      end
    end

    assert_equal [0,3,6,9], vals[:thread1]
    assert_equal [1,4,7,nil], vals[:thread2]
    assert_equal [2,5,8], vals[:thread3]

    [:thread1, :thread2, :thread3].each do |name|
      refute threads[name].alive?
    end
  end

  # Test for the ThreadedFiberEnumerator where it's
  # read from multiple threads in a free for all fashion
  def test_threaded_fiber_enum_multiple_threads_ffa
    def start_thread queue_out, iterator
      Thread.new do
        rnd = Random.new
        vals = []

        loop do
          vals << iterator.next
          sleep rnd.rand(0.2)
        rescue StopIteration
          queue_out << [vals]
          break
        end
      end
    end

    iterator = Gapic::Rest::ThreadedFiberEnumerator.new do 
      10.times do |ix|
        Fiber.yield ix
      end
      nil
    end
    queue_out = Queue.new

    threads = []
    3.times do 
      threads << start_thread(queue_out, iterator)
    end

    vals = []
    3.times do
      vals << queue_out.pop
    end

    vals = vals.flatten
    assert vals.include? nil
    vals = vals.compact.sort

    assert_equal (0..9).to_a, vals
    threads.each do |thread|
      refute thread.alive?
    end
  end
end
