The documentation on the [ruby-protobuf's github wiki](https://github.com/ruby-protobuf/protobuf/wiki/Compiling-Definitions) is out-of date regarding protoc commands to run when generating definitions.
The correct invocation is found in their [Rake taskfile](https://github.com/ruby-protobuf/protobuf/blob/master/lib/protobuf/tasks/compile.rake) instead.
I am copying it here for reference:
```
protoc --plugin=protoc-gen-ruby-protobuf=`which protoc-gen-ruby` --ruby-protobuf_out=path/to/destination path/to/file.proto
```

Examples

!!! Note: that the commands below are written to be run from the `gapic-generator/lib/google` folder that contains this README !!!

Note: A reference to the `descriptor.proto` (a file which is shipped with the protobuf and is not included in this repo) has to to be provided to the command. It is given below as 
```-I=`readlink -f ~/.local/protoc/include` ```.

Update a `http.proto`:
```
╭─ gapic-generator/lib/google/
╰─❯ protoc --plugin=protoc-gen-ruby-protobuf=`which protoc-gen-ruby` -I=`readlink -f ../../../shared/googleapis` -I=`readlink -f ~/.local/protoc/include` `readlink -f ../../../shared/googleapis/google/api/http.proto` --ruby-protobuf_out=`readlink -f ..`
```

More complicated example updating multiple files with custom overrides from `protofiles_input`, as well as standard `googleapis` protos:
```
╭─ gapic-generator/lib/google/
╰─❯ protoc --plugin=protoc-gen-ruby-protobuf=`which protoc-gen-ruby` -I=`readlink -f ../../protofiles_input` -I=`readlink -f ../../../shared/googleapis` -I=`readlink -f ~/.local/protoc/include` `readlink -f ../../protofiles_input/google/api/routing.proto` `readlink -f ../../../shared/googleapis/google/api/annotations.proto` --ruby-protobuf_out=`readlink -f ..`
```
