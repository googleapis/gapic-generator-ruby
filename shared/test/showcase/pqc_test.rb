# frozen_string_literal: true

# Copyright 2026 Google LLC
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
require "google/showcase/v1beta1/echo"
# Explicit: gapic-common loads GRPC::Core but not grpc/version.rb, so
# GRPC::VERSION is otherwise undefined.
require "grpc"

##
# Verifies that generated Ruby clients negotiate post-quantum hybrid key
# exchange with the Showcase server.
#
# Ruby never performs the key exchange itself: the gRPC transport delegates to
# the BoringSSL build vendored inside the grpc gem, and the REST transport
# delegates to the system OpenSSL that Net::HTTP is linked against. These tests
# therefore assert on what the server observed, using the TLS metadata that
# Showcase reflects back on every response:
#
#   x-showcase-tls-group                    the group that was negotiated
#   x-showcase-tls-client-supported-groups  everything the client offered
#
# Reflecting the server's view keeps the assertions free of any dependence on
# CRuby's internal OpenSSL object layout, which is not stable across releases
# or platforms.
#
class PqcTest < ShowcaseTest
  # Header carrying the key exchange group selected during the handshake.
  NEGOTIATED_GROUP_HEADER = "x-showcase-tls-group"

  # Header carrying every key exchange group the client offered in ClientHello.
  CLIENT_GROUPS_HEADER = "x-showcase-tls-client-supported-groups"

  # The hybrid post-quantum group both Go and BoringSSL prefer by default.
  PQC_GROUP = "X25519MLKEM768"

  # The classical group expected once post-quantum groups are withdrawn.
  CLASSICAL_GROUP = "X25519"

  # IANA codepoints for X25519 and secp256r1. Passed to --tls-groups to strip
  # every post-quantum group from the server's preferences.
  CLASSICAL_ONLY_CODEPOINTS = "0x001d,0x0017"

  # grpc 1.83 is the first release whose vendored BoringSSL offers PQC_GROUP.
  MINIMUM_GRPC_VERSION = Gem::Version.new "1.83.0"

  # ML-KEM, and therefore X25519MLKEM768, first shipped in OpenSSL 3.5. Ruby's
  # openssl gem is only a binding, so REST post-quantum support is a property
  # of the host rather than of any gem we can pin.
  MINIMUM_REST_OPENSSL_VERSION = Gem::Version.new "3.5.0"

  # Opt-in strict mode for the REST transport. CI sets this on jobs running an
  # image that is guaranteed to provide OpenSSL >= 3.5, which turns the
  # tolerant key exchange assertion below into a hard post-quantum
  # requirement. Everywhere else the classical fallback remains acceptable.
  REQUIRE_REST_PQC = ENV["SHOWCASE_REQUIRE_REST_PQC"] == "1"

  # Whether the host can perform post-quantum key exchange over REST at all.
  #
  # Distinct from REQUIRE_REST_PQC, which is a policy choice about how strict to
  # be. This is a fact about the machine. The two coincide in CI only because
  # the strict environment variable is set on exactly the job that runs a
  # PQC-capable image; anywhere else - a workstation on OpenSSL >= 3.5, or CI
  # after the runner is upgraded - they diverge.
  REST_OPENSSL_SUPPORTS_PQC =
    Gem::Version.new(OpenSSL::OPENSSL_LIBRARY_VERSION.split[1]) >= MINIMUM_REST_OPENSSL_VERSION

  def test_grpc_negotiates_post_quantum_key_exchange
    assert_grpc_pqc_capable
    headers = grpc_tls_headers new_echo_client

    assert_equal PQC_GROUP, headers[NEGOTIATED_GROUP_HEADER],
                 "gRPC handshake did not negotiate post-quantum key exchange"
    assert_includes offered_groups(headers), PQC_GROUP,
                    "gRPC client did not advertise #{PQC_GROUP} in its ClientHello"
  end

  def test_rest_negotiates_post_quantum_key_exchange
    headers = rest_tls_headers new_echo_rest_client

    assert_rest_key_exchange headers
  end

  def test_grpc_falls_back_to_classical_key_exchange
    assert_grpc_pqc_capable
    with_showcase_tls_groups CLASSICAL_ONLY_CODEPOINTS do |port, ca_path|
      headers = grpc_tls_headers grpc_echo_client_for(port, ca_path)

      assert_equal CLASSICAL_GROUP, headers[NEGOTIATED_GROUP_HEADER],
                   "gRPC client failed to fall back to classical key exchange"
      # Negotiating X25519 alone proves nothing: a client that had lost
      # post-quantum support entirely would produce the same result. What is
      # being tested is that a PQC-capable client still interoperates with a
      # classical-only server.
      assert_includes offered_groups(headers), PQC_GROUP,
                      "gRPC client no longer advertises #{PQC_GROUP}, so no fallback was exercised"
    end
  end

  def test_rest_falls_back_to_classical_key_exchange
    with_showcase_tls_groups CLASSICAL_ONLY_CODEPOINTS do |port|
      headers = rest_tls_headers rest_echo_client_for(port)

      assert_equal CLASSICAL_GROUP, headers[NEGOTIATED_GROUP_HEADER],
                   "REST client failed to fall back to classical key exchange"
      # Same reasoning as the gRPC case, but only checkable where the host
      # OpenSSL implements ML-KEM at all; below 3.5 the client has no
      # post-quantum group to withhold, so there is no fallback to observe.
      # Gated on capability rather than on REQUIRE_REST_PQC so that a
      # PQC-capable host runs the real assertion even when strict mode is off.
      if REST_OPENSSL_SUPPORTS_PQC
        assert_includes offered_groups(headers), PQC_GROUP,
                        "REST client no longer advertises #{PQC_GROUP}, so no fallback was exercised"
      end
    end
  end

  private

  ##
  # Fails if the grpc gem predates the vendored BoringSSL that added PQC_GROUP.
  # Nothing here pins grpc - it arrives through gapic-common - so without this
  # a downgrade looks like a protocol bug rather than a dependency one.
  #
  # @return [void]
  def assert_grpc_pqc_capable
    assert_operator Gem::Version.new(GRPC::VERSION), :>=, MINIMUM_GRPC_VERSION,
                    "grpc #{GRPC::VERSION} predates #{MINIMUM_GRPC_VERSION}, where the " \
                    "vendored BoringSSL gained #{PQC_GROUP}"
  end

  ##
  # Issues an Echo RPC and returns the TLS metadata the server attached to the
  # response headers, downcased for case-insensitive lookup.
  #
  # @param client [Google::Showcase::V1beta1::Echo::Client]
  # @return [Hash{String=>String}]
  def grpc_tls_headers client
    metadata = nil
    response = client.echo(content: "pqc probe") do |_result, operation|
      metadata = operation.metadata
    end

    assert_equal "pqc probe", response.content
    normalize_headers metadata
  end

  ##
  # Issues an Echo REST call and returns the TLS metadata the server attached
  # to the HTTP response headers, downcased for case-insensitive lookup.
  #
  # @param client [Google::Showcase::V1beta1::Echo::Rest::Client]
  # @return [Hash{String=>String}]
  def rest_tls_headers client
    headers = nil
    response = client.echo(content: "pqc probe") do |_result, operation|
      headers = operation.underlying_op.headers
    end

    assert_equal "pqc probe", response.content
    normalize_headers headers
  end

  ##
  # Flattens gRPC metadata and Faraday headers into a single case-insensitive
  # string map, asserting that the TLS metadata is present at all. Absent
  # headers mean the request never traversed TLS, which would silently turn
  # every assertion below into a no-op.
  #
  # @param raw [Hash, nil]
  # @return [Hash{String=>String}]
  def normalize_headers raw
    refute_nil raw, "no response metadata was captured"
    headers = raw.to_h { |key, value| [key.to_s.downcase, Array(value).join(",")] }

    [NEGOTIATED_GROUP_HEADER, CLIENT_GROUPS_HEADER].each do |header|
      refute_nil headers[header],
                 "showcase did not report #{header}; the connection was not TLS"
    end
    headers
  end

  ##
  # The key exchange groups the client advertised, as a list.
  #
  # Membership must be tested against the split list, never the raw header
  # string: CLASSICAL_GROUP ("X25519") is a substring of PQC_GROUP
  # ("X25519MLKEM768"), so String#include? would report a match for a group the
  # client never offered.
  #
  # @param headers [Hash{String=>String}]
  # @return [Array<String>]
  def offered_groups headers
    headers[CLIENT_GROUPS_HEADER].split(",").map(&:strip)
  end

  ##
  # Boots an auxiliary Showcase server whose key exchange preferences are
  # restricted to the given IANA codepoints, yields its port and the CA
  # certificate it generated, and guarantees the process is reaped.
  #
  # Every server started with --tls mints its own certificate authority, so the
  # auxiliary server cannot share a trust root with the main harness. Both
  # transports have to be pointed at the CA yielded here: REST through
  # SSL_CERT_FILE, which is scoped to the block below because Net::HTTP rebuilds
  # its trust store per connection, and gRPC through explicit credentials built
  # from the yielded path.
  #
  # The suite is not parallelized, so swapping a process-wide environment
  # variable for the duration of the block is safe; adding parallelize_me! to
  # this file would break that assumption.
  #
  # @param codepoints [String] Comma separated IANA key exchange group IDs.
  # @yieldparam port [Integer]
  # @yieldparam ca_path [String]
  # @return [void]
  def with_showcase_tls_groups codepoints
    dir = ShowcaseTest.instance_variable_get :@showcase_dir
    skip "requires a showcase server managed by this test run" if dir.nil?

    port = SHOWCASE_PORT + 1
    ca_path = File.join dir, "ca-#{port}.pem"
    pid = spawn_showcase "#{dir}/gapic-showcase",
                         port: port,
                         ca_path: ca_path,
                         log_file: File.join(dir, "gapic-showcase-#{port}.log"),
                         extra_args: ["--tls-groups", codepoints]

    original_tls_env = TLS_ENV_KEYS.to_h { |key| [key, ENV[key]] }
    begin
      TLS_ENV_KEYS.each { |key| ENV[key] = ca_path }
      yield port, ca_path
    ensure
      original_tls_env.each { |key, value| ENV[key] = value }
      stop_showcase pid
    end
  end

  def grpc_echo_client_for port, ca_path
    Google::Showcase::V1beta1::Echo::Client.new do |config|
      config.endpoint = "localhost:#{port}"
      config.credentials = ShowcaseTest.channel_credentials ca_path
    end
  end

  def rest_echo_client_for port
    Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
      config.endpoint = "https://localhost:#{port}"
      config.credentials = :this_channel_is_insecure
    end
  end

  ##
  # Asserts on the key exchange the server negotiated for a REST call.
  #
  # The gRPC transport carries its own BoringSSL inside the grpc gem, so it can
  # be held to post-quantum key exchange unconditionally. REST cannot: it
  # delegates to the host's OpenSSL, and ML-KEM only exists from OpenSSL 3.5
  # onward. Skipping on older hosts would leave the REST path entirely
  # unverified in any environment below 3.5 - including the stock GitHub
  # Actions runner - so instead the negotiated group is required to be one of
  # the outcomes we consider correct, and is cross-checked against the groups
  # the client actually offered. A non-TLS connection, or any group outside
  # that set, still fails. This mirrors the conformance test in gax-php.
  #
  # Setting SHOWCASE_REQUIRE_REST_PQC=1 promotes this to a strict post-quantum
  # assertion, and is used by the CI job that runs on an image pinned to
  # OpenSSL >= 3.5.
  #
  # @param headers [Hash{String=>String}]
  # @return [void]
  def assert_rest_key_exchange headers
    negotiated = headers[NEGOTIATED_GROUP_HEADER]
    offered = offered_groups headers

    if REQUIRE_REST_PQC
      assert_equal PQC_GROUP, negotiated,
                   "SHOWCASE_REQUIRE_REST_PQC is set but REST negotiated #{negotiated}. " \
                   "Host provides #{OpenSSL::OPENSSL_LIBRARY_VERSION} and post-quantum " \
                   "key exchange requires OpenSSL >= #{MINIMUM_REST_OPENSSL_VERSION}"
      assert_includes offered, PQC_GROUP,
                      "REST client did not advertise #{PQC_GROUP} in its ClientHello"
    else
      assert_includes [PQC_GROUP, CLASSICAL_GROUP], negotiated,
                      "REST negotiated an unexpected key exchange group #{negotiated}. " \
                      "Expected #{PQC_GROUP} on OpenSSL >= #{MINIMUM_REST_OPENSSL_VERSION} " \
                      "or #{CLASSICAL_GROUP} on older hosts " \
                      "(host provides #{OpenSSL::OPENSSL_LIBRARY_VERSION})"
      assert_includes offered, negotiated,
                      "server negotiated #{negotiated} but the client never offered it"
    end
  end
end
