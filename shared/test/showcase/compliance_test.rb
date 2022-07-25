require "test_helper"
require "google/showcase/v1beta1/compliance"

class ComplianceTest < ShowcaseTest
  def setup
    @client = new_compliance_rest_client
  end

  ##
  # Runs the compliance suite which contains the requests to be made to
  # the specified compliance service RPCs. The content of the (grpc transcoded)
  # requests is compared with the suite values on server to ensure that the
  # transcoding is performed correctly.
  # The request then is returned as a part of the response.
  def test_compliance
    errors = []
    compliance = JSON.load(File.open "./test_resources/compliance_suite.json")
    compliance["group"].each do |group|
      group["requests"].each do |request|
        reqjson = request.to_json
        req = ::Google::Showcase::V1beta1::RepeatRequest.decode_json reqjson
        group["rpcs"].each do |rpc_full_name|
          rpc_sym = ruby_rpc_name_from_suite_name rpc_full_name
          begin
            resp = @client.send rpc_sym, req
            refute_nil resp.request
            assert_equal resp.request.name, req.name
          rescue Gapic::Common::Error => err
            errors << [group["name"], rpc_full_name, req, err]
          end
        end
      end
    end
    if errors.any?
      s = "The following #{errors.count} errors were caught when making the requests: \n"
      s += errors.each_with_index.reduce("") do |agg, (err_vec, index)|
        agg += "#{index+1}/#{errors.count}: Group `#{err_vec[0]}`, RPC `#{err_vec[1]}`\n" +
        "Error: #{err_vec[3]}\n" +
        "Request: #{err_vec[2].to_json}\n\n"
      end
      raise s
    end
  end

  private

  # The rpc names in compliance_suite.json are in the full grpc format
  # this method converts them to a symbol we can send
  def ruby_rpc_name_from_suite_name rpc_full_name
    underscore(rpc_full_name.split(".")[1]).to_sym
  end
  
  def underscore str
    str = str.gsub(/::/, '/')
    str = str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    str = str.gsub(/([a-z\d])([A-Z])/,'\1_\2')
    str.downcase
  end
end
