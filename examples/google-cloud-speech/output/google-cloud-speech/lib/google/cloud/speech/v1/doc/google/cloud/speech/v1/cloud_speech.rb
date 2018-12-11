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


module Google
  module Cloud
    module Speech
      module V1
        # The top-level message sent by the client for the `Recognize` method.
        # @!attribute [rw] config
        #   @return [Google::Cloud::Speech::V1::RecognitionConfig]
        #     *Required* Provides information to the recognizer that specifies how to
        #     process the request.
        # @!attribute [rw] audio
        #   @return [Google::Cloud::Speech::V1::RecognitionAudio]
        #     *Required* The audio data to be recognized.
        class RecognizeRequest; end

        # The top-level message sent by the client for the `LongRunningRecognize`
        # method.
        # @!attribute [rw] config
        #   @return [Google::Cloud::Speech::V1::RecognitionConfig]
        #     *Required* Provides information to the recognizer that specifies how to
        #     process the request.
        # @!attribute [rw] audio
        #   @return [Google::Cloud::Speech::V1::RecognitionAudio]
        #     *Required* The audio data to be recognized.
        class LongRunningRecognizeRequest; end

        # The top-level message sent by the client for the `StreamingRecognize` method.
        # Multiple `StreamingRecognizeRequest` messages are sent. The first message
        # must contain a `streaming_config` message and must not contain `audio` data.
        # All subsequent messages must contain `audio` data and must not contain a
        # `streaming_config` message.
        # @!attribute [rw] streaming_config
        #   @return [Google::Cloud::Speech::V1::StreamingRecognitionConfig]
        #     Provides information to the recognizer that specifies how to process the
        #     request. The first `StreamingRecognizeRequest` message must contain a
        #     `streaming_config`  message.
        # @!attribute [rw] audio_content
        #   @return [String]
        #     The audio data to be recognized. Sequential chunks of audio data are sent
        #     in sequential `StreamingRecognizeRequest` messages. The first
        #     `StreamingRecognizeRequest` message must not contain `audio_content` data
        #     and all subsequent `StreamingRecognizeRequest` messages must contain
        #     `audio_content` data. The audio bytes must be encoded as specified in
        #     `RecognitionConfig`. Note: as with all bytes fields, protobuffers use a
        #     pure binary representation (not base64). See
        #     [content limits](https://cloud.google.com/speech-to-text/quotas#content).
        class StreamingRecognizeRequest; end

        # Provides information to the recognizer that specifies how to process the
        # request.
        # @!attribute [rw] config
        #   @return [Google::Cloud::Speech::V1::RecognitionConfig]
        #     *Required* Provides information to the recognizer that specifies how to
        #     process the request.
        # @!attribute [rw] single_utterance
        #   @return [true, false]
        #     *Optional* If `false` or omitted, the recognizer will perform continuous
        #     recognition (continuing to wait for and process audio even if the user
        #     pauses speaking) until the client closes the input stream (gRPC API) or
        #     until the maximum time limit has been reached. May return multiple
        #     `StreamingRecognitionResult`s with the `is_final` flag set to `true`.
        #
        #     If `true`, the recognizer will detect a single spoken utterance. When it
        #     detects that the user has paused or stopped speaking, it will return an
        #     `END_OF_SINGLE_UTTERANCE` event and cease recognition. It will return no
        #     more than one `StreamingRecognitionResult` with the `is_final` flag set to
        #     `true`.
        # @!attribute [rw] interim_results
        #   @return [true, false]
        #     *Optional* If `true`, interim results (tentative hypotheses) may be
        #     returned as they become available (these interim results are indicated with
        #     the `is_final=false` flag).
        #     If `false` or omitted, only `is_final=true` result(s) are returned.
        class StreamingRecognitionConfig; end

        # Provides information to the recognizer that specifies how to process the
        # request.
        # @!attribute [rw] encoding
        #   @return [Google::Cloud::Speech::V1::RecognitionConfig::AudioEncoding]
        #     Encoding of audio data sent in all `RecognitionAudio` messages.
        #     This field is optional for `FLAC` and `WAV` audio files and required
        #     for all other audio formats. For details, see
        #     {Google::Cloud::Speech::V1::RecognitionConfig::AudioEncoding AudioEncoding}.
        # @!attribute [rw] sample_rate_hertz
        #   @return [Integer]
        #     Sample rate in Hertz of the audio data sent in all
        #     `RecognitionAudio` messages. Valid values are: 8000-48000.
        #     16000 is optimal. For best results, set the sampling rate of the audio
        #     source to 16000 Hz. If that's not possible, use the native sample rate of
        #     the audio source (instead of re-sampling).
        #     This field is optional for `FLAC` and `WAV` audio files and required
        #     for all other audio formats. For details, see
        #     {Google::Cloud::Speech::V1::RecognitionConfig::AudioEncoding AudioEncoding}.
        # @!attribute [rw] language_code
        #   @return [String]
        #     *Required* The language of the supplied audio as a
        #     [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tag.
        #     Example: "en-US".
        #     See [Language Support](https://cloud.google.com/speech-to-text/docs/languages)
        #     for a list of the currently supported language codes.
        # @!attribute [rw] max_alternatives
        #   @return [Integer]
        #     *Optional* Maximum number of recognition hypotheses to be returned.
        #     Specifically, the maximum number of `SpeechRecognitionAlternative` messages
        #     within each `SpeechRecognitionResult`.
        #     The server may return fewer than `max_alternatives`.
        #     Valid values are `0`-`30`. A value of `0` or `1` will return a maximum of
        #     one. If omitted, will return a maximum of one.
        # @!attribute [rw] profanity_filter
        #   @return [true, false]
        #     *Optional* If set to `true`, the server will attempt to filter out
        #     profanities, replacing all but the initial character in each filtered word
        #     with asterisks, e.g. "f***". If set to `false` or omitted, profanities
        #     won't be filtered out.
        # @!attribute [rw] speech_contexts
        #   @return [Array<Google::Cloud::Speech::V1::SpeechContext>]
        #     *Optional* array of {Google::Cloud::Speech::V1::SpeechContext SpeechContext}.
        #     A means to provide context to assist the speech recognition. For more
        #     information, see [Phrase Hints](https://cloud.google.com/speech-to-text/docs/basics#phrase-hints).
        # @!attribute [rw] enable_word_time_offsets
        #   @return [true, false]
        #     *Optional* If `true`, the top result includes a list of words and
        #     the start and end time offsets (timestamps) for those words. If
        #     `false`, no word-level time offset information is returned. The default is
        #     `false`.
        # @!attribute [rw] enable_automatic_punctuation
        #   @return [true, false]
        #     *Optional* If 'true', adds punctuation to recognition result hypotheses.
        #     This feature is only available in select languages. Setting this for
        #     requests in other languages has no effect at all.
        #     The default 'false' value does not add punctuation to result hypotheses.
        #     Note: This is currently offered as an experimental service, complimentary
        #     to all users. In the future this may be exclusively available as a
        #     premium feature.
        # @!attribute [rw] model
        #   @return [String]
        #     *Optional* Which model to select for the given request. Select the model
        #     best suited to your domain to get best results. If a model is not
        #     explicitly specified, then we auto-select a model based on the parameters
        #     in the RecognitionConfig.
        #     <table>
        #       <tr>
        #         <td><b>Model</b></td>
        #         <td><b>Description</b></td>
        #       </tr>
        #       <tr>
        #         <td><code>command_and_search</code></td>
        #         <td>Best for short queries such as voice commands or voice search.</td>
        #       </tr>
        #       <tr>
        #         <td><code>phone_call</code></td>
        #         <td>Best for audio that originated from a phone call (typically
        #         recorded at an 8khz sampling rate).</td>
        #       </tr>
        #       <tr>
        #         <td><code>video</code></td>
        #         <td>Best for audio that originated from from video or includes multiple
        #             speakers. Ideally the audio is recorded at a 16khz or greater
        #             sampling rate. This is a premium model that costs more than the
        #             standard rate.</td>
        #       </tr>
        #       <tr>
        #         <td><code>default</code></td>
        #         <td>Best for audio that is not one of the specific audio models.
        #             For example, long-form audio. Ideally the audio is high-fidelity,
        #             recorded at a 16khz or greater sampling rate.</td>
        #       </tr>
        #     </table>
        # @!attribute [rw] use_enhanced
        #   @return [true, false]
        #     *Optional* Set to true to use an enhanced model for speech recognition.
        #     You must also set the `model` field to a valid, enhanced model. If
        #     `use_enhanced` is set to true and the `model` field is not set, then
        #     `use_enhanced` is ignored. If `use_enhanced` is true and an enhanced
        #     version of the specified model does not exist, then the speech is
        #     recognized using the standard version of the specified model.
        #
        #     Enhanced speech models require that you opt-in to data logging using
        #     instructions in the [documentation](https://cloud.google.com/speech-to-text/enable-data-logging).
        #     If you set `use_enhanced` to true and you have not enabled audio logging,
        #     then you will receive an error.
        class RecognitionConfig
          # The encoding of the audio data sent in the request.
          #
          # All encodings support only 1 channel (mono) audio.
          #
          # For best results, the audio source should be captured and transmitted using
          # a lossless encoding (`FLAC` or `LINEAR16`). The accuracy of the speech
          # recognition can be reduced if lossy codecs are used to capture or transmit
          # audio, particularly if background noise is present. Lossy codecs include
          # `MULAW`, `AMR`, `AMR_WB`, `OGG_OPUS`, and `SPEEX_WITH_HEADER_BYTE`.
          #
          # The `FLAC` and `WAV` audio file formats include a header that describes the
          # included audio content. You can request recognition for `WAV` files that
          # contain either `LINEAR16` or `MULAW` encoded audio.
          # If you send `FLAC` or `WAV` audio file format in
          # your request, you do not need to specify an `AudioEncoding`; the audio
          # encoding format is determined from the file header. If you specify
          # an `AudioEncoding` when you send  send `FLAC` or `WAV` audio, the
          # encoding configuration must match the encoding described in the audio
          # header; otherwise the request returns an
          # {Google::Rpc::Code::INVALID_ARGUMENT} error code.
          module AudioEncoding
            # Not specified.
            ENCODING_UNSPECIFIED = 0

            # Uncompressed 16-bit signed little-endian samples (Linear PCM).
            LINEAR16 = 1

            # `FLAC` (Free Lossless Audio
            # Codec) is the recommended encoding because it is
            # lossless--therefore recognition is not compromised--and
            # requires only about half the bandwidth of `LINEAR16`. `FLAC` stream
            # encoding supports 16-bit and 24-bit samples, however, not all fields in
            # `STREAMINFO` are supported.
            FLAC = 2

            # 8-bit samples that compand 14-bit audio samples using G.711 PCMU/mu-law.
            MULAW = 3

            # Adaptive Multi-Rate Narrowband codec. `sample_rate_hertz` must be 8000.
            AMR = 4

            # Adaptive Multi-Rate Wideband codec. `sample_rate_hertz` must be 16000.
            AMR_WB = 5

            # Opus encoded audio frames in Ogg container
            # ([OggOpus](https://wiki.xiph.org/OggOpus)).
            # `sample_rate_hertz` must be one of 8000, 12000, 16000, 24000, or 48000.
            OGG_OPUS = 6

            # Although the use of lossy encodings is not recommended, if a very low
            # bitrate encoding is required, `OGG_OPUS` is highly preferred over
            # Speex encoding. The [Speex](https://speex.org/)  encoding supported by
            # Cloud Speech API has a header byte in each block, as in MIME type
            # `audio/x-speex-with-header-byte`.
            # It is a variant of the RTP Speex encoding defined in
            # [RFC 5574](https://tools.ietf.org/html/rfc5574).
            # The stream is a sequence of blocks, one block per RTP packet. Each block
            # starts with a byte containing the length of the block, in bytes, followed
            # by one or more frames of Speex data, padded to an integral number of
            # bytes (octets) as specified in RFC 5574. In other words, each RTP header
            # is replaced with a single byte containing the block length. Only Speex
            # wideband is supported. `sample_rate_hertz` must be 16000.
            SPEEX_WITH_HEADER_BYTE = 7
          end
        end

        # Provides "hints" to the speech recognizer to favor specific words and phrases
        # in the results.
        # @!attribute [rw] phrases
        #   @return [Array<String>]
        #     *Optional* A list of strings containing words and phrases "hints" so that
        #     the speech recognition is more likely to recognize them. This can be used
        #     to improve the accuracy for specific words and phrases, for example, if
        #     specific commands are typically spoken by the user. This can also be used
        #     to add additional words to the vocabulary of the recognizer. See
        #     [usage limits](https://cloud.google.com/speech-to-text/quotas#content).
        class SpeechContext; end

        # Contains audio data in the encoding specified in the `RecognitionConfig`.
        # Either `content` or `uri` must be supplied. Supplying both or neither
        # returns {Google::Rpc::Code::INVALID_ARGUMENT}. See
        # [content limits](https://cloud.google.com/speech-to-text/quotas#content).
        # @!attribute [rw] content
        #   @return [String]
        #     The audio data bytes encoded as specified in
        #     `RecognitionConfig`. Note: as with all bytes fields, protobuffers use a
        #     pure binary representation, whereas JSON representations use base64.
        # @!attribute [rw] uri
        #   @return [String]
        #     URI that points to a file that contains audio data bytes as specified in
        #     `RecognitionConfig`. The file must not be compressed (for example, gzip).
        #     Currently, only Google Cloud Storage URIs are
        #     supported, which must be specified in the following format:
        #     `gs://bucket_name/object_name` (other URI formats return
        #     {Google::Rpc::Code::INVALID_ARGUMENT}). For more information, see
        #     [Request URIs](https://cloud.google.com/storage/docs/reference-uris).
        class RecognitionAudio; end

        # The only message returned to the client by the `Recognize` method. It
        # contains the result as zero or more sequential `SpeechRecognitionResult`
        # messages.
        # @!attribute [rw] results
        #   @return [Array<Google::Cloud::Speech::V1::SpeechRecognitionResult>]
        #     Output only. Sequential list of transcription results corresponding to
        #     sequential portions of audio.
        class RecognizeResponse; end

        # The only message returned to the client by the `LongRunningRecognize` method.
        # It contains the result as zero or more sequential `SpeechRecognitionResult`
        # messages. It is included in the `result.response` field of the `Operation`
        # returned by the `GetOperation` call of the `google::longrunning::Operations`
        # service.
        # @!attribute [rw] results
        #   @return [Array<Google::Cloud::Speech::V1::SpeechRecognitionResult>]
        #     Output only. Sequential list of transcription results corresponding to
        #     sequential portions of audio.
        class LongRunningRecognizeResponse; end

        # Describes the progress of a long-running `LongRunningRecognize` call. It is
        # included in the `metadata` field of the `Operation` returned by the
        # `GetOperation` call of the `google::longrunning::Operations` service.
        # @!attribute [rw] progress_percent
        #   @return [Integer]
        #     Approximate percentage of audio processed thus far. Guaranteed to be 100
        #     when the audio is fully processed and the results are available.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time when the request was received.
        # @!attribute [rw] last_update_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time of the most recent processing update.
        class LongRunningRecognizeMetadata; end

        # `StreamingRecognizeResponse` is the only message returned to the client by
        # `StreamingRecognize`. A series of zero or more `StreamingRecognizeResponse`
        # messages are streamed back to the client. If there is no recognizable
        # audio, and `single_utterance` is set to false, then no messages are streamed
        # back to the client.
        #
        # Here's an example of a series of ten `StreamingRecognizeResponse`s that might
        # be returned while processing audio:
        #
        # 1. results { alternatives { transcript: "tube" } stability: 0.01 }
        #
        # 2. results { alternatives { transcript: "to be a" } stability: 0.01 }
        #
        # 3. results { alternatives { transcript: "to be" } stability: 0.9 }
        #    results { alternatives { transcript: " or not to be" } stability: 0.01 }
        #
        # 4. results { alternatives { transcript: "to be or not to be"
        #                             confidence: 0.92 }
        #              alternatives { transcript: "to bee or not to bee" }
        #              is_final: true }
        #
        # 5. results { alternatives { transcript: " that's" } stability: 0.01 }
        #
        # 6. results { alternatives { transcript: " that is" } stability: 0.9 }
        #    results { alternatives { transcript: " the question" } stability: 0.01 }
        #
        # 7. results { alternatives { transcript: " that is the question"
        #                             confidence: 0.98 }
        #              alternatives { transcript: " that was the question" }
        #              is_final: true }
        #
        # Notes:
        #
        # * Only two of the above responses #4 and #7 contain final results; they are
        #   indicated by `is_final: true`. Concatenating these together generates the
        #   full transcript: "to be or not to be that is the question".
        #
        # * The others contain interim `results`. #3 and #6 contain two interim
        #   `results`: the first portion has a high stability and is less likely to
        #   change; the second portion has a low stability and is very likely to
        #   change. A UI designer might choose to show only high stability `results`.
        #
        # * The specific `stability` and `confidence` values shown above are only for
        #   illustrative purposes. Actual values may vary.
        #
        # * In each response, only one of these fields will be set:
        #   `error`,
        #   `speech_event_type`, or
        #   one or more (repeated) `results`.
        # @!attribute [rw] error
        #   @return [Google::Rpc::Status]
        #     Output only. If set, returns a {Google::Rpc::Status} message that
        #     specifies the error for the operation.
        # @!attribute [rw] results
        #   @return [Array<Google::Cloud::Speech::V1::StreamingRecognitionResult>]
        #     Output only. This repeated list contains zero or more results that
        #     correspond to consecutive portions of the audio currently being processed.
        #     It contains zero or one `is_final=true` result (the newly settled portion),
        #     followed by zero or more `is_final=false` results (the interim results).
        # @!attribute [rw] speech_event_type
        #   @return [Google::Cloud::Speech::V1::StreamingRecognizeResponse::SpeechEventType]
        #     Output only. Indicates the type of speech event.
        class StreamingRecognizeResponse
          # Indicates the type of speech event.
          module SpeechEventType
            # No speech event specified.
            SPEECH_EVENT_UNSPECIFIED = 0

            # This event indicates that the server has detected the end of the user's
            # speech utterance and expects no additional speech. Therefore, the server
            # will not process additional audio (although it may subsequently return
            # additional results). The client should stop sending additional audio
            # data, half-close the gRPC connection, and wait for any additional results
            # until the server closes the gRPC connection. This event is only sent if
            # `single_utterance` was set to `true`, and is not used otherwise.
            END_OF_SINGLE_UTTERANCE = 1
          end
        end

        # A streaming speech recognition result corresponding to a portion of the audio
        # that is currently being processed.
        # @!attribute [rw] alternatives
        #   @return [Array<Google::Cloud::Speech::V1::SpeechRecognitionAlternative>]
        #     Output only. May contain one or more recognition hypotheses (up to the
        #     maximum specified in `max_alternatives`).
        #     These alternatives are ordered in terms of accuracy, with the top (first)
        #     alternative being the most probable, as ranked by the recognizer.
        # @!attribute [rw] is_final
        #   @return [true, false]
        #     Output only. If `false`, this `StreamingRecognitionResult` represents an
        #     interim result that may change. If `true`, this is the final time the
        #     speech service will return this particular `StreamingRecognitionResult`,
        #     the recognizer will not return any further hypotheses for this portion of
        #     the transcript and corresponding audio.
        # @!attribute [rw] stability
        #   @return [Float]
        #     Output only. An estimate of the likelihood that the recognizer will not
        #     change its guess about this interim result. Values range from 0.0
        #     (completely unstable) to 1.0 (completely stable).
        #     This field is only provided for interim results (`is_final=false`).
        #     The default of 0.0 is a sentinel value indicating `stability` was not set.
        class StreamingRecognitionResult; end

        # A speech recognition result corresponding to a portion of the audio.
        # @!attribute [rw] alternatives
        #   @return [Array<Google::Cloud::Speech::V1::SpeechRecognitionAlternative>]
        #     Output only. May contain one or more recognition hypotheses (up to the
        #     maximum specified in `max_alternatives`).
        #     These alternatives are ordered in terms of accuracy, with the top (first)
        #     alternative being the most probable, as ranked by the recognizer.
        class SpeechRecognitionResult; end

        # Alternative hypotheses (a.k.a. n-best list).
        # @!attribute [rw] transcript
        #   @return [String]
        #     Output only. Transcript text representing the words that the user spoke.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Output only. The confidence estimate between 0.0 and 1.0. A higher number
        #     indicates an estimated greater likelihood that the recognized words are
        #     correct. This field is set only for the top alternative of a non-streaming
        #     result or, of a streaming result where `is_final=true`.
        #     This field is not guaranteed to be accurate and users should not rely on it
        #     to be always provided.
        #     The default of 0.0 is a sentinel value indicating `confidence` was not set.
        # @!attribute [rw] words
        #   @return [Array<Google::Cloud::Speech::V1::WordInfo>]
        #     Output only. A list of word-specific information for each recognized word.
        class SpeechRecognitionAlternative; end

        # Word-specific information for recognized words.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Duration]
        #     Output only. Time offset relative to the beginning of the audio,
        #     and corresponding to the start of the spoken word.
        #     This field is only set if `enable_word_time_offsets=true` and only
        #     in the top hypothesis.
        #     This is an experimental feature and the accuracy of the time offset can
        #     vary.
        # @!attribute [rw] end_time
        #   @return [Google::Protobuf::Duration]
        #     Output only. Time offset relative to the beginning of the audio,
        #     and corresponding to the end of the spoken word.
        #     This field is only set if `enable_word_time_offsets=true` and only
        #     in the top hypothesis.
        #     This is an experimental feature and the accuracy of the time offset can
        #     vary.
        # @!attribute [rw] word
        #   @return [String]
        #     Output only. The word corresponding to this set of information.
        class WordInfo; end
      end
    end
  end
end
