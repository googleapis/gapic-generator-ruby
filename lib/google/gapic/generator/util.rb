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

require 'protobuf/descriptors'

module Google
  module Gapic
    module Generator

      # The utility class that is passed as context to the templates.
      #
      # This class also exposes utility templates provided by the template
      # provider. These utility templates are exposed as Erubis::Eruby objects
      # which can be accessed by the the name of the symbol.
      class Util
        # This token signifies that the a new file will is being rendered. The
        # content following this token is understood to be the content of the
        # file.
        NAME_TOKEN = '##FILE##'.freeze

        # Initializes the Util.
        def initialize template_provider
          load_templates template_provider
        end

        # Exposes the templates.
        def method_missing(name, *args, &block)
          return @templates[name] if @templates[name]
          super
        end

        # Declares the start of a new file.
        #
        # @param name [String] The name of the new file.
        # @returns [String] The declaration of a new file.
        def file_name name
          raise ArgumentError.new 'A name must be passed to #file_name' unless name
          "#{NAME_TOKEN}#{name}"
        end

        # Converts just the first character to uppercase.
        # File activesupport/lib/active_support/inflector/methods.rb, line 156
        def upcase_first(string)
          string.length > 0 ? string[0].upcase.concat(string[1..-1]) : ""
        end

        def rubyize_constant s
          s.split(".").reject(&:empty?).map { |m| upcase_first m }.join("::")
        end

        # Makes an underscored, lowercase form from the expression in the string.
        # File activesupport/lib/active_support/inflector/methods.rb, line 92
        def underscore(camel_cased_word)
          return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)
          word = camel_cased_word.to_s.gsub("::".freeze, "/".freeze)
          # word.gsub!(inflections.acronyms_underscore_regex) { "#{$1 && '_'.freeze }#{$2.downcase}" }
          word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
          word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
          word.tr!("-".freeze, "_".freeze)
          word.downcase!
          word
        end

        # Converts a camelCased string to a snake_cased string.
        def snake_case s
          # Replace all capital letters that are preceded by a lower-case letter.
          s = s.gsub(/(?<=[a-z])<capital>([A-Z])/, '_<capital>')

          # Find all capital letters that are followed by a lower-case letter,
          # and are preceded by any character other than underscore.
          # (Note: This also excludes beginning-of-string.)
          s = s.gsub(/(?<=[^_])<capital>([A-Z])(?=[a-z])/, '_<capital>')

          # Numbers are a weird case; the goal is to spot when they _start_
          # some kind of name or acronym (e.g. 2FA, 3M).
          #
          # Find cases of a number preceded by a lower-case letter _and_
          # followed by at least two capital letters or a single capital and
          # end of string.
          s = s.gsub(/(?<=[a-z])<digit>(\d)(?=[A-Z]{2})/, '_<digit>')
          s = s.gsub(/(?<=[a-z])<digit>(\d)(?=[A-Z]$)/, '_<digit>')

          # Done; return the camel-cased string.
          s.downcase
        end

        # Converts a snake_cased string to an UpperCamel cased string.
        def upper_camel s
          s.split('_')
            .map {|part| part.capitalize }
            .join('')
        end

        # Each template can render multiple files. This method creates a mapping
        # of the file name to the content from the rendered string.
        #
        # @return [Hash<String, String>]
        #   The a mapping of the file name to the file content.
        def split_files rendered
          answer = {}
          split = rendered.split(/^(#{NAME_TOKEN})(.*)$/)
          split.length.times do |i|
            answer[split[i+1]] = split[i+2].strip if split[i] == NAME_TOKEN
          end
          answer
        end

        # Private.
        # Loads utility the templates at into @templates as a
        # Hash<Symbol, Erubis::Eruby>.
        def load_templates template_provider
          @templates = template_provider
            .utility_templates
            .each
            .reduce({}) do |memo, (key, tmpl)|
              memo.merge({key => Erubis::Eruby.new(tmpl)})
            end
        end
        private :load_templates
      end
    end
  end
end
