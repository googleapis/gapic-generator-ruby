# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Google
  module Rpc
    # Describes when the clients can retry a failed request. Clients could ignore
    # the recommendation here or retry when this information is missing from error
    # responses.
    #
    # It's always recommended that clients should use exponential backoff when
    # retrying.
    #
    # Clients should wait until `retry_delay` amount of time has passed since
    # receiving the error response before retrying.  If retrying requests also
    # fail, clients should use an exponential backoff scheme to gradually increase
    # the delay between retries based on `retry_delay`, until either a maximum
    # number of retires have been reached or a maximum retry delay cap has been
    # reached.
    # @!attribute [rw] retry_delay
    #   @return [Google::Protobuf::Duration]
    #     Clients should wait at least this long between retrying the same request.
    class RetryInfo
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes additional debugging info.
    # @!attribute [rw] stack_entries
    #   @return [String]
    #     The stack trace entries indicating where the error occurred.
    # @!attribute [rw] detail
    #   @return [String]
    #     Additional debugging information provided by the server.
    class DebugInfo
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes how a quota check failed.
    #
    # For example if a daily limit was exceeded for the calling project,
    # a service could respond with a QuotaFailure detail containing the project
    # id and the description of the quota limit that was exceeded.  If the
    # calling project hasn't enabled the service in the developer console, then
    # a service could respond with the project id and set `service_disabled`
    # to true.
    #
    # Also see RetryDetail and Help types for other details about handling a
    # quota failure.
    # @!attribute [rw] violations
    #   @return [Google::Rpc::QuotaFailure::Violation]
    #     Describes all quota violations.
    class QuotaFailure
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # A message type used to describe a single quota violation.  For example, a
      # daily quota or a custom quota that was exceeded.
      # @!attribute [rw] subject
      #   @return [String]
      #     The subject on which the quota check failed.
      #     For example, "clientip:<ip address of client>" or "project:<Google
      #     developer project id>".
      # @!attribute [rw] description
      #   @return [String]
      #     A description of how the quota check failed. Clients can use this
      #     description to find more about the quota configuration in the service's
      #     public documentation, or find the relevant quota limit to adjust through
      #     developer console.
      #
      #     For example: "Service disabled" or "Daily Limit for read operations
      #     exceeded".
      class Violation
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Describes what preconditions have failed.
    #
    # For example, if an RPC failed because it required the Terms of Service to be
    # acknowledged, it could list the terms of service violation in the
    # PreconditionFailure message.
    # @!attribute [rw] violations
    #   @return [Google::Rpc::PreconditionFailure::Violation]
    #     Describes all precondition violations.
    class PreconditionFailure
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # A message type used to describe a single precondition failure.
      # @!attribute [rw] type
      #   @return [String]
      #     The type of PreconditionFailure. We recommend using a service-specific
      #     enum type to define the supported precondition violation types. For
      #     example, "TOS" for "Terms of Service violation".
      # @!attribute [rw] subject
      #   @return [String]
      #     The subject, relative to the type, that failed.
      #     For example, "google.com/cloud" relative to the "TOS" type would
      #     indicate which terms of service is being referenced.
      # @!attribute [rw] description
      #   @return [String]
      #     A description of how the precondition failed. Developers can use this
      #     description to understand how to fix the failure.
      #
      #     For example: "Terms of service not accepted".
      class Violation
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Describes violations in a client request. This error type focuses on the
    # syntactic aspects of the request.
    # @!attribute [rw] field_violations
    #   @return [Google::Rpc::BadRequest::FieldViolation]
    #     Describes all violations in a client request.
    class BadRequest
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # A message type used to describe a single bad request field.
      # @!attribute [rw] field
      #   @return [String]
      #     A path leading to a field in the request body. The value will be a
      #     sequence of dot-separated identifiers that identify a protocol buffer
      #     field. E.g., "field_violations.field" would identify this field.
      # @!attribute [rw] description
      #   @return [String]
      #     A description of why the request element is bad.
      class FieldViolation
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Contains metadata about the request that clients can attach when filing a bug
    # or providing other forms of feedback.
    # @!attribute [rw] request_id
    #   @return [String]
    #     An opaque string that should only be interpreted by the service generating
    #     it. For example, it can be used to identify requests in the service's logs.
    # @!attribute [rw] serving_data
    #   @return [String]
    #     Any data that was used to serve this request. For example, an encrypted
    #     stack trace that can be sent back to the service provider for debugging.
    class RequestInfo
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes the resource that is being accessed.
    # @!attribute [rw] resource_type
    #   @return [String]
    #     A name for the type of resource being accessed, e.g. "sql table",
    #     "cloud storage bucket", "file", "Google calendar"; or the type URL
    #     of the resource: e.g. "type.googleapis.com/google.pubsub.v1.Topic".
    # @!attribute [rw] resource_name
    #   @return [String]
    #     The name of the resource being accessed.  For example, a shared calendar
    #     name: "example.com_4fghdhgsrgh@group.calendar.google.com", if the current
    #     error is [google.rpc.Code.PERMISSION_DENIED][google.rpc.Code.PERMISSION_DENIED].
    # @!attribute [rw] owner
    #   @return [String]
    #     The owner of the resource (optional).
    #     For example, "user:<owner email>" or "project:<Google developer project
    #     id>".
    # @!attribute [rw] description
    #   @return [String]
    #     Describes what error is encountered when accessing this resource.
    #     For example, updating a cloud project may require the `writer` permission
    #     on the developer console project.
    class ResourceInfo
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Provides links to documentation or for performing an out of band action.
    #
    # For example, if a quota check failed with an error indicating the calling
    # project hasn't enabled the accessed service, this can contain a URL pointing
    # directly to the right place in the developer console to flip the bit.
    # @!attribute [rw] links
    #   @return [Google::Rpc::Help::Link]
    #     URL(s) pointing to additional information on handling the current error.
    class Help
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # Describes a URL link.
      # @!attribute [rw] description
      #   @return [String]
      #     Describes what the link offers.
      # @!attribute [rw] url
      #   @return [String]
      #     The URL of the link.
      class Link
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Provides a localized error message that is safe to return to the user
    # which can be attached to an RPC error.
    # @!attribute [rw] locale
    #   @return [String]
    #     The locale used following the specification defined at
    #     http://www.rfc-editor.org/rfc/bcp/bcp47.txt.
    #     Examples are: "en-US", "fr-CH", "es-MX"
    # @!attribute [rw] message
    #   @return [String]
    #     The localized error message in the above locale.
    class LocalizedMessage
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
