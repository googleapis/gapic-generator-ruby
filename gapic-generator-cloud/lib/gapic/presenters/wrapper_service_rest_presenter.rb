# frozen_string_literal: true

# Copyright 2022 Google LLC
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
require "gapic/ruby_info"

module Gapic
  module Presenters
    ##
    # A presenter for wrapper services.
    #
    class WrapperServiceRestPresenter < ServiceRestPresenter
      def factory_method_name
        @factory_method_name ||= begin
          method_name = ActiveSupport::Inflector.underscore main_service.name
          suffix = main_service.gem.factory_method_suffix
          method_name = "#{method_name}#{suffix}" unless method_name.end_with? suffix
          method_name = "#{method_name}_client" if Gapic::RubyInfo.excluded_method_names.include? method_name
          method_name
        end
      end

      def create_client_call
        "#{main_service.gem.namespace}.#{factory_method_name}"
      end

      def configure_client_call
        "#{main_service.gem.namespace}.configure"
      end

      def credentials_class_xref
        "`#{main_service.credentials_name_full}`"
      end
    end
  end
end
