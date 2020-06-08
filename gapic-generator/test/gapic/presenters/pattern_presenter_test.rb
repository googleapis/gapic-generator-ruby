# frozen_string_literal: true

# Copyright 2020 Google LLC
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
require "gapic/presenters/resource_presenter"

class PatternPresenterTest < PresenterTest
  def test_trivial_pattern
    pattern = "hello/world"
    presenter = Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern

    assert_equal [], presenter.arguments
  end

  def test_simple_segment_pattern
    pattern = "hello/{foo}/world/{world}"
    presenter = Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern

    assert presenter.useful_for_helpers?
    assert_equal ["foo", "world"], presenter.arguments
    assert_equal "foo:, world:", presenter.formal_arguments
    assert_equal "foo:world", presenter.arguments_key
    assert_equal "foo: \"value0\", world: \"value1\"", presenter.arguments_with_dummy_values
    assert_equal "hello/value0/world/value1", presenter.expected_path_for_dummy_values
    assert_equal "hello/\#{foo}/world/\#{world}", presenter.path_string
  end

  def test_positional_pattern
    pattern = "hello/*/world/**"
    presenter = Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern

    refute presenter.useful_for_helpers?
    assert_equal [0, 1], presenter.arguments
    assert_equal "0:, 1:", presenter.formal_arguments
    assert_equal "0:1", presenter.arguments_key
    assert_equal "0: \"value0\", 1: \"value1\"", presenter.arguments_with_dummy_values
    assert_equal "hello/value0/world/value1", presenter.expected_path_for_dummy_values
    assert_equal "hello/\#{0}/world/\#{1}", presenter.path_string
  end

  def test_mixed_segment_pattern
    pattern = "hello/{foo}/world/{world_a}~{world_b}"
    presenter = Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern

    assert presenter.useful_for_helpers?
    assert_equal ["foo", "world_a", "world_b"], presenter.arguments
    assert_equal "foo:, world_a:, world_b:", presenter.formal_arguments
    assert_equal "foo:world_a:world_b", presenter.arguments_key
    assert_equal "foo: \"value0\", world_a: \"value1\", world_b: \"value2\"", presenter.arguments_with_dummy_values
    assert_equal "hello/value0/world/value1~value2", presenter.expected_path_for_dummy_values
    assert_equal "hello/\#{foo}/world/\#{world_a}~\#{world_b}", presenter.path_string
  end
end
