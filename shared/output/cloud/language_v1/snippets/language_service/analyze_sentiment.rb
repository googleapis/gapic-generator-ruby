# frozen_string_literal: true

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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

# [START language_v1_generated_LanguageService_AnalyzeSentiment_sync]
require "google/cloud/language/v1"

##
# Example demonstrating basic usage of
# Google::Cloud::Language::V1::LanguageService::Client#analyze_sentiment
#
def analyze_sentiment
  # Create a client object. The client can be reused for multiple calls.
  client = Google::Cloud::Language::V1::LanguageService::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = Google::Cloud::Language::V1::AnalyzeSentimentRequest.new

  # Call the analyze_sentiment method.
  result = client.analyze_sentiment request

  # The returned object is of type Google::Cloud::Language::V1::AnalyzeSentimentResponse.
  p result
end
# [END language_v1_generated_LanguageService_AnalyzeSentiment_sync]
