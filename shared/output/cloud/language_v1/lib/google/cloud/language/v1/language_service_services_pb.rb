# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/language/v1/language_service.proto for package 'google.cloud.language.v1'
# Original file comments:
# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'grpc'
require 'google/cloud/language/v1/language_service_pb'

module Google
  module Cloud
    module Language
      module V1
        module LanguageService
          # Provides text analysis operations such as sentiment analysis and entity
          # recognition.
          class Service

            include ::GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.language.v1.LanguageService'

            # Analyzes the sentiment of the provided text.
            rpc :AnalyzeSentiment, ::Google::Cloud::Language::V1::AnalyzeSentimentRequest, ::Google::Cloud::Language::V1::AnalyzeSentimentResponse
            # Finds named entities (currently proper names and common nouns) in the text
            # along with entity types, salience, mentions for each entity, and
            # other properties.
            rpc :AnalyzeEntities, ::Google::Cloud::Language::V1::AnalyzeEntitiesRequest, ::Google::Cloud::Language::V1::AnalyzeEntitiesResponse
            # Finds entities, similar to
            # [AnalyzeEntities][google.cloud.language.v1.LanguageService.AnalyzeEntities]
            # in the text and analyzes sentiment associated with each entity and its
            # mentions.
            rpc :AnalyzeEntitySentiment, ::Google::Cloud::Language::V1::AnalyzeEntitySentimentRequest, ::Google::Cloud::Language::V1::AnalyzeEntitySentimentResponse
            # Analyzes the syntax of the text and provides sentence boundaries and
            # tokenization along with part of speech tags, dependency trees, and other
            # properties.
            rpc :AnalyzeSyntax, ::Google::Cloud::Language::V1::AnalyzeSyntaxRequest, ::Google::Cloud::Language::V1::AnalyzeSyntaxResponse
            # Classifies a document into categories.
            rpc :ClassifyText, ::Google::Cloud::Language::V1::ClassifyTextRequest, ::Google::Cloud::Language::V1::ClassifyTextResponse
            # Moderates a document for harmful and sensitive categories.
            rpc :ModerateText, ::Google::Cloud::Language::V1::ModerateTextRequest, ::Google::Cloud::Language::V1::ModerateTextResponse
            # A convenience method that provides all the features that analyzeSentiment,
            # analyzeEntities, and analyzeSyntax provide in one call.
            rpc :AnnotateText, ::Google::Cloud::Language::V1::AnnotateTextRequest, ::Google::Cloud::Language::V1::AnnotateTextResponse
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
