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

require "test_helper"

require "gapic/configuration"

describe Gapic::Configuration, :derive! do
  let(:new_config) { Gapic::Configuration.new }
  let(:simple_config) do
    Gapic::Configuration.new do |config|
      config.add_field! :opt_bool, true
      config.add_field! :opt_bool_nil, true, allow_nil: true
      config.add_field! :opt_enum, :one, enum: [:one, :two, :three]
      config.add_field! :opt_regex, "hi", match: /^[a-z]+$/
      config.add_field! :opt_class, "hi", match: [String, Symbol]
      config.add_field! :opt_default
    end
  end
  let(:nested_config) do
    Gapic::Configuration.new do |c1|
      c1.add_field! :opt1_int, 1
      c1.add_config! :sub1 do |c2|
        c2.add_field! :opt2_sym, :hi
        c2.add_config! :sub2 do |c3|
          c3.add_field! :opt3_bool, true
          c3.add_field! :opt3_bool_nil, true, allow_nil: true
          c3.add_field! :opt3_enum, :one, enum: [:one, :two, :three]
          c3.add_field! :opt3_regex, "hi", match: /^[a-z]+$/
          c3.add_field! :opt3_class, "hi", match: [String, Symbol]
          c3.add_field! :opt3_default
        end
      end
    end
  end

  it "allows value changes" do
    derived_config = simple_config.derive!

    refute simple_config.derived?
    assert derived_config.derived?

    assert_equal "hi", simple_config.opt_class
    assert_equal "hi", derived_config.opt_class

    simple_config.opt_class = "Hello SimpleConfig!"

    assert_equal "Hello SimpleConfig!", simple_config.opt_class
    assert_equal "Hello SimpleConfig!", derived_config.opt_class

    derived_config.opt_class = "Hello DerivedConfig!"

    assert_equal "Hello SimpleConfig!", simple_config.opt_class
    assert_equal "Hello DerivedConfig!", derived_config.opt_class

    derived_config.reset! :opt_class

    assert_equal "Hello SimpleConfig!", simple_config.opt_class
    assert_equal "Hello SimpleConfig!", derived_config.opt_class

    simple_config.reset! :opt_class

    assert_equal "hi", simple_config.opt_class
    assert_equal "hi", derived_config.opt_class
  end

  it "allows value changes using a block" do
    derived_config = simple_config.derive! do |dc|
      dc.opt_class = "yo"
    end

    refute simple_config.derived?
    assert derived_config.derived?

    assert_equal "hi", simple_config.opt_class
    assert_equal "yo", derived_config.opt_class

    simple_config.opt_class = "Hello SimpleConfig!"

    assert_equal "Hello SimpleConfig!", simple_config.opt_class
    assert_equal "yo", derived_config.opt_class

    derived_config.opt_class = "Hello DerivedConfig!"

    assert_equal "Hello SimpleConfig!", simple_config.opt_class
    assert_equal "Hello DerivedConfig!", derived_config.opt_class

    derived_config.reset! :opt_class

    assert_equal "Hello SimpleConfig!", simple_config.opt_class
    assert_equal "Hello SimpleConfig!", derived_config.opt_class

    simple_config.reset! :opt_class

    assert_equal "hi", simple_config.opt_class
    assert_equal "hi", derived_config.opt_class
  end

  it "allows nested value changes" do
    derived_config = nested_config.derive!

    refute nested_config.derived?
    assert derived_config.derived?

    assert_equal "hi", nested_config.sub1.sub2.opt3_class
    assert_equal "hi", derived_config.sub1.sub2.opt3_class

    nested_config.sub1.sub2.opt3_class = "Hello ComplexConfig!"

    assert_equal "Hello ComplexConfig!", nested_config.sub1.sub2.opt3_class
    assert_equal "Hello ComplexConfig!", derived_config.sub1.sub2.opt3_class

    derived_config.sub1.sub2.opt3_class = "Hello DerivedConfig!"

    assert_equal "Hello ComplexConfig!", nested_config.sub1.sub2.opt3_class
    assert_equal "Hello DerivedConfig!", derived_config.sub1.sub2.opt3_class

    derived_config.sub1.sub2.reset! :opt3_class

    assert_equal "Hello ComplexConfig!", nested_config.sub1.sub2.opt3_class
    assert_equal "Hello ComplexConfig!", derived_config.sub1.sub2.opt3_class

    nested_config.sub1.sub2.reset! :opt3_class

    assert_equal "hi", nested_config.sub1.sub2.opt3_class
    assert_equal "hi", derived_config.sub1.sub2.opt3_class
  end

  it "allows nested value changes using a block" do
    derived_config = nested_config.derive! do |dc|
      dc.sub1.sub2.opt3_class = "yo"
    end

    refute nested_config.derived?
    assert derived_config.derived?

    assert_equal "hi", nested_config.sub1.sub2.opt3_class
    assert_equal "yo", derived_config.sub1.sub2.opt3_class

    nested_config.sub1.sub2.opt3_class = "Hello ComplexConfig!"

    assert_equal "Hello ComplexConfig!", nested_config.sub1.sub2.opt3_class
    assert_equal "yo", derived_config.sub1.sub2.opt3_class

    derived_config.sub1.sub2.opt3_class = "Hello DerivedConfig!"

    assert_equal "Hello ComplexConfig!", nested_config.sub1.sub2.opt3_class
    assert_equal "Hello DerivedConfig!", derived_config.sub1.sub2.opt3_class

    derived_config.sub1.sub2.reset! :opt3_class

    assert_equal "Hello ComplexConfig!", nested_config.sub1.sub2.opt3_class
    assert_equal "Hello ComplexConfig!", derived_config.sub1.sub2.opt3_class

    nested_config.sub1.sub2.reset! :opt3_class

    assert_equal "hi", nested_config.sub1.sub2.opt3_class
    assert_equal "hi", derived_config.sub1.sub2.opt3_class
  end

  it "does not allow structural changes" do
    derived_config = simple_config.derive!

    refute simple_config.derived?
    assert derived_config.derived?

    assert_raises Gapic::Configuration::DerivedError do
      derived_config.add_field! :new_field, true
    end

    assert_raises Gapic::Configuration::DerivedError do
      derived_config.add_config! :new_sub do |c|
        c.add_field! :new_bool, true
        c.add_field! :new_bool_nil, true, allow_nil: true
        c.add_field! :new_enum, :one, enum: [:one, :two, :three]
        c.add_field! :new_regex, "hi", match: /^[a-z]+$/
        c.add_field! :new_class, "hi", match: [String, Symbol]
        c.add_field! :new_default
      end
    end

    assert_raises Gapic::Configuration::DerivedError do
      derived_config.add_alias! :new_bool, :opt_bool
    end

    assert_raises Gapic::Configuration::DerivedError do
      derived_config.delete! :opt_bool
    end

    assert_raises Gapic::Configuration::DerivedError do
      derived_config.delete!
    end
  end
end
