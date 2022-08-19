require "test_helper"
require "google/type/date_pb"

class ProtobufDateTest < Minitest::Spec
  it "date_to_date_pb converts ruby Date to proto Date" do
    date = Date.new(2022, 8, 19)
    datepb = Google::Type::Date.new(year: 2022, month: 8, day: 19)
    _(Gapic::Protobuf.date_to_date_pb(date)).must_equal datepb
  end
end
