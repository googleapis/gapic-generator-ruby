# frozen_string_literal: true

# Copyright 2020 Google LLC
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
  ##
  # Various Ruby language information useful for generators.
  #
  module RubyInfo
    class << self
      ##
      # A sorted list of Ruby's keywords.
      #
      # @see https://docs.ruby-lang.org/en/2.7.0/keywords_rdoc.html
      #
      # @return [Array<String>]
      #
      def keywords
        @keywords ||= [
          "__ENCODING__",
          "__LINE__",
          "__FILE__",
          "BEGIN",
          "END",
          "alias",
          "and",
          "begin",
          "break",
          "case",
          "class",
          "def",
          "defined?",
          "do",
          "else",
          "elsif",
          "end",
          "ensure",
          "false",
          "for",
          "if",
          "in",
          "module",
          "next",
          "nil",
          "not",
          "or",
          "redo",
          "rescue",
          "retry",
          "return",
          "self",
          "super",
          "then",
          "true",
          "undef",
          "unless",
          "until",
          "when",
          "while",
          "yield"
        ].freeze
      end

      ##
      # A sorted list of method names that generated code should avoid.
      # This includes methods of the Object class (including BasicObject and
      # Kernel), Ruby keywords, and a few special names including "initialize"
      # and "configure".
      #
      # @return [Array<String>]
      #
      def excluded_method_names
        @excluded_method_names ||= begin
          object_methods = (Object.instance_methods + Object.private_instance_methods).map(&:to_s)
          other_methods = ["configure", "initialize"]
          (object_methods + other_methods + keywords).sort.freeze
        end
      end
    end
  end
end
