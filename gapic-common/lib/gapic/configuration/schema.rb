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

module Gapic
  class Configuration < BasicObject
    ##
    # @private
    #
    class Schema
      ##
      # Constructs a Schema object.
      #
      # @param [boolean] show_warnings Whether to print warnings when a
      #     validation fails. Defaults to `true`.
      #
      def initialize show_warnings: true
        @show_warnings = show_warnings
        @defaults = {}
        @validators = {}
      end

      ##
      # Add a value field to the schema.
      #
      # @param [String, Symbol] key The name of the option
      # @param [Object] initial Initial value (defaults to nil)
      # @param [Hash] opts Validation options
      #
      def add_field! key, initial, opts, &block
        key = validate_new_key! key
        opts[:validator] = block if block
        validator = resolve_validator! initial, opts
        validate_value! key, initial, validator
        @defaults[key] = initial
        @validators[key] = validator
      end

      ##
      # Add a subconfiguration field to the schema.
      #
      # @param [Symbol] key The name of the subconfig
      # @param [Configuration] config A config object to attach here. If not provided,
      #     creates a new config.
      #
      def add_config! key, config
        key = validate_new_key! key
        @defaults[key] = config
        @validators[key] = SUBCONFIG
      end

      ##
      # Cause a key to be an alias of another key. The two keys will refer to
      # the same field.
      #
      def add_alias! key, to_key
        key = validate_new_key! key
        to_key = String(to_key).to_sym
        @defaults.delete key
        @validators[key] = to_key
      end

      ##
      # Check if the given key has a default value.
      #
      # @param [Symbol] key The key to check for.
      # @return [Boolean]
      #
      def default? key
        @defaults.key? String(key).to_sym
      end

      ##
      # Return the default value for the given key.
      #
      # @param [Symbol] key The key to check for.
      # @return [Boolean]
      #
      def default key
        @defaults[String(key).to_sym]
      end

      ##
      # Remove the given key from the schema, deleting any validation.
      # If the key is omitted, delete all keys. If the key is an
      # alias, deletes the alias but leaves the original.
      #
      # @param [Symbol, nil] key The key to delete. If omitted or `nil`,
      #     delete all fields and subconfigs.
      #
      def delete! key = nil
        if key.nil?
          @defaults.clear
          @validators.clear
        else
          @defaults.delete key
          @validators.delete key
        end
        self
      end

      ##
      # Check if the given key has been explicitly added as a field name.
      #
      # @param [Symbol] key The key to check for.
      # @return [Boolean]
      #
      def field? key
        @validators[String(key).to_sym].is_a? ::Proc
      end

      ##
      # Check if the given key has been explicitly added as a subconfig name.
      #
      # @param [Symbol] key The key to check for.
      # @return [Boolean]
      #
      def subconfig? key
        @validators[String(key).to_sym] == SUBCONFIG
      end

      ##
      # Check if the given key has been explicitly added as an alias.
      # If so, return the target, otherwise return nil.
      #
      # @param [Symbol] key The key to check for.
      # @return [Symbol,nil] The alias target, or nil if not an alias.
      #
      def alias? key
        target = @validators[String(key).to_sym]
        target.is_a?(::Symbol) ? target : nil
      end

      ##
      # Return a list of explicitly added field names.
      #
      # @return [Array<Symbol>] a list of field names as symbols.
      #
      def fields!
        @validators.keys.find_all { |key| @validators[key].is_a? ::Proc }
      end

      ##
      # Return a list of explicitly added subconfig names.
      #
      # @return [Array<Symbol>] a list of subconfig names as symbols.
      #
      def subconfigs!
        @validators.keys.find_all { |key| @validators[key] == SUBCONFIG }
      end

      ##
      # Return a list of alias names.
      #
      # @return [Array<Symbol>] a list of alias names as symbols.
      #
      def aliases!
        @validators.keys.find_all { |key| @validators[key].is_a? ::Symbol }
      end

      def key? key
        @validators.key? String(key).to_sym
      end

      def keys
        @validators.keys
      end

      ##
      # @private A validator that allows all values
      #
      OPEN_VALIDATOR = ::Proc.new { true }

      ##
      # @private a list of key names that are technically illegal because
      # they clash with method names.
      #
      ILLEGAL_KEYS = [:inspect, :initialize, :instance_eval, :instance_exec, :method_missing,
                      :singleton_method_added, :singleton_method_removed, :singleton_method_undefined].freeze

      ##
      # @private sentinel indicating a subconfig in the validators hash
      #
      SUBCONFIG = ::Object.new

      def resolve_key! key
        key = String(key).to_sym
        alias_target = @validators[key]
        alias_target.is_a?(::Symbol) ? alias_target : key
      end

      def validate_new_key! key
        key_str = String(key)
        key = key.to_sym
        if key_str !~ /^[a-zA-Z]\w*$/ || ILLEGAL_KEYS.include?(key)
          warn! "Illegal key name: #{key_str.inspect}. Method dispatch will" \
                " not work for this key."
        end
        warn! "Key #{key.inspect} already exists. It will be replaced." if @validators.key? key
        key
      end

      def resolve_validator! initial, opts
        allow_nil = initial.nil? || opts[:allow_nil]
        if opts.key? :validator
          build_proc_validator! opts[:validator], allow_nil
        elsif opts.key? :match
          build_match_validator! opts[:match], allow_nil
        elsif opts.key? :enum
          build_enum_validator! opts[:enum], allow_nil
        elsif [true, false].include? initial
          build_enum_validator! [true, false], allow_nil
        elsif initial.nil?
          OPEN_VALIDATOR
        else
          klass = Configuration.config?(initial) ? Configuration : initial.class
          build_match_validator! klass, allow_nil
        end
      end

      def build_match_validator! matches, allow_nil
        matches = ::Kernel.Array(matches)
        matches += [nil] if allow_nil && !matches.include?(nil)
        ->(val) { matches.any? { |m| m.send :===, val } }
      end

      def build_enum_validator! allowed, allow_nil
        allowed = ::Kernel.Array(allowed)
        allowed += [nil] if allow_nil && !allowed.include?(nil)
        ->(val) { allowed.include? val }
      end

      def build_proc_validator! proc, allow_nil
        ->(val) { proc.call(val) || (allow_nil && val.nil?) }
      end

      def validate_value! key, value, validator = nil
        validator ||= @validators[key]
        value = value.call if Configuration::DeferredValue === value
        case validator
        when ::Proc
          unless validator.call value
            warn! "Invalid value #{value.inspect} for key #{key.inspect}." \
                  " Setting anyway."
          end
        when Configuration
          if value != validator
            warn! "Key #{key.inspect} refers to a subconfig and shouldn't" \
                  " be changed. Setting anyway."
          end
        else
          warn! "Key #{key.inspect} has not been added. Setting anyway."
        end
      end

      def warn! msg
        return unless @show_warnings
        location = ::Kernel.caller_locations.find do |s|
          !s.to_s.include? "/gapic/configuration.rb:"
        end
        ::Kernel.warn "#{msg} at #{location}"
      end
    end
  end
end
