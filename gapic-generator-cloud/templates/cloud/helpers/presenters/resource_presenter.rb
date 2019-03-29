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

class ResourcePresenter
  def initialize name, template
    @name = name
    @template = Template.new template

    if positional_args?
      raise ArgumentError, "only resources with named segments are supported, " \
                           " not #{@template.template}"
    end
  end

  def name
    @name
  end

  def template
    @template.template
  end

  def path_helper
    "#{ActiveSupport::Inflector.underscore @name}_path"
  end

  def positional_args
    @template.positional_args
  end

  def named_args
    @template.named_args
  end

  def path_string
    @template.output
  end

  private

  def positional_args?
    @template.positional_args.any?
  end

  class Template
    TMPL = /((?<positional>\*\*?)|{(?<name>[^\/]+?)(?:=(?<template>.+?))?})/

    attr_reader :template, :positional_args, :named_args, :output

    def initialize template
      @template = template
      @positional_args = []
      @named_args = []

      out = []
      tmpl = template.dup
      while m = TMPL.match(tmpl)
        pos_arg_num = @positional_args.count + 1
        out << m.pre_match
        if m[:positional] == "*"
          out << "\#{arg#{pos_arg_num}}"
          @positional_args << ["arg#{pos_arg_num}", "/([^/]+)/", "arg#{pos_arg_num} cannot contain /"]
        elsif m[:positional] == "**"
          out << "\#{arg#{pos_arg_num}}"
          @positional_args << ["arg#{pos_arg_num}", nil, nil]
        else
          out << "\#{#{m[:name]}}"
          if m[:template]
            named_tmpl_regexp = m[:template].dup
            named_tmpl_regexp.gsub! "**", ".+"
            named_tmpl_regexp.gsub! "*", "[^/]+"
            named_tmpl_regexp.gsub! "/", "\\/"
            @named_args << [m[:name], named_tmpl_regexp, "#{m[:name]} must match #{m[:template]}"]
          else
            @named_args << [m[:name], "/([^/]+)/", "#{m[:name]} cannot contain /"]
          end
        end
        tmpl = m.post_match
      end
      @output = out.join
    end
  end
end
