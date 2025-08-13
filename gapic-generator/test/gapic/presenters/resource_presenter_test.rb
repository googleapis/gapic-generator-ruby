# frozen_string_literal: true

# Copyright 2025 Google LLC
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

class ResourcePresenterTest < PresenterTest
  def test_noargument_nodedup
    patterns = [ 
      "hello/compatibility/world"
    ].map { |pattern| Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern }
    
    deduped_patterns = Gapic::Presenters::ResourcePresenter.dedup_patterns(patterns).map(&:pattern)

    assert_equal ["hello/compatibility/world"], deduped_patterns
  end

  def test_noargument_dedup
    patterns = [ 
      "hello/world",
      "hello/zorld",
      "hello/compatibility/world"
    ].map { |pattern| Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern }
    
    deduped_patterns = Gapic::Presenters::ResourcePresenter.dedup_patterns(patterns).map(&:pattern)

    assert_equal ["hello/world"], deduped_patterns
  end

  def test_noargument_dedup_with_additional
    patterns = [ 
      "hello/world",
      "hello/compatibility/world",
      "hello/{foo}/world/{world}"
    ].map { |pattern| Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern }
    
    deduped_patterns = Gapic::Presenters::ResourcePresenter.dedup_patterns(patterns).map(&:pattern)

    assert_equal ["hello/world", "hello/{foo}/world/{world}"], deduped_patterns
  end

  def test_argument_nodedup
    patterns = [ 
      "hello/{foo}/world/{world}"
    ].map { |pattern| Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern }
    
    deduped_patterns = Gapic::Presenters::ResourcePresenter.dedup_patterns(patterns).map(&:pattern)

    assert_equal ["hello/{foo}/world/{world}"], deduped_patterns
  end

  def test_argument_dedup
    patterns = [ 
      "hello/{foo}/world/{world}",
      "hello/{foo}/compatibility/world/{world}",
      "hello/{foo}/zorld/{world}"
    ].map { |pattern| Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern }
    
    deduped_patterns = Gapic::Presenters::ResourcePresenter.dedup_patterns(patterns).map(&:pattern)

    assert_equal ["hello/{foo}/world/{world}"], deduped_patterns
  end

  def test_argument_dedup_with_additional
    patterns = [ 
      "hello/{foo}/world/{world}",
      "hello/{foo}/compatibility/world/{world}",
      "baz/{baz}"
    ].map { |pattern| Gapic::Presenters::ResourcePresenter::PatternPresenter.new pattern }
    
    deduped_patterns = Gapic::Presenters::ResourcePresenter.dedup_patterns(patterns).map(&:pattern)

    assert_equal ["hello/{foo}/world/{world}",  "baz/{baz}"], deduped_patterns
  end
end
