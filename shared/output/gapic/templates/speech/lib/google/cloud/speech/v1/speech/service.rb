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

require "grpc"
require "google/cloud/speech/v1/cloud_speech_pb"

module Google
  module Cloud
    module Speech
      module V1
        module Speech
          # Service that implements Google Cloud Speech API.
          class Service
            include ::GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = "google.cloud.speech.v1.Speech"

            # Performs synchronous speech recognition: receive results after all audio
            # has been sent and processed.
            rpc :Recognize,
                Google::Cloud::Speech::V1::RecognizeRequest,
                Google::Cloud::Speech::V1::RecognizeResponse

            # Performs asynchronous speech recognition: receive results via the
            # google.longrunning.Operations interface. Returns either an
            # `Operation.error` or an `Operation.response` which contains
            # a `LongRunningRecognizeResponse` message.
            rpc :LongRunningRecognize,
                Google::Cloud::Speech::V1::LongRunningRecognizeRequest,
                Google::Longrunning::Operation

            # Performs bidirectional streaming speech recognition: receive results while
            # sending audio. This method is only available via the gRPC API (not REST).
            rpc :StreamingRecognize,
                stream(Google::Cloud::Speech::V1::StreamingRecognizeRequest),
                stream(Google::Cloud::Speech::V1::StreamingRecognizeResponse)
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
