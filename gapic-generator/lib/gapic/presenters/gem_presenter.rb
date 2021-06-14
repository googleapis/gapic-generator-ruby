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

require "gapic/helpers/filepath_helper"
require "gapic/helpers/namespace_helper"

require "json"

module Gapic
  module Presenters
    ##
    # A presenter for gems.
    #
    class GemPresenter
      include Gapic::Helpers::FilepathHelper
      include Gapic::Helpers::NamespaceHelper

      def initialize api
        @api = api
      end

      ##
      # @return [Enumerable<Gapic::Presenters::PackagePresenter>]
      #
      def packages
        @packages ||= begin
          packages = @api.generate_files.map(&:package).uniq.sort
          packages.map { |p| PackagePresenter.new self, @api, p }.delete_if(&:empty?)
        end
      end

      def packages?
        !packages.empty?
      end

      def services
        @services ||= begin
          files = @api.generate_files
          files.map(&:services).flatten.map { |s| ServicePresenter.new self, @api, s }
        end
      end

      def first_non_common_service
        services.find { |service| service.common_service_delegate.nil? }
      end

      def proto_files
        @proto_files ||= begin
          files = @api.files
          files = files.reject { |f| blacklist_protos.include? f.name }
          files = files.reject { |f| f.messages.empty? && f.enums.empty? }
          files.map { |f| FilePresenter.new @api, f }
        end
      end

      def address
        name.split("-").map(&:camelize)
      end

      def name
        gem_config :name
      end

      def namespace
        gem_config(:namespace) ||
          fix_namespace(@api, name.split("-").map(&:camelize).join("::"))
      end

      def title
        gem_config(:title) ||
          namespace.split("::").join(" ")
      end

      def version
        gem_config(:version) ||
          "0.0.1"
      end

      def version_require
        ruby_file_path @api, version_name_full
      end

      def version_file_path
        "#{version_require}.rb"
      end

      def version_name_full
        "#{namespace}::VERSION"
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
          "#{name} is the official client library for the #{title} API."
      end

      def summary
        gem_config(:summary) ||
          "API Client library for the #{title} API"
      end

      def homepage
        gem_config(:homepage) ||
          "https://github.com/googleapis/googleapis"
      end

      def env_prefix
        (gem_config(:env_prefix) || name.split("-").last).upcase
      end

      def iam_dependency?
        @api.files.map(&:name).any? { |f| f.start_with? "google/iam/v1/" }
      end

      def library_documentation_url
        gem_config(:library_documentation_url) || "https://googleapis.dev/ruby/#{name}/latest"
      end

      def product_documentation_url
        gem_config :product_documentation_url
      end

      def api_id
        raw_id = gem_config :api_id
        return nil unless raw_id
        raw_id.include?(".") ? raw_id : "#{raw_id}.googleapis.com"
      end

      def api_shortname
        gem_config :api_shortname
      end

      def issue_tracker_url
        gem_config :issue_tracker_url
      end

      ##
      # @return [Boolean]
      #
      def free_tier?
        gem_config(:free_tier) || false
      end

      ##
      # @return [Boolean]
      #
      def yard_strict?
        # Default to true unless the config is explicitly set to "false"
        gem_config(:yard_strict).nil? || gem_config(:yard_strict)
      end

      ##
      # @return [Boolean]
      #
      def generic_endpoint?
        gem_config(:generic_endpoint) || false
      end

      def entrypoint_require
        packages.first.package_require
      end

      def license_name
        "MIT"
      end

      def extra_files
        ["README.md", "LICENSE.md", ".yardopts"]
      end

      def dependencies
        @dependencies ||= begin
          deps = { "gapic-common" => [">= 0.4.1", "< 2.a"] }
          deps["grpc-google-iam-v1"] = [">= 0.6.10", "< 2.a"] if iam_dependency?
          extra_deps = gem_config_dependencies
          deps.merge! extra_deps if extra_deps
        end
      end

      def dependency_list
        dependencies.to_a
                    .map { |name, requirements| [name, Array(requirements)] }
                    .sort_by { |name, _requirements| name }
      end

      ##
      # Returns a hash with a drift_manifest of
      # a first package in this gem
      # (while the behaviour in case of multiple packages is clarified).
      # See https://github.com/googleapis/googleapis/blob/master/gapic/metadata/gapic_metadata.proto
      #
      # @return [Hash]
      def first_package_drift_manifest
        return {} unless packages?
        packages[0].drift_manifest
      end

      ##
      # Returns a drift manifest of the first package in
      # a pretty JSON string form
      #
      # @return [String]
      def first_package_drift_json
        JSON.pretty_generate first_package_drift_manifest
      end

      private

      def gem_config key
        return unless @api.configuration[:gem]

        @api.configuration[:gem][key]
      end

      ##
      # There is a special case (from PoV of generator parameters)
      # in gem dependencies where a dependency needs to be an array of strings
      # e.g. ">= 1.6", "< 2.a"
      # Rather than creating a special generator param case for this I will special-case it here.
      # '|' is the separator.
      # The above would be represented as ">= 1.6|< 2.a"
      #
      # @return [Hash<String, String>, Hash{String=>Array<String>}, nil]
      def gem_config_dependencies
        return unless gem_config :extra_dependencies
        gem_config(:extra_dependencies).map do |dep_name, dep_versions|
          if dep_versions.include? "|"
            [dep_name, dep_versions.split("|")]
          else
            [dep_name, dep_versions]
          end
        end.to_h
      end

      def blacklist_protos
        blacklist = gem_config :blacklist

        return default_blacklist_protos if blacklist.nil?
        return default_blacklist_protos if blacklist[:protos].nil?

        default_blacklist_protos[:protos]
      end

      def default_blacklist_protos
        ["google/api/http.proto", "google/protobuf/descriptor.proto"]
      end
    end
  end
end
