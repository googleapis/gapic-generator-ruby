# frozen_string_literal: true

# Copyright 2023 Google LLC
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

module Gapic
  module Model
    ##
    # A collection of metadata about an API.
    #
    # This information generally comes from the service yaml rather than from
    # proto input.
    #
    class ApiMetadata
      ##
      # @return [String] The full ID of the API, including `".googleapis.com"`.
      #     For example, `"pubsub.googleapis.com"`.
      #
      attr_reader :name

      ##
      # @return [String] The shortname of the API, omitting `".googleapis.com"`.
      #     For example, `"pubsub"`.
      #
      attr_reader :short_name

      ##
      # @return [String] A title of the API, including the version.
      #     For example, `"Cloud Pub/Sub V1"`
      #
      attr_reader :title

      ##
      # @return [String] A short description of the API, suitable for the
      #     RubyGems summary field.
      #
      attr_reader :summary

      ##
      # @return [String] A longer description of the API, suitable for the
      #     RubyGems description field.
      #
      attr_reader :description

      ##
      # @return [String] The organization name, determining where the API's
      #     documentation should be published, among other things. This value
      #     is `"CLOUD"` for Google Cloud APIs.
      #
      attr_reader :organization

      ##
      # @return [String] The URL for the documentation.
      #
      attr_reader :documentation_url

      ##
      # @return [String] The prefix string for sample doc tags.
      #
      attr_reader :doc_tag_prefix

      ##
      # @return [Hash{String => Hash{String => Array<String>}}] A mapping from method selector
      #     to individual method settings (e.g. auto_populated_fields).
      #
      attr_reader :method_settings

      ##
      # @return [Hash{String => Array<String>}] A mapping from method name to a list of auto
      #     populated fields.
      #
      attr_reader :auto_populated_methods

      ######## Internal ########
      SELECTOR = "selector"
      AUTO_POPULATED_FIELDS = "auto_populated_fields"

      ##
      # @private
      # Special cases for short names
      #
      SHORT_NAME_MAPPING = {
        "iam-meta-api" => "iam"
      }.freeze

      # @private
      def update! **keywords
        omit_patterns = [
          nil,
          "",
          "CLIENT_LIBRARY_ORGANIZATION_UNSPECIFIED",
          /\A\s*\(==.+==\)\s*\Z/
        ]
        keywords.each do |key, value|
          instance_variable_set "@#{key}", value unless omit_patterns.any? { |pat| pat === value }
        end
        self
      end

      # @private
      def standardize_names!
        return unless name || short_name
        @name ||= short_name
        @short_name ||= name
        @name = "#{name}.googleapis.com" unless name.include? "."
        @short_name = short_name.split(".").first
        @short_name = SHORT_NAME_MAPPING.fetch @short_name, @short_name
        @doc_tag_prefix ||= short_name
        self
      end

      # @private
      def standardize_title! gem_name:
        return unless title
        @title = title.sub %r{\s+API$}, ""
        return if title =~ /\s+V\d+\w*$/
        vers = gem_name.split("-").last
        @title = "#{title} #{vers.upcase}" if vers =~ /^v\d+\w*$/
        self
      end

      # @private
      def standardize_descriptions!
        return unless summary || description
        @description ||= summary
        if summary
          @summary = summary.gsub(/\s+/, " ").strip
          @summary = "#{summary}." if summary =~ /\w\z/
          @summary = remove_html_tags summary
        end
        @description = description.gsub(/\s+/, " ").strip
        @description = "#{description}." if description =~ /\w\z/
        @description = remove_html_tags description
        self
      end

      # @private
      # Remove html tags and markdown links
      def remove_html_tags str
        str
          .gsub(%r{</?[[:alpha:]]+(?:\s+[[:alpha:]]+\s*=\s*(?:"[^"]+"|'[^']+'|[^\s">]+))*\s*/?>}, "")
          .gsub(%r{\[([^\]]+)\]\([^)]+\)}, "\\1")
      end

      def auto_populated_methods! service_config
        @auto_populated_methods = {}
        return @auto_populated_methods if service_config.nil? || service_config.apis.nil?
        @method_settings.each do |setting|
          selector = setting[SELECTOR]
          methods = service_config.apis.filter_map do |api|
            # Removes API prefix and trailing period.
            selector[api.name.length + 1..].downcase if selector.start_with? api.name
          end
          if !methods.nil? && setting.key?(AUTO_POPULATED_FIELDS)
            @auto_populated_methods[methods.first] = setting[AUTO_POPULATED_FIELDS]
          end
        end
      end
    end
  end
end
