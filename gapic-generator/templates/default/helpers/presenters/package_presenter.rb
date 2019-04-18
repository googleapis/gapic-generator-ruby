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

require "active_support/inflector"
require_relative "gem_presenter"
require_relative "service_presenter"

class PackagePresenter
  def initialize api, package
    @api = api
    @package = package
  end

  def def gem
    GemPresenter.new.new @api
  end

  def name
    @package
  end

  def services
    @services ||= begin
      files = @api.generate_files.select { |f| f.package == @package }
      files.map(&:services).flatten.map { |s| ServicePresenter.new s }
    end
  end

  def namespaces
    @package.split "."
  end

  def version_require
    namespaces.map(&:underscore).join "/"
  end

  def version_file_path
    version_require + ".rb"
  end
end
