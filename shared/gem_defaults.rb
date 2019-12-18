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


def gem_defaults
  {
    language_v1: {
      protos: [
        "google/cloud/language/v1/language_service.proto"
      ],
      samples: Dir.glob([
        "../shared/googleapis/google/cloud/language/v1/samples/*.yaml",
        "../shared/googleapis/google/cloud/language/v1/samples/test/*.yaml",
        "../shared/samples/language/*.yaml"
      ])
    },
    language_v1beta1: {
      protos: [
        "google/cloud/language/v1beta1/language_service.proto"
      ]
    },
    language_v1beta2: {
      protos: [
        "google/cloud/language/v1beta2/language_service.proto"
      ]
    },
    secretmanager_v1beta1: {
      protos: [
        "google/cloud/secrets/v1beta1/resources.proto",
        "google/cloud/secrets/v1beta1/service.proto"
      ]
    },
    speech_v1: {
      protos: [
        "google/cloud/speech/v1/cloud_speech.proto"
      ],
      samples: Dir.glob([
        "../shared/googleapis/google/cloud/speech/v1/samples/*.yaml",
        "../shared/googleapis/google/cloud/speech/v1/samples/test/*.yaml",
        "../shared/samples/speech/*.yaml"
      ])
    },
    vision_v1: {
      protos: [
        "google/cloud/vision/v1/geometry.proto",
        "google/cloud/vision/v1/image_annotator.proto",
        "google/cloud/vision/v1/product_search.proto",
        "google/cloud/vision/v1/product_search_service.proto",
        "google/cloud/vision/v1/text_annotation.proto",
        "google/cloud/vision/v1/web_detection.proto"
      ]
    },
    showcase: {
      protos: [
        "google/showcase/v1beta1/echo.proto",
        "google/showcase/v1beta1/identity.proto",
        "google/showcase/v1beta1/messaging.proto",
        "google/showcase/v1beta1/testing.proto"
      ]
    },
    garbage: {
      protos: [
        "garbage/garbage.proto"
      ],
      samples: Dir.glob([
        "../shared/samples/garbage/*.yaml",
        "../shared/samples/garbage/test/*.yaml",
        "../shared/samples/garbage/inline/*.yaml"
      ])
    },
    googleads: {
      protos: [
        "google/ads/googleads/v1/services/campaign_service.proto"
      ]
    }
  }
end

def protos_for service
  gem_defaults[service][:protos]
end

def samples_for service
  gem_defaults[service][:samples]
end
