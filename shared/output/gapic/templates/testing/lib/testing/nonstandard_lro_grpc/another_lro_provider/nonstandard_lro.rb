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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "gapic/operation/retry_policy"
require "gapic/generic_lro/operation"

module Testing
  module NonstandardLroGrpc
    module AnotherLroProvider
      # A module containing nonstandard lro helpers
      module NonstandardLro
        class << self
          ##
          # Creates a Generic LRO operation object that wraps the nonstandard
          # long-running operation specific to this service.
          #
          # @param operation [Object] The long-running operation object that is returned by the initial method call.
          #
          # @param client [::Testing::NonstandardLroGrpc::AnotherLroProvider::Client] The client that handles the polling for the longrunning operation.
          #
          # @param request_values [Map<String, String>] The values that are to be copied from the request that
          #   triggered the longrunning operation, into the request that polls for the longrunning operation.
          #   The format is `name of the request field -> value`
          #
          # @param options [Gapic::CallOptions] call options for this operation
          #
          # @return [Gapic::GenericLRO::Operation]
          #
          def create_operation operation, client, request_values, options
            Gapic::GenericLRO::Operation.new(operation,
                                             client: client,
                                             polling_method_name: "get_another",
                                             request_values: request_values,
                                             operation_status_field: "status",
                                             operation_name_field: "name",
                                             operation_err_code_field: "http_error_status_code",
                                             operation_err_msg_field: "http_error_message",
                                             operation_copy_fields: {
                                               "name" => "another_lro_name"
                                             },
                                             options: options)
          end
        end
      end
    end
  end
end
