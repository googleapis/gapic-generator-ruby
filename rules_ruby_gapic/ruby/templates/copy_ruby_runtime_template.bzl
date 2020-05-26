"""
copy_ruby_runtime template
"""

copy_ruby_runtime_template = """
'''
a rule for exporting the ruby runtime files
'''

def _copy_ruby_runtime_impl(ctx):
    output_dir = ctx.actions.declare_directory("lib/ruby/ruby_bazel_libroot")

    ctx.actions.run_shell(
        command="mkdir -p {output_dir}".format(output_dir = output_dir),
        outputs=[output_dir])

    return [DefaultInfo(files = depset(direct = [output_dir]))]

copy_ruby_runtime = rule (
    implementation = _copy_ruby_runtime_impl
)
"""
