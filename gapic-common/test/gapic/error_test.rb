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

require "test_helper"

describe Gapic::GapicError do
  describe "without cause" do
    it "presents GRPC::BadStatus values" do
      error = Gapic::GapicError.new "no cause"

      _(error).must_be_kind_of Gapic::GapicError
      _(error.message).must_equal "GapicError no cause"
      _(error.code).must_equal 0
      _(error.details).must_be_empty
      _(error.metadata).must_be_empty
      _(error.status_details).must_be_empty

      _(error.cause).must_be_nil
    end
  end

  describe "with cause as RuntimeError" do
    it "presents GRPC::BadStatus values" do
      error = wrapped_error "not allowed"

      _(error).must_be_kind_of Gapic::GapicError
      _(error.message).must_equal "GapicError not allowed, caused by not allowed"
      _(error.code).must_equal 0
      _(error.details).must_be_empty
      _(error.metadata).must_be_empty
      _(error.status_details).must_be_empty

      _(error.cause).must_be_kind_of RuntimeError
      _(error.cause.message).must_equal "not allowed"
    end
  end

  describe "with cause as GRPC::BadStatus" do
    it "presents GRPC::BadStatus values" do
      error = wrapped_badstatus 3, "invalid"

      _(error).must_be_kind_of Gapic::GapicError
      _(error.message).must_equal "GapicError 3:invalid, caused by 3:invalid"
      _(error.code).must_equal 3
      _(error.details).must_equal "invalid"
      _(error.metadata).must_equal({})
      _(error.status_details).must_be_empty

      _(error.cause).must_be_kind_of GRPC::BadStatus
      _(error.cause.message).must_equal "3:invalid"
      _(error.cause.code).must_equal 3
      _(error.cause.details).must_equal "invalid"
      _(error.cause.metadata).must_equal({})
    end
  end

  describe "with cause as GRPC::BadStatus with status_detail" do
    it "presents GRPC::BadStatus values" do
      status_detail = debug_info "hello world"
      encoded_status_detail = encoded_protobuf status_detail
      metadata = { "foo"                     => "bar",
                   "grpc-status-details-bin" => encoded_status_detail }
      error = wrapped_badstatus 1, "cancelled", metadata

      _(error).must_be_kind_of Gapic::GapicError
      _(error.message).must_equal "GapicError 1:cancelled, caused by 1:cancelled"
      _(error.code).must_equal 1
      _(error.details).must_equal "cancelled"
      _(error.metadata).must_equal metadata
      _(error.status_details).must_equal [status_detail]

      _(error.cause).must_be_kind_of GRPC::BadStatus
      _(error.cause.message).must_equal "1:cancelled"
      _(error.cause.code).must_equal 1
      _(error.cause.details).must_equal "cancelled"
      _(error.cause.metadata).must_equal metadata
    end
  end

  describe "#from_error" do
    it "identifies CanceledError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(1, "cancelled")
      _(mapped_error).must_equal Gapic::CanceledError
    end

    it "identifies UnknownError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(2, "unknown")
      _(mapped_error).must_equal Gapic::UnknownError
    end

    it "identifies InvalidArgumentError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(3, "invalid")
      _(mapped_error).must_equal Gapic::InvalidArgumentError
    end

    it "identifies DeadlineExceededError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(4, "exceeded")
      _(mapped_error).must_equal Gapic::DeadlineExceededError
    end

    it "identifies NotFoundError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(5, "not found")
      _(mapped_error).must_equal Gapic::NotFoundError
    end

    it "identifies AlreadyExistsError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(6, "exists")
      _(mapped_error).must_equal Gapic::AlreadyExistsError
    end

    it "identifies PermissionDeniedError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(7, "denied")
      _(mapped_error).must_equal Gapic::PermissionDeniedError
    end

    it "identifies ResourceExhaustedError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(8, "exhausted")
      _(mapped_error).must_equal Gapic::ResourceExhaustedError
    end

    it "identifies FailedPreconditionError" do
      mapped_error =
        Gapic.from_error GRPC::BadStatus.new(9, "precondition")
      _(mapped_error).must_equal Gapic::FailedPreconditionError
    end

    it "identifies AbortedError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(10, "aborted")
      _(mapped_error).must_equal Gapic::AbortedError
    end

    it "identifies OutOfRangeError" do
      mapped_error =
        Gapic.from_error GRPC::BadStatus.new(11, "out of range")
      _(mapped_error).must_equal Gapic::OutOfRangeError
    end

    it "identifies UnimplementedError" do
      mapped_error =
        Gapic.from_error GRPC::BadStatus.new(12, "unimplemented")
      _(mapped_error).must_equal Gapic::UnimplementedError
    end

    it "identifies InternalError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(13, "internal")
      _(mapped_error).must_equal Gapic::InternalError
    end

    it "identifies UnavailableError" do
      mapped_error =
        Gapic.from_error GRPC::BadStatus.new(14, "unavailable")
      _(mapped_error).must_equal Gapic::UnavailableError
    end

    it "identifies DataLossError" do
      mapped_error = Gapic.from_error GRPC::BadStatus.new(15, "data loss")
      _(mapped_error).must_equal Gapic::DataLossError
    end

    it "identifies UnauthenticatedError" do
      mapped_error =
        Gapic.from_error GRPC::BadStatus.new(16, "unauthenticated")
      _(mapped_error).must_equal Gapic::UnauthenticatedError
    end

    it "identifies unknown error" do
      # We don't know what to map this error case to
      mapped_error = Gapic.from_error GRPC::BadStatus.new(0, "unknown")
      _(mapped_error).must_equal Gapic::GapicError

      mapped_error = Gapic.from_error GRPC::BadStatus.new(17, "unknown")
      _(mapped_error).must_equal Gapic::GapicError
    end
  end

  def wrap_with_gax_error err
    raise err
  rescue StandardError => e
    klass = Gapic.from_error e
    raise klass, e.message
  end

  def wrapped_error msg
    wrap_with_gax_error RuntimeError.new(msg)
  rescue StandardError => gax_err
    gax_err
  end

  def debug_info detail
    Google::Rpc::DebugInfo.new detail: detail
  end

  def encoded_protobuf debug_info
    any = Google::Protobuf::Any.new
    any.pack debug_info

    Google::Rpc::Status.encode(
      Google::Rpc::Status.new(details: [any])
    )
  end

  def wrapped_badstatus status, msg, metadata = {}
    wrap_with_gax_error GRPC::BadStatus.new(status, msg, metadata)
  rescue StandardError => gax_err
    gax_err
  end
end
