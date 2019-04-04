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

require_relative "file_presenter"
require_relative "package_presenter"
require_relative "service_presenter"

class GemPresenter
  def initialize api
    @api = api
  end

  def packages
    @packages ||= begin
      packages = @api.generate_files.map(&:package).uniq.sort
      packages.map { |p| PackagePresenter.new @api, p }
    end
  end

  def services
    @services ||= begin
      files = @api.generate_files.select { |f| f.package == @package }
      files.map(&:services).flatten.map { |s| ServicePresenter.new s }
    end
  end

  def proto_files
    @proto_files ||= begin
      files = @api.files.reject { |f| f.messages.empty? && f.enums.empty? }
      files.map { |f| FilePresenter.new f }
    end
  end

  def namespaces
    name.split("-").map(&:classify)
  end

  def name
    # TODO: Infer the gem name from all the package strings?
    gem_config :name
  end

  def title
    gem_config(:title) ||
      name.split("-").map(&:classify).join(" ")
  end

  def version
    gem_config(:version) ||
      "0.0.1"
  end

  def version_require
    "#{name.gsub("-", "/")}/version"
  end

  def version_file_path
    "#{version_require}.rb"
  end

  def version_name_full
    name.split("-").map(&:classify).join("::") + "::VERSION"
  end

  def authors
    gem_config(:authors) ||
      ["Google LLC"]
  end

  def email
    gem_config(:email) ||
      "googleapis-packages@google.com"
  end

  def description
    gem_config(:description) ||
      "#{name} is the official library for #{title} API."
  end

  def summary
    gem_config(:summary) ||
      "API Client library for #{title} API"
  end

  def homepage
    gem_config(:homepage) ||
      "https://github.com/googleapis/googleapis"
  end

  def env_prefix
    (gem_config(:env_prefix) || name.split("-").last).upcase
  end

  private

  def gem_config key
    return unless @api.configuration[:gem]

    @api.configuration[:gem][key]
  end
end
