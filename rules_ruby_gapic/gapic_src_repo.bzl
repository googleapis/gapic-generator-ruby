load("//rules_ruby_gapic/ruby:private/utils.bzl", _execute_and_check_result = "execute_and_check_result")

def _gapic_generator_src_impl(ctx):
    ctx.download_and_extract(
        url = "https://github.com/googleapis/gapic-generator-ruby/archive/5ade6a2a9df458c63fbd895a4805083f45a41c1e.zip",
        stripPrefix = "gapic-generator-ruby-5ade6a2a9df458c63fbd895a4805083f45a41c1e",
        #sha256 = "8565fa6d4f18833958d61ba843a00c618715ecf8b820182c4ade9be648803b55",
        output = "gen_src",
    )
    ctx.file(
        "BUILD.bazel",
        """exports_files(glob(include = ["gen_src/**"], exclude_directories = 0))""",
    )
    ctx.execute(["rm", "gen_src/gapic-generator/expected_output"], quiet = False)
    ctx.execute(["rm", "gen_src/gapic-generator/proto_input"], quiet = False)
    ctx.execute(["rm", "gen_src/gapic-generator/protofiles_input"], quiet = False)

    ctx.execute(["rm", "gen_src/gapic-generator-ads/expected_output"], quiet = False)
    ctx.execute(["rm", "gen_src/gapic-generator-ads/proto_input"], quiet = False)

    ctx.execute(["rm", "gen_src/gapic-generator-cloud/expected_output"], quiet = False)
    ctx.execute(["rm", "gen_src/gapic-generator-cloud/proto_input"], quiet = False)

    ctx.execute(["rm", "gen_src/shared/input/proto_input"], quiet = False)
    ctx.execute(["rm", "gen_src/shared/output/gapic/expected_output"], quiet = False)
    ctx.execute(["rm", "gen_src/shared/output/cloud/expected_output"], quiet = False)

gapic_generator_src = repository_rule(
  _gapic_generator_src_impl,
)