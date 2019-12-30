# frozen_string_literal: true

# Copyright 2018 Google LLC
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

# Auto-generated by gapic-generator-ruby v0.0.1.dev.1. DO NOT EDIT!


module Google
  module Cloud
    module SecretManager
      module V1beta1
        # A [Secret][google.cloud.secrets.v1beta1.Secret] is a logical secret whose value and versions can
        # be accessed.
        #
        # A [Secret][google.cloud.secrets.v1beta1.Secret] is made up of zero or more [SecretVersions][google.cloud.secrets.v1beta1.SecretVersion] that
        # represent the secret data.
        # @!attribute [r] name
        #   @return [String]
        #     Output only. The resource name of the [Secret][google.cloud.secrets.v1beta1.Secret] in the format `projects/*/secrets/*`.
        # @!attribute [rw] replication
        #   @return [Google::Cloud::SecretManager::V1beta1::Replication]
        #     Required. Immutable. The replication policy of the secret data attached to the [Secret][google.cloud.secrets.v1beta1.Secret].
        #
        #     The replication policy cannot be changed after the Secret has been created.
        # @!attribute [r] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time at which the [Secret][google.cloud.secrets.v1beta1.Secret] was created.
        # @!attribute [rw] labels
        #   @return [Google::Cloud::SecretManager::V1beta1::Secret::LabelsEntry]
        #     The labels assigned to this Secret.
        #
        #     Label keys must be between 1 and 63 characters long, have a UTF-8 encoding
        #     of maximum 128 bytes, and must conform to the following PCRE regular
        #     expression: `[\p\\\{Ll\}\p\\\{Lo\}][\p\\\{Ll\}\p\\\{Lo\}\p\\\{N\}_-]\\\{0,62\}`
        #
        #     Label values must be between 0 and 63 characters long, have a UTF-8
        #     encoding of maximum 128 bytes, and must conform to the following PCRE
        #     regular expression: `[\p\\\{Ll\}\p\\\{Lo\}\p\\\{N\}_-]\\\{0,63\}`
        #
        #     No more than 64 labels can be assigned to a given resource.
        class Secret
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods

          # @!attribute [rw] key
          #   @return [String]
          # @!attribute [rw] value
          #   @return [String]
          class LabelsEntry
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end
        end

        # A secret version resource in the Secret Manager API.
        # @!attribute [r] name
        #   @return [String]
        #     Output only. The resource name of the [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion] in the
        #     format `projects/*/secrets/*/versions/*`.
        #
        #     [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion] IDs in a [Secret][google.cloud.secrets.v1beta1.Secret] start at 1 and
        #     are incremented for each subsequent version of the secret.
        # @!attribute [r] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time at which the [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion] was created.
        # @!attribute [r] destroy_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time this [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion] was destroyed.
        #     Only present if [state][google.cloud.secrets.v1beta1.SecretVersion.state] is
        #     [DESTROYED][google.cloud.secrets.v1beta1.SecretVersion.State.DESTROYED].
        # @!attribute [r] state
        #   @return [ENUM(State)]
        #     Output only. The current state of the [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion].
        class SecretVersion
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods

          # The state of a [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion], indicating if it can be accessed.
          module State
            # Not specified. This value is unused and invalid.
            STATE_UNSPECIFIED = 0

            # The [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion] may be accessed.
            ENABLED = 1

            # The [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion] may not be accessed, but the secret data
            # is still available and can be placed back into the [ENABLED][google.cloud.secrets.v1beta1.SecretVersion.State.ENABLED]
            # state.
            DISABLED = 2

            # The [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion] is destroyed and the secret data is no longer
            # stored. A version may not leave this state once entered.
            DESTROYED = 3
          end
        end

        # A policy that defines the replication configuration of data.
        # @!attribute [rw] automatic
        #   @return [Google::Cloud::SecretManager::V1beta1::Replication::Automatic]
        #     The [Secret][google.cloud.secrets.v1beta1.Secret] will automatically be replicated without any restrictions.
        # @!attribute [rw] user_managed
        #   @return [Google::Cloud::SecretManager::V1beta1::Replication::UserManaged]
        #     The [Secret][google.cloud.secrets.v1beta1.Secret] will only be replicated into the locations specified.
        class Replication
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods

          # A replication policy that replicates the [Secret][google.cloud.secrets.v1beta1.Secret] payload without any
          # restrictions.
          class Automatic
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # A replication policy that replicates the [Secret][google.cloud.secrets.v1beta1.Secret] payload into the
          # locations specified in [Secret.replication.user_managed.replicas][]
          # @!attribute [rw] replicas
          #   @return [Google::Cloud::SecretManager::V1beta1::Replication::UserManaged::Replica]
          #     Required. The list of Replicas for this [Secret][google.cloud.secrets.v1beta1.Secret].
          #
          #     Cannot be empty.
          class UserManaged
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # Represents a Replica for this [Secret][google.cloud.secrets.v1beta1.Secret].
            # @!attribute [rw] location
            #   @return [String]
            #     The canonical IDs of the location to replicate data.
            #     For example: `"us-east1"`.
            class Replica
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end
          end
        end

        # A secret payload resource in the Secret Manager API. This contains the
        # sensitive secret data that is associated with a [SecretVersion][google.cloud.secrets.v1beta1.SecretVersion].
        # @!attribute [rw] data
        #   @return [String]
        #     The secret data. Must be no larger than 64KiB.
        class SecretPayload
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end
      end
    end
  end
end
