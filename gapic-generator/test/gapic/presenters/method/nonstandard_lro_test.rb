# frozen_string_literal: true

# Copyright 2021 Google LLC
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

##
# Tests for the method-level lro models
#
class MethodPresenterLroTest < PresenterTest
  ##
  # Testing a method that returns a nonstandard lro
  #
  def test_nonstandard_lro_plain
    presenter = method_presenter :testing, "PlainLroConsumer", "PlainLroRpc"
    assert presenter.nonstandard_lro?
    assert_equal "::Testing::NonstandardLroGrpc::PlainLroProvider::Client",
      presenter.nonstandard_lro_client.client_class_name
    assert_equal 1, presenter.lro.operation_request_fields.count
  end

  ##
  # Testing a method that returns another nonstandard lro
  #
  def test_nonstandard_lro_all_subclients_another
    presenter = method_presenter :testing, "AllSubclientsConsumer", "AnotherLroRpc"
    assert presenter.nonstandard_lro?
    assert_equal "::Testing::NonstandardLroGrpc::AnotherLroProvider::Client",
      presenter.nonstandard_lro_client.client_class_name
    assert_equal 1, presenter.lro.operation_request_fields.count
  end

  ##
  # Testing a method that returns a nonstandard lro from the service that returns
  # nonstandard lros from multiple different services
  #
  def test_nonstandard_lro_all_subclients_plain
    presenter = method_presenter :testing, "AllSubclientsConsumer", "PlainLroRpc"
    assert presenter.nonstandard_lro?
    assert_equal "::Testing::NonstandardLroGrpc::PlainLroProvider::Client",
      presenter.nonstandard_lro_client.client_class_name
    assert_equal 1, presenter.lro.operation_request_fields.count
  end

  ##
  # Testing a method that returns a nonstandard lro from the service that consumes
  # nonstandard lros from multiple different services. This method is set up
  # to not copy any of its field to the lro request
  #
  def test_nonstandard_lro_all_subclients_noncopy
    presenter = method_presenter :testing, "AllSubclientsConsumer", "NonCopyAnotherLroRpc"
    assert presenter.nonstandard_lro?
    assert_equal "::Testing::NonstandardLroGrpc::AnotherLroProvider::Client",
      presenter.nonstandard_lro_client.client_class_name
    assert_equal 0, presenter.lro.operation_request_fields.count
  end

  ##
  # Testing a method that returns a standard AIP-151 lro
  #
  def test_nonstandard_lro_all_subclients_aip
    presenter = method_presenter :testing, "AllSubclientsConsumer", "AipLRO"
    refute presenter.nonstandard_lro?
    assert presenter.lro?
  end

  ##
  # Testing a method that does not return an lro
  #
  def test_nonstandard_lro_all_subclients_nolro
    presenter = method_presenter :testing, "AllSubclientsConsumer", "NoLRO"
    refute presenter.nonstandard_lro?
    refute presenter.lro?
  end
end
