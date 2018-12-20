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

require 'test_helper'

class ClientTest < Minitest::Test
  def test_client
    provider = ActionController::Base.new()
    provider.prepend_view_path("templates")
    service = OpenStruct.new(name: "Speech")
    assigns = {
      service: service,
      namespaces: %w[google cloud speech v1]
    }
    result = provider.render_to_string(
      template: "client",
      layout: "ruby",
      assigns: assigns
    )
    assert_equal expected, result
  end

  ##
  # In the actual generator, the Ruby code in this output is formatted by
  # Rubocop after it is rendered.
  def expected
<<EOF
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
class SpeechClient
end
end
end
end
end
EOF
  end
end
