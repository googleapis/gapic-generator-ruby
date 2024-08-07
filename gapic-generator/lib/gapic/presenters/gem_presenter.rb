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
        service_config = api.configuration[:common_services] ? nil : api.service_config
        @mixins_model = Gapic::Model::Mixins.new api.services.map(&:full_name), service_config, name
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

      ##
      # @return [Enumerable<Gapic::Presenters::ServicePresenter>]
      #
      def services
        @services ||= begin
          files = @api.generate_files
          service_list = files.map(&:services).flatten
          mixin_service_names = mixins_model.mixin_services
          service_list.delete_if { |s| mixin_service_names.include? s.full_name }
          service_list.map { |s| ServicePresenter.new self, @api, s }
        end
      end

      def first_non_common_service
        services.find { |service| service.common_service_delegate.nil? }
      end

      def proto_files
        @proto_files ||= begin
          @api.files
              .select { |f| useful_proto_file? f }
              .map { |f| FilePresenter.new @api, f }
        end
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
          @api.api_metadata.title ||
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
          @api.api_metadata.description ||
          "#{name} is the official client library for the #{title} API."
      end

      def gemspec_description
        description.gsub(/\s+/, " ").strip
      end

      ##
      # Generates a description text for README files, accounting for markdown
      # rendering and properly escaping variables.
      #
      # @return [Array<String>] The description text as an array of lines.
      #
      def readme_description
        has_markdown = description.strip.start_with? "#"
        desc = has_markdown ? description.split("\n") : [description.gsub(/\s+/, " ").strip]
        Gapic::FormattingUtils.format_doc_lines @api, desc
      end

      def summary
        gem_config(:summary) ||
          @api.api_metadata.summary ||
          "API Client library for the #{title} API"
      end

      def homepage
        gem_config(:homepage) ||
          "https://github.com/googleapis/googleapis"
      end

      def env_prefix
        gem_config(:env_prefix)&.upcase
      end

      def iam_dependency?
        @api.files.map(&:name).any? { |f| f.start_with? "google/iam/v1/" }
      end

      def library_documentation_url
        gem_config(:library_documentation_url) || "https://rubydoc.info/gems/#{name}"
      end

      def product_documentation_url
        gem_config(:product_documentation_url) || @api.api_metadata.documentation_url
      end

      def api_id
        raw_id = gem_config(:api_id) || @api.api_metadata.name
        return nil unless raw_id
        raw_id.include?(".") ? raw_id : "#{raw_id}.googleapis.com"
      end

      def api_shortname
        gem_config(:api_shortname) || @api.api_metadata.short_name
      end

      def doc_tag_prefix
        @api.api_metadata.doc_tag_prefix || api_shortname || api_id&.split(".")&.first
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

      ##
      # @return [Boolean]
      #
      def rest_numeric_enums?
        gem_config(:rest_numeric_enums) || false
      end

      ##
      # @return [Boolean] Whether the generation of REST clients is requested
      #    and can be done because at least one method has rest bindings.
      #
      def generate_rest_clients?
        @api.generate_rest_clients? && packages.any? { |package| !package.first_service_with_rest.nil? }
      end

      ##
      # @return [Boolean] Whether generation of gRPC clients is requested.
      #
      def generate_grpc_clients?
        @api.generate_grpc_clients?
      end

      ##
      # @return [:grpc] If gRPC is the default transport
      # @return [:rest] if REST is the default transport
      #
      def default_transport
        @api.default_transport
      end

      ##
      # @return [String] Pretty name of the default transport
      #
      def default_transport_name
        @api.default_transport == :grpc ? "gRPC" : "REST"
      end

      def entrypoint_require
        return "" unless packages?
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
          deps = { "gapic-common" => [">= 0.21.1", "< 2.a"] }
          deps["grpc-google-iam-v1"] = "~> 1.1" if iam_dependency?
          extra_deps = gem_config_dependencies
          deps.merge! mixins_model.dependencies if mixins_model.mixins?
          # extra deps should be last, overriding mixins or defaults
          deps.merge! extra_deps if extra_deps
          # google-iam-v1 is a superset of grpc-google-iam-v1, so if both are
          # listed, use only google-iam-v1.
          deps.delete "grpc-google-iam-v1" if deps.include? "google-iam-v1"
          deps
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
        packages.first.drift_manifest
      end

      ##
      # Returns a drift manifest of the first package in
      # a pretty JSON string form
      #
      # @return [String]
      def first_package_drift_json
        JSON.pretty_generate first_package_drift_manifest
      end

      ##
      # The service to use for quick start samples. Normally this is simply the
      # {#first_non_common_service}, but it can be overridden via a gem config.
      #
      # @return [Gapic::Presenters::ServicePresenter]
      #
      def quick_start_service
        preferred_service = gem_config :quick_start_service
        result = services.find { |svc| svc.name == preferred_service } if preferred_service
        result || first_non_common_service
      end

      ##
      # Whether the "Enabling (gRPC) Logging" section of the readme should
      # appear. This is true if there is a quick-start service displayed in the
      # readme, AND it uses gRPC.
      #
      # @return [Boolean]
      #
      def show_grpc_logging_docs?
        packages? && quick_start_service.usable_service_presenter.is_a?(ServicePresenter)
      end

      ##
      # Whether there are mixin services that should be referenced
      # in the services for this gem
      #
      # @return [Boolean]
      #
      def mixins?
        @mixins_model.mixins?
      end

      ##
      # The model for the mixin services
      #
      # @return [Gapic::Model::Mixins]
      #
      def mixins_model
        @mixins_model
      end

      private

      def gem_config key
        return unless @api.configuration[:gem]

        @api.configuration[:gem][key]
      end

      ##
      # There is a special case (from PoV of generator parameters)
      # in gem dependencies where a dependency needs to be an array of strings
      # e.g. `">= 1.6", "< 2.a"``
      # Rather than creating a special generator param case for this I will special-case it here.
      # Supported separators are `|` and `+`. The latter is preferred.
      # Spaces in the version requirements are optional.
      # The above would be represented as `">=1.6+<2.a"`
      #
      # @return [Hash<String, String>, Hash{String=>Array<String>}, nil]
      def gem_config_dependencies
        return unless gem_config :extra_dependencies
        gem_config(:extra_dependencies).transform_values do |dep_versions|
          if dep_versions.include? "|"
            dep_versions.split("|").map { |dep_version| check_dep_version dep_version }
          elsif dep_versions.include? "+"
            dep_versions.split("+").map { |dep_version| check_dep_version dep_version }
          else
            check_dep_version dep_versions
          end
        end
      end

      def check_dep_version dep_version
        match = /([>=<~]+)\s*(\d+(?:\.\w+)+)/.match dep_version
        raise "Bad syntax for extra_dependency: #{dep_version}" unless match
        "#{match[1]} #{match[2]}"
      end

      def denylist_protos
        denylist = gem_config(:denylist) || gem_config(:blacklist)

        return default_denylist_protos if denylist.nil?
        return default_denylist_protos if denylist[:protos].nil?

        default_denylist_protos[:protos]
      end

      def default_denylist_protos
        ["google/api/http.proto", "google/protobuf/descriptor.proto"]
      end

      def mixin_paths
        mixins_model.mixins.map(&:require_str)
      end

      def useful_proto_file? file
        return false if file.messages.empty? && file.enums.empty?
        return false if denylist_protos.include? file.name
        mixin_paths.none? { |m| file.name.start_with? m }
      end
    end
  end
end
