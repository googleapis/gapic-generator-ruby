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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

# [START grafeas_v1_generated_Grafeas_ListNoteOccurrences_sync]
require "grafeas/v1"

##
# Snippet for the list_note_occurrences call in the Grafeas service
#
# This snippet has been automatically generated and should be regarded as a code
# template only. It will require modifications to work:
# - It may require correct/in-range values for request initialization.
# - It may require specifying regional endpoints when creating the service
# client as shown in https://cloud.google.com/ruby/docs/reference.
#
# This is an auto-generated example demonstrating basic usage of
# Grafeas::V1::Grafeas::Client#list_note_occurrences.
#
def list_note_occurrences
  # Create a client object. The client can be reused for multiple calls.
  client = Grafeas::V1::Grafeas::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = Grafeas::V1::ListNoteOccurrencesRequest.new

  # Call the list_note_occurrences method.
  result = client.list_note_occurrences request

  # The returned object is of type Gapic::PagedEnumerable. You can iterate
  # over elements, and API calls will be issued to fetch pages as needed.
  result.each do |item|
    # Each element is of type ::Grafeas::V1::Occurrence.
    p item
  end
end
# [END grafeas_v1_generated_Grafeas_ListNoteOccurrences_sync]
