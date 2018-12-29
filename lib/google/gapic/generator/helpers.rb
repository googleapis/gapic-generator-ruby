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
  module Gapic
    module Generator
      ##
      # ActionPack helpers for use in templates.
      module Helpers
        ##
        # Extracts part of a template to a string that is stored in the context
        # variable @output_files hash using the provided `file_name` as the key.
        def render_to_file file_name, &block
          @output_files[file_name] = capture &block
        end
      end
    end
  end
end
