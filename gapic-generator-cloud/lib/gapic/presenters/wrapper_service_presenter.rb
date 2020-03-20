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

require "gapic/presenters"

module Gapic
  module Presenters
    ##
    # A presenter for wrapper services.
    #
    class WrapperServicePresenter < ServicePresenter
      def gem
        WrapperGemPresenter.new @api
      end

      def factory_method_name
        ActiveSupport::Inflector.underscore name
      end

      def create_client_call
        "#{gem.namespace}.#{factory_method_name}"
      end

      def configure_client_call
        "#{gem.namespace}.configure"
      end

      def credentials_class_xref
        "`#{credentials_name_full}`"
      end
    end
  end
end
