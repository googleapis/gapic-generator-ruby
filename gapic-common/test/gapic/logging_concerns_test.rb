# Copyright 2024 Google LLC
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

require "gapic/logging_concerns"

describe Gapic::LoggingConcerns do
  describe "random_uuid4" do
    it "outputs the correct format" do
      output = Gapic::LoggingConcerns.random_uuid4
      assert_match(/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/, output)
    end

    it "doesn't repeat" do
      output1 = Gapic::LoggingConcerns.random_uuid4
      output2 = Gapic::LoggingConcerns.random_uuid4
      refute_equal output1, output2
    end
  end
end
