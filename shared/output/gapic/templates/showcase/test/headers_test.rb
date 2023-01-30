require "helper"
require "debug"

require "gapic/grpc/service_stub"

require "google/showcase/v1beta1/echo_pb"
require "google/showcase/v1beta1/echo_services_pb"
require "google/showcase/v1beta1/echo"

class ::Google::Showcase::EchoHeadersTest < Minitest::Test
  def setup client=nil
    @client = Google::Showcase::V1beta1::Echo::Client.new do |config|
      config.credentials = GRPC::Core::Channel.new "localhost:7469", nil, :this_channel_is_insecure
    end
  end

  # Extracting a field from the request to put into the routing header
  # unchanged, with the key equal to the field name.
  def test_simple_and_rename_extraction
    test_cases = [
      {
        header_field: "foo.123",
        expected: ["header=foo.123", "routing_id=foo.123"]
      },
      {
        header_field: "projects/100",
        expected: "super_id=projects/100"
      },
    ]

    assert_matches @client, test_cases
  end

  def assert_matches client, test_cases, percent_encode: false
    test_cases.each do |test_case|
      request = { content: "foo", header: test_case[:header_field] }
      @client.echo request do |response, operation|
        assert_kind_of ::Hash, operation.metadata
        assert operation.metadata.key? "x-goog-request-params"

        expected = test_case[:expected]
        expected = [expected] unless expected.is_a? ::Array

        expected.each do |expected_elem|
          expected_elem_encoded = URI.encode_www_form([expected_elem.split("=")])

          err_str = "Test case:\nRequest: \n#{request.pretty_inspect}\nExpected: \n#{expected_elem.pretty_inspect}" \
          "\nEncoded: #{expected_elem_encoded}"
          headers = operation.metadata["x-goog-request-params"]
          err_str = "#{err_str}\nHeaders formed: \n #{headers}"

          assert_match expected_elem_encoded, headers, err_str
        end
      end
    end
  end
end
