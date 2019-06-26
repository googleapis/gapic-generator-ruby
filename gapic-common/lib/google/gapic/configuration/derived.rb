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

require "google/gapic/configuration/deferred_value"
require "google/gapic/configuration/schema"

module Google
  module Gapic
    class Configuration < BasicObject
      ##
      # A Derived Configuration error. This is raised when a structural change
      # is attempted on a derived configuration
      #
      class DerivedError < ::StandardError
      end

      ##
      # A Derived Configuration object. It can set local values,
      # but cannot change the configuration structure.
      #
      class Derived < Configuration
        ##
        # Constructs a Derived object. If a block is given, yields `self` to the
        # block, which makes it convenient to change the local values in the derived object.
        #
        # @param [Configuration] parent_config The parent configuration.
        #
        # @yield [config] Configure the new object.
        # @yieldparam config [Configuration::Derived]
        #
        def initialize parent_config, &block
          @values = {}
          @parent_config = parent_config
          @schema = parent_config.instance_eval { @schema }

          # Can't call yield because of BasicObject
          block&.call self
        end

        ##
        def add_field! _key, _initial = nil, _opts = {}
          ::Kernel.raise DerivedError
        end

        ##
        def add_config! _key, _config = nil
          ::Kernel.raise DerivedError
        end

        ##
        def add_alias! _key, _to_key
          ::Kernel.raise DerivedError
        end

        ##
        # Restore the original default value of the given key.
        # If the key is omitted, restore the original defaults for all keys,
        # and all keys of subconfigs, recursively.
        #
        # @param [Symbol, nil] key The key to reset. If omitted or `nil`,
        #     recursively reset all fields and subconfigs.
        #
        def reset! key = nil
          if key.nil?
            @values.clear
          else
            key = ::Kernel.String(key).to_sym
            @values.delete key
          end
          self
        end

        ##
        # Remove the given key from the configuration, deleting any validation
        # and value. If the key is omitted, delete all keys. If the key is an
        # alias, deletes the alias but leaves the original.
        #
        # @param [Symbol, nil] key The key to delete. If omitted or `nil`,
        #     delete all fields and subconfigs.
        #
        def delete! _key = nil
          ::Kernel.raise DerivedError
        end

        ##
        # Get the option or subconfig with the given name.
        #
        # @param [Symbol, String] key The option or subconfig name
        # @return [Object] The option value or subconfig object
        #
        def [] key
          key = @schema.resolve_key! key
          @schema.warn! "Key #{key.inspect} does not exist. Returning nil." unless @schema.key? key
          value = @values[key]
          value ||= @parent_config[key]
          if Configuration.config? value
            unless value.derived?
              value = Derived.new value
              @values[key] = value
            end
          end
          value = value.call if Configuration::DeferredValue === value
          value
        end

        ##
        # Check if the given key has been set in this object. Returns true if the
        # key has been added as a normal field, subconfig, or alias, or if it has
        # not been added explicitly but still has a value.
        #
        # @param [Symbol] key The key to check for.
        # @return [Boolean]
        #
        def value_set? key
          local_value_set = @values.key? @schema.resolve_key! key
          parent_value_set = @parent_config.value_set? key
          local_value_set || parent_value_set
        end

        ##
        # @private
        # Check if the configuration has been derived.
        #
        # @return [Boolean]
        #
        def derived?
          true
        end
      end
    end
  end
end
