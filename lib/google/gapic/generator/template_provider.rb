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
      # Abstract base class exposes a method that provides templates.
      class TemplateProvider
        # Returns the templates that result into output files. These templates
        # are expected to be embedded ruby files.
        #
        # @return [Array<String>] An array of templates.
        def templates
          raise NotImplementedError, 'This method must be overridden in subclasses.'
        end

        # Returns a Hash<Symbol, String> that maps the symbol to access the
        # template by to the template content. These templates
        # are expected to be embedded ruby files.
        #
        # @return [Hash<Symbol, String>] A mapping of the symbol to access the
        # template by to the template content.
        def utility_templates
          raise NotImplementedError, 'This method must be overridden in subclasses.'
        end
      end
    end
  end
end
