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

describe Gapic::Configuration do
  let(:new_config) { Gapic::Configuration.new }
  let(:simple_config) do
    Gapic::Configuration.new do |config|
      config.add_config! :k1 do |k1|
        k1.add_config! :k2 do |k2|
          k2.add_config! :k3
        end
      end
    end
  end
  let(:checked_config) do
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

  describe ".new" do
    it "works with no parameters" do
      config = Gapic::Configuration.new

      assert Gapic::Configuration === config
      config.subconfigs!.must_equal []
    end

    it "warns when accessing missing fields" do
      assert_output("", /Key :opt1 does not exist\. Returning nil\./) { simple_config.opt1.must_be_nil }
      assert_output("", /Key :opt2 does not exist\. Returning nil\./) { simple_config.opt2.must_be_nil }
    end

    it "initializes nested Gapic::Configuration" do
      assert Gapic::Configuration === simple_config.k1
      assert Gapic::Configuration === simple_config.k1.k2
      assert Gapic::Configuration === simple_config.k1.k2.k3
    end

    it "creates nested subconfigs" do
      checked_config.fields!.must_equal [:opt1_int]
      checked_config.subconfigs!.must_equal [:sub1]
      checked_config.sub1.fields!.must_equal [:opt2_sym]
      checked_config.sub1.subconfigs!.must_equal [:sub2]
      checked_config.sub1.sub2.fields!.must_include :opt3_bool
      checked_config.sub1.sub2.subconfigs!.must_equal []
    end

    it "can inspect" do
      expected_inspect = "#<Gapic::Configuration: {:k1=>{:k2=>{:k3=>{}}}}>"
      assert_equal expected_inspect, simple_config.inspect
    end
  end

  describe "#add_field!" do
    it "adds a simple field with no validator" do
      new_config.add_field! :opt1
      new_config.fields!.must_equal [:opt1]
      new_config.field?(:opt1).must_equal true
      -> () {
        obj = Object.new
        new_config.opt1.must_be_nil
        new_config.opt1 = obj
        new_config.opt1.must_be_same_as obj
      }.must_be_silent
    end

    it "adds a simple field with an integer default value" do
      new_config.add_field! :opt1, 1
      new_config.fields!.must_equal [:opt1]
      new_config.field?(:opt1).must_equal true
      -> () {
        new_config.opt1.must_equal 1
        new_config.opt1 = 2
        new_config.opt1.must_equal 2
      }.must_be_silent
      -> () {
        new_config.opt1 = "hi"
      }.must_output nil, %r{Invalid value}
    end
  end

  describe "#add_alias!" do
    it "creates an alias" do
      checked_config.add_alias! :opt1_int_alias, :opt1_int
      checked_config.alias?(:opt1_int_alias).must_equal :opt1_int
      checked_config.alias?(:opt1_int).must_be_nil
      checked_config.aliases!.must_equal [:opt1_int_alias]
    end

    it "causes the alias to act as an alias" do
      checked_config.add_alias! :opt1_int_alias, :opt1_int
      checked_config.opt1_int_alias = 4
      checked_config.opt1_int.must_equal 4
      checked_config.opt1_int = 6
      checked_config.opt1_int_alias.must_equal 6
    end
  end

  describe "#add_config!" do
    it "adds an empty subconfig" do
      new_config.add_config! :sub1
      new_config.subconfigs!.must_equal [:sub1]
      new_config.subconfig?(:sub1).must_equal true
      assert Gapic::Configuration === new_config.sub1
      new_config.sub1.subconfigs!.must_equal []
    end
  end

  describe "#reset!" do
    it "resets a single key" do
      checked_config.opt1_int = 2
      checked_config.opt1_int.must_equal 2
      checked_config.sub1.sub2.opt3_bool = false
      checked_config.sub1.sub2.opt3_bool.must_equal false

      checked_config.reset! :opt1_int

      checked_config.opt1_int.must_equal 1
      checked_config.sub1.sub2.opt3_bool.must_equal false
    end

    it "recursively resets" do
      checked_config.opt1_int = 2
      checked_config.opt1_int.must_equal 2
      checked_config.sub1.sub2.opt3_bool = false
      checked_config.sub1.sub2.opt3_bool.must_equal false

      checked_config.reset!

      checked_config.opt1_int.must_equal 1
      checked_config.sub1.sub2.opt3_bool.must_equal true
    end
  end

  describe "#delete!" do
    it "deletes a single field" do
      checked_config.field?(:opt1_int).must_equal true
      checked_config.subconfigs!.wont_equal []

      checked_config.delete! :opt1_int

      checked_config.field?(:opt1_int).must_equal false
      checked_config.subconfigs!.wont_equal []
    end

    it "deletes everything" do
      checked_config.add_alias! :opt1_int_alias, :opt1_int
      checked_config.fields!.wont_equal []
      checked_config.subconfigs!.wont_equal []
      checked_config.aliases!.wont_equal []

      checked_config.delete!

      checked_config.fields!.must_equal []
      checked_config.subconfigs!.must_equal []
      checked_config.aliases!.must_equal []
    end
  end

  describe "#method_missing" do
    it "allows any key but warns for a checked config" do
      -> () {
        new_config.total_non_sense.must_be_nil
      }.must_output nil, %r{Key :total_non_sense does not exist}
    end

    it "allows any key but warns for a checked config" do
      -> () {
        new_config.total_non_sense.must_be_nil
      }.must_output nil, %r{Key :total_non_sense does not exist}
    end

    it "checks type of an integer field and allows but warns on invalid" do
      -> () {
        checked_config.opt1_int = 20
        checked_config.opt1_int.must_equal 20
      }.must_be_silent

      -> () {
        checked_config.opt1_int = Gapic::Configuration::DeferredValue.new { rand(10) }
        checked_config.opt1_int.must_be :>=, 0
        checked_config.opt1_int.must_be :<, 10
        checked_config.opt1_int.must_be_kind_of Integer
      }.must_be_silent

      -> () {
        checked_config.opt1_int = "20"
      }.must_output nil, %r{Invalid value}
      checked_config.opt1_int.must_equal "20"

      -> () {
        checked_config.opt1_int = nil
      }.must_output nil, %r{Invalid value}
      checked_config.opt1_int.must_be_nil
    end

    it "checks type of a symbol field and allows but warns on invalid" do
      -> () {
        checked_config.sub1.opt2_sym = :bye
        checked_config.sub1.opt2_sym.must_equal :bye
      }.must_be_silent

      -> () {
        checked_config.sub1.opt2_sym = Gapic::Configuration::DeferredValue.new { "foo".to_sym }
        checked_config.sub1.opt2_sym.must_equal :foo
      }.must_be_silent

      -> () {
        checked_config.sub1.opt2_sym = "bye"
      }.must_output nil, %r{Invalid value}
      checked_config.sub1.opt2_sym.must_equal "bye"

      -> () {
        checked_config.sub1.opt2_sym = nil
      }.must_output nil, %r{Invalid value}
      checked_config.sub1.opt2_sym.must_be_nil
    end

    it "checks type of a boolean field and allows but warns on invalid" do
      -> () {
        checked_config.sub1.sub2.opt3_bool = false
        checked_config.sub1.sub2.opt3_bool.must_equal false
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_bool = Gapic::Configuration::DeferredValue.new { true }
        checked_config.sub1.sub2.opt3_bool.must_equal true
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_bool = nil
      }.must_output nil, %r{Invalid value}
      checked_config.sub1.sub2.opt3_bool.must_be_nil
    end

    it "checks type of a boolean field that allows nil" do
      -> () {
        checked_config.sub1.sub2.opt3_bool_nil = false
        checked_config.sub1.sub2.opt3_bool_nil.must_equal false
        checked_config.sub1.sub2.opt3_bool_nil = nil
        checked_config.sub1.sub2.opt3_bool_nil.must_be_nil
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_bool_nil = "true"
      }.must_output nil, %r{Invalid value}
      checked_config.sub1.sub2.opt3_bool_nil.must_equal "true"
    end

    it "checks type of an enum field" do
      -> () {
        checked_config.sub1.sub2.opt3_enum = :two
        checked_config.sub1.sub2.opt3_enum.must_equal :two
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_enum = Gapic::Configuration::DeferredValue.new { :one }
        checked_config.sub1.sub2.opt3_enum.must_equal :one
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_enum = :four
      }.must_output nil, %r{Invalid value}
      checked_config.sub1.sub2.opt3_enum.must_equal :four
    end

    it "checks type of an regex match field" do
      -> () {
        checked_config.sub1.sub2.opt3_regex = "bye"
        checked_config.sub1.sub2.opt3_regex.must_equal "bye"
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_regex = Gapic::Configuration::DeferredValue.new { String :foo }
        checked_config.sub1.sub2.opt3_regex.must_equal "foo"
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_regex = "BYE"
      }.must_output nil, %r{Invalid value}
      checked_config.sub1.sub2.opt3_regex.must_equal "BYE"
    end

    it "checks type of a multiclass match field" do
      -> () {
        checked_config.sub1.sub2.opt3_class = :hi
        checked_config.sub1.sub2.opt3_class.must_equal :hi
      }.must_be_silent

      -> () {
        checked_config.sub1.sub2.opt3_class = 1
      }.must_output nil, %r{Invalid value}
      checked_config.sub1.sub2.opt3_class.must_equal 1
    end

    it "allows any type on a default field" do
      -> () {
        obj = Object.new
        checked_config.sub1.sub2.opt3_default = obj
        checked_config.sub1.sub2.opt3_default.must_be_same_as obj
      }.must_be_silent
    end
  end
end
