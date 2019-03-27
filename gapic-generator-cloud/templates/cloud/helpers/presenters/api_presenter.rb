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

require_relative "package_presenter"
require_relative "service_presenter"

class ApiPresenter
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

  def namespaces
    gem_name.split("-").map(&:classify)
  end

  def gem_name
    @api.configuration[:gem_name] #|| gem_address.join("-")
    # TODO: Infer the gem name from all the package strings
  end

  def gem_title
    # TODO: Infer from all the services?

    # if service && service.client_package
    #   title = service.client_package.title
    #   return title unless title.empty?
    # end

    @api.configuration[:gem_title] ||
      gem_name.split("-").map(&:classify).join(" ")
  end

  def gem_version
    @api.configuration[:gem_version] ||
      "0.0.1"
  end

  def gem_version_require
    "#{gem_name.gsub("-", "/")}/version"
  end

  def gem_version_file_path
    "#{gem_version_require}.rb"
  end

  def gem_version_name_full
    gem_name.split("-").map(&:classify).join("::") + "::VERSION"
  end

  def gem_authors
    @api.configuration[:gem_authors] ||
      ["Google LLC"]
  end

  def gem_email
    @api.configuration[:gem_email] ||
      "googleapis-packages@google.com"
  end

  def gem_description
    @api.configuration[:gem_description] ||
      "#{gem_name} is the official library for #{gem_title} API."
  end

  def gem_summary
    @api.configuration[:gem_summary] ||
      "API Client library for #{gem_title} API"
  end

  def gem_homepage
    @api.configuration[:gem_homepage] ||
      "https://github.com/googleapis/googleapis"
  end

  def product_env_prefix
    (@api.configuration[:env_prefix] || gem_name.split("-").last).upcase
  end
end
