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

require "test_helper"
require "gapic/lru_hash"

##
# Tests LRU hash class
#
class LruHashTest < Minitest::Test
  def test_hash_size_exceed
    lru_cache = Gapic::LruHash.new 3
    lru_cache.put 1, "one"
    lru_cache.put 2, "two"
    lru_cache.put 3, "three"
    lru_cache.put 4, "four"
    assert lru_cache.get(1).nil?
    assert_equal "four", lru_cache.get(4)
  end

  def test_hash_size_value
    assert_raises ArgumentError do
      Gapic::LruHash.new 0
    end
    assert_raises ArgumentError do
      Gapic::LruHash.new(-1)
    end
  end

  def test_hash_removes_lru_value
    lru_cache = Gapic::LruHash.new 3
    lru_cache.put 1, "one"
    lru_cache.put 2, "two"
    lru_cache.put 3, "three"
    lru_cache.get 3
    lru_cache.get 2
    lru_cache.get 1

    lru_cache.put 4, "four"
    assert lru_cache.get(3).nil?
    assert_equal "four", lru_cache.get(4)
  end
end
