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
    my_plugin: {
      generator: :gem_builder
    },
    grafeas_v1: {
      protos: [
        "grafeas/v1/attestation.proto",
        "grafeas/v1/build.proto",
        "grafeas/v1/common.proto",
        "grafeas/v1/compliance.proto",
        "grafeas/v1/cvss.proto",
        "grafeas/v1/deployment.proto",
        "grafeas/v1/discovery.proto",
        "grafeas/v1/dsse_attestation.proto",
        "grafeas/v1/grafeas.proto",
        "grafeas/v1/image.proto",
        "grafeas/v1/intoto_provenance.proto",
        "grafeas/v1/intoto_statement.proto",
        "grafeas/v1/package.proto",
        "grafeas/v1/provenance.proto",
        "grafeas/v1/sbom.proto",
        "grafeas/v1/severity.proto",
        "grafeas/v1/slsa_provenance.proto",
        "grafeas/v1/slsa_provenance_zero_two.proto",
        "grafeas/v1/upgrade.proto",
        "grafeas/v1/vex.proto",
        "grafeas/v1/vulnerability.proto"
      ],
      generator: :cloud
    },
    language_v1: {
      protos: [
        "google/cloud/language/v1/language_service.proto"
      ],
      samples: Dir.glob([
        "../shared/googleapis/google/cloud/language/v1/samples/*.yaml",
        "../shared/googleapis/google/cloud/language/v1/samples/test/*.yaml",
        "../shared/samples/language/*.yaml"
      ]),
      grpc_service_config: "../shared/protos/testing/grpc_service_config/language_grpc_service_config.json",
      generator: :cloud
    },
    language_v1beta1: {
      protos: [
        "google/cloud/language/v1beta1/language_service.proto"
      ],
      generator: :cloud
    },
    language_v1beta2: {
      protos: [
        "google/cloud/language/v1beta2/language_service.proto"
      ],
      generator: :cloud
    },
    language_wrapper: {
      protos: [
        "google/cloud/language/v1/language_service.proto"
      ],
      generator: :cloud
    },
    secretmanager_v1beta1: {
      protos: [
        "google/cloud/secrets/v1beta1/resources.proto",
        "google/cloud/secrets/v1beta1/service.proto",
        "google/cloud/common_resources.proto"
      ],
      generator: :cloud
    },
    secretmanager_wrapper: {
      protos: [
        "google/cloud/secrets/v1beta1/resources.proto",
        "google/cloud/secrets/v1beta1/service.proto",
        "google/cloud/common_resources.proto"
      ],
      generator: :cloud
    },
    speech_v1: {
      protos: [
        "google/cloud/speech/v1/resource.proto",
        "google/cloud/speech/v1/cloud_speech.proto",
        "google/cloud/speech/v1/cloud_speech_adaptation.proto"
      ],
      generator: :cloud
    },
    vision_v1: {
      protos: [
        "google/cloud/vision/v1/geometry.proto",
        "google/cloud/vision/v1/image_annotator.proto",
        "google/cloud/vision/v1/product_search.proto",
        "google/cloud/vision/v1/product_search_service.proto",
        "google/cloud/vision/v1/text_annotation.proto",
        "google/cloud/vision/v1/web_detection.proto"
      ],
      # vision yaml modified from the googleapis one -- added Location mixin
      service_yaml: "../shared/protos/google/cloud/vision/v1/vision_v1.yaml",
      generator: :cloud
    },
    showcase: {
      protos: [
        "google/showcase/v1beta1/compliance.proto",
        "google/showcase/v1beta1/echo.proto",
        "google/showcase/v1beta1/identity.proto",
        "google/showcase/v1beta1/messaging.proto",
        "google/showcase/v1beta1/sequence.proto",
        "google/showcase/v1beta1/testing.proto"
      ],
      service_yaml: "../shared/protos/google/showcase/v1beta1/showcase_v1beta1.yaml"
    },
    garbage: {
      protos: [
        "garbage/garbage.proto",
        "garbage/resource_names.proto",
        "google/iam/v1/iam_policy.proto",
        "google/cloud/common_resources.proto"
      ],
      samples: Dir.glob([
        "../shared/samples/garbage/*.yaml",
        "../shared/samples/garbage/test/*.yaml",
        "../shared/samples/garbage/inline/*.yaml"
      ]),
      service_yaml: "../shared/samples/garbage/inline/typical.yaml"
    },
    noservice: {
      protos: [
        "garbage/noservice.proto"
      ]
    },
    googleads: {
      protos: [
        "google/ads/googleads/v15/services/campaign_service.proto"
      ],
      generator: :ads
    },
    testing: {
      protos: [
        "testing/testing.proto",
        "testing/grpc_service_config/grpc_service_config.proto",
        "testing/mixins/mixins.proto",
        "testing/routing_headers/routing_headers.proto",
        "testing/resources/resources.proto",
        "testing/nonstandard_lro_grpc/nonstandard_lro_grpc.proto",
        # `locations.proto` is included here because it is often
        # included in the real world libraries
        # as part of `files_to_generate` due to protoc limitations
        "google/cloud/location/locations.proto",
      ],
      grpc_service_config: [
        "../shared/protos/testing/grpc_service_config/grpc_service_config.json",
        "../shared/protos/testing/grpc_service_config/grpc_service_config2.json"
      ],
      service_yaml: "../shared/protos/testing/mixins/testing_service.yaml"
    },
    compute_small: {
      protos: [
        "google/cloud/compute/v1/compute_small.proto"
      ],
      generator: :cloud
    },
    compute_small_wrapper: {
      protos: [
        "google/cloud/compute/v1/compute_small.proto"
      ],
      generator: :cloud
    },
    location: {
      protos: [
        "google/cloud/location/locations.proto"
      ],
      generator: :cloud
    }
  }
end

def protos_for service
  gem_defaults[service][:protos]
end

def samples_for service
  gem_defaults[service][:samples]
end

def grpc_service_config_for service
  Array(gem_defaults[service][:grpc_service_config])
end

def service_yaml_for service
  gem_defaults[service][:service_yaml]
end

def generator_for service
  gem_defaults[service][:generator] || :gapic
end

def all_service_names generator: nil, omit_generator: nil
  list = gem_defaults.keys
  list = list.find_all { |service| generator_for(service) == generator } if generator
  list = list.find_all { |service| generator_for(service) != omit_generator } if omit_generator
  list
end
