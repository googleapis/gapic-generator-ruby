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

require_relative "enum_presenter"
require_relative "message_presenter"

class FilePresenter
  include NamespaceHelper

  # @param file [Gapic::Schema::File] the file to present
  def initialize api, file
    @api = api
    @file = file
  end

  def name
    @file.name
  end

  def address
    @file.address
  end

  def namespace
    return @file.ruby_package if @file.ruby_package.present?
    ruby_namespace_for_address address
  end

  def messages
    @messages ||= @file.messages.map { |m| MessagePresenter.new @api, m }
  end

  def enums
    @enums ||= @file.enums.map { |e| EnumPresenter.new e }
  end

  def docs_file_path
    @file.name.gsub(".proto", ".rb")
  end
end
