# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module Google
  module Protobuf
    # `Any` contains an arbitrary serialized protocol buffer message along with a
    # URL that describes the type of the serialized message.
    #
    # Protobuf library provides support to pack/unpack Any values in the form
    # of utility functions or additional generated methods of the Any type.
    #
    # Example 1: Pack and unpack a message in C++.
    #
    #     Foo foo = ...;
    #     Any any;
    #     any.PackFrom(foo);
    #     ...
    #     if (any.UnpackTo(&foo)) {
    #       ...
    #     }
    #
    # Example 2: Pack and unpack a message in Java.
    #
    #     Foo foo = ...;
    #     Any any = Any.pack(foo);
    #     ...
    #     if (any.is(Foo.class)) {
    #       foo = any.unpack(Foo.class);
    #     }
    #     // or ...
    #     if (any.isSameTypeAs(Foo.getDefaultInstance())) {
    #       foo = any.unpack(Foo.getDefaultInstance());
    #     }
    #
    #  Example 3: Pack and unpack a message in Python.
    #
    #     foo = Foo(...)
    #     any = Any()
    #     any.Pack(foo)
    #     ...
    #     if any.Is(Foo.DESCRIPTOR):
    #       any.Unpack(foo)
    #       ...
    #
    #  Example 4: Pack and unpack a message in Go
    #
    #      foo := &pb.Foo{...}
    #      any, err := anypb.New(foo)
    #      if err != nil {
    #        ...
    #      }
    #      ...
    #      foo := &pb.Foo{}
    #      if err := any.UnmarshalTo(foo); err != nil {
    #        ...
    #      }
    #
    # The pack methods provided by protobuf library will by default use
    # 'type.googleapis.com/full.type.name' as the type URL and the unpack
    # methods only use the fully qualified type name after the last '/'
    # in the type URL, for example "foo.bar.com/x/y.z" will yield type
    # name "y.z".
    #
    # JSON
    # ====
    # The JSON representation of an `Any` value uses the regular
    # representation of the deserialized, embedded message, with an
    # additional field `@type` which contains the type URL. Example:
    #
    #     package google.profile;
    #     message Person {
    #       string first_name = 1;
    #       string last_name = 2;
    #     }
    #
    #     {
    #       "@type": "type.googleapis.com/google.profile.Person",
    #       "firstName": <string>,
    #       "lastName": <string>
    #     }
    #
    # If the embedded message type is well-known and has a custom JSON
    # representation, that representation will be embedded adding a field
    # `value` which holds the custom JSON in addition to the `@type`
    # field. Example (for message [google.protobuf.Duration][]):
    #
    #     {
    #       "@type": "type.googleapis.com/google.protobuf.Duration",
    #       "value": "1.212s"
    #     }
    # @!attribute [rw] type_url
    #   @return [::String]
    #     A URL/resource name that uniquely identifies the type of the serialized
    #     protocol buffer message. This string must contain at least
    #     one "/" character. The last segment of the URL's path must represent
    #     the fully qualified name of the type (as in
    #     `path/google.protobuf.Duration`). The name should be in a canonical form
    #     (e.g., leading "." is not accepted).
    #
    #     In practice, teams usually precompile into the binary all types that they
    #     expect it to use in the context of Any. However, for URLs which use the
    #     scheme `http`, `https`, or no scheme, one can optionally set up a type
    #     server that maps type URLs to message definitions as follows:
    #
    #     * If no scheme is provided, `https` is assumed.
    #     * An HTTP GET on the URL must yield a [google.protobuf.Type][]
    #       value in binary format, or produce an error.
    #     * Applications are allowed to cache lookup results based on the
    #       URL, or have them precompiled into a binary to avoid any
    #       lookup. Therefore, binary compatibility needs to be preserved
    #       on changes to types. (Use versioned type names to manage
    #       breaking changes.)
    #
    #     Note: this functionality is not currently available in the official
    #     protobuf release, and it is not used for type URLs beginning with
    #     type.googleapis.com.
    #
    #     Schemes other than `http`, `https` (or the empty scheme) might be
    #     used with implementation specific semantics.
    # @!attribute [rw] value
    #   @return [::String]
    #     Must be a valid serialized protocol buffer of the above specified type.
    class Any
      include ::Google::Protobuf::MessageExts
      extend ::Google::Protobuf::MessageExts::ClassMethods
    end
  end
end
