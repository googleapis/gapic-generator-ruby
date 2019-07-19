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

require "English"

module Gapic
  # Common base class for exceptions raised by GAX.
  class GapicError < StandardError
    # @param msg [String] describes the error that occurred.
    def initialize msg = nil
      msg = "GapicError #{msg}"
      msg += ", caused by #{$ERROR_INFO}" if $ERROR_INFO
      super msg
    end

    def code
      return nil.to_i unless cause&.respond_to? :code
      cause.code
    end

    def details
      return nil.to_s unless cause&.respond_to? :details
      cause.details
    end

    def metadata
      return nil.to_h unless cause&.respond_to? :metadata
      cause.metadata
    end

    def to_status
      return nil unless cause&.respond_to? :to_status
      cause.to_status
    end
  end

  # Errors corresponding to standard HTTP/gRPC statuses.
  class CanceledError < GapicError
  end

  class UnknownError < GapicError
  end

  class InvalidArgumentError < GapicError
  end

  class DeadlineExceededError < GapicError
  end

  class NotFoundError < GapicError
  end

  class AlreadyExistsError < GapicError
  end

  class PermissionDeniedError < GapicError
  end

  class ResourceExhaustedError < GapicError
  end

  class FailedPreconditionError < GapicError
  end

  class AbortedError < GapicError
  end

  class OutOfRangeError < GapicError
  end

  class UnimplementedError < GapicError
  end

  class InternalError < GapicError
  end

  class UnavailableError < GapicError
  end

  class DataLossError < GapicError
  end

  class UnauthenticatedError < GapicError
  end

  def self.from_error error
    if error.respond_to? :code
      grpc_error_class_for error.code
    else
      GapicError
    end
  end

  ##
  # @private Identify the subclass for a gRPC error
  # Note: ported from
  # https:/g/github.com/GoogleCloudPlatform/google-cloud-ruby/blob/master/google-cloud-core/lib/google/cloud/errors.rb
  def self.grpc_error_class_for grpc_error_code
    # The gRPC status code 0 is for a successful response. So there is no error subclass for a 0 status code, use
    # current class.
    [
      GapicError, CanceledError, UnknownError, InvalidArgumentError, DeadlineExceededError, NotFoundError,
      AlreadyExistsError, PermissionDeniedError, ResourceExhaustedError, FailedPreconditionError, AbortedError,
      OutOfRangeError, UnimplementedError, InternalError, UnavailableError, DataLossError, UnauthenticatedError
    ][grpc_error_code.to_i] || GapicError
  end
end
