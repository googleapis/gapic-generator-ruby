require "test_helper"
require "fiddle"
require "openssl"

module PQProbe
  LIBSSL = Fiddle.dlopen("libssl.so.3")
  GET_GROUP_NAME = Fiddle::Function.new(
    LIBSSL["SSL_get0_group_name"],
    [Fiddle::TYPE_VOIDP], Fiddle::TYPE_VOIDP
  )
  DATA_OFFSET = 32

  def self.group_of(ssl_socket)
    value_addr = Fiddle.dlwrap(ssl_socket)
    ssl_ptr = Fiddle::Pointer.new(value_addr)[DATA_OFFSET, 8].unpack1("Q")
    return "(no SSL*)" if ssl_ptr.zero?
    name = GET_GROUP_NAME.call(ssl_ptr)
    name.null? ? "(none)" : name.to_s
  end

  def connect_nonblock(*, **)
    super.tap do |ret|
      next if ret.is_a?(Symbol)
      @negotiated_group = PQProbe.group_of(self)
    end
  end

  def connect
    super.tap { @negotiated_group = PQProbe.group_of(self) }
  end

  def negotiated_group
    @negotiated_group
  end
end
OpenSSL::SSL::SSLSocket.prepend PQProbe

class PqcRestTest < ShowcaseTest
  def test_rest_pqc_negotiation
    client = new_echo_rest_client
    response = client.echo content: "PQC check"
    assert_equal "PQC check", response.content
  end
end
