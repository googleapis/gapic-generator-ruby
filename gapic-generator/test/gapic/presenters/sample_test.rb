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

require "test_helper"
require_relative "../../../templates/default/helpers/presenters/sample_presenter"

class SamplePresenterTest < PresenterTest
  def setup
    api_obj = api :speech
    service = api_obj.services.find { |s| s.name == "Speech" }
    refute_nil service
    @sample_config = api_obj.samples.find { |s| s["title"] == "Transcript Audio File (Cloud Storage)" }
    refute_nil @sample_config
    @presenter = SamplePresenter.new api_obj, @sample_config
  end

  def test_description
    assert_equal @sample_config["description"], @presenter.description
  end

  def test_input_parameters
    input_parameters = @presenter.input_parameters
    assert_equal 1, input_parameters.size
    assert_equal "storage_uri", input_parameters[0].input_parameter
    assert_equal "\"gs://cloud-samples-data/speech/brooklyn_bridge.raw\"", input_parameters[0].value
  end

  def test_fields
    fields = @presenter.fields
    assert_equal 2, fields.size

    assert_kind_of Hash, fields["audio"]
    assert_equal 1, fields["audio"].size
    assert_kind_of SamplePresenter::RequestField, fields["audio"]["uri"]
    assert_equal "audio.uri", fields["audio"]["uri"].field
    assert_equal "\"gs://cloud-samples-data/speech/brooklyn_bridge.raw\"", fields["audio"]["uri"].value
    assert_equal "storage_uri", fields["audio"]["uri"].input_parameter
    assert_equal "URI for audio file in Cloud Storage, e.g. gs://[BUCKET]/[FILE]", fields["audio"]["uri"].comment

    assert_kind_of Hash, fields["config"]
    assert_equal 3, fields["config"].size
    assert_kind_of SamplePresenter::RequestField, fields["config"]["sample_rate_hertz"]
    assert_kind_of SamplePresenter::RequestField, fields["config"]["language_code"]
    assert_kind_of SamplePresenter::RequestField, fields["config"]["encoding"]
    assert_equal "config.encoding", fields["config"]["encoding"].field
    assert_equal ":LINEAR16", fields["config"]["encoding"].value
    assert_nil fields["config"]["encoding"].input_parameter
    assert_equal "Encoding of audio data sent. This sample sets this explicitly.\nThis field is optional for FLAC and WAV audio formats.\n", fields["config"]["encoding"].comment
  end

  def test_kwargs
    assert_equal "audio: audio, config: config", @presenter.kwargs
  end
end
