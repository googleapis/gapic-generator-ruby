# frozen_string_literal: true

# Copyright 2019 Google LLC
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

require "active_support/inflector"

class SamplePresenter
  def initialize api, sample_config
    @api = api
    @sample_config = sample_config
  end

  def description
    @sample_config["description"]
  end

  def input_parameters
    @sample_config["request"].select { |f| f.has_key? "input_parameter" }.map { |f| RequestField.new f }
  end

  def response_variable
    @sample_config["response"][0]["loop"]["variable"]
  end

  class RequestField
    attr_reader :field, :value, :input_parameter, :comment
    def initialize field
      @field = field["field"]
      @value = convert field["value"]
      @input_parameter = field["input_parameter"]
      @comment = field["comment"]
    end

    def convert val
      if val.is_a? String
        return ":#{val}" if val.match /\A[A-Z_]+/ # print constants as symbols
        "\"#{val}\""
      else
        val
      end
    end
  end
end
