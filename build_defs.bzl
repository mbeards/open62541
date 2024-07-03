"""TODO(beardsworth): Write module docstring."""

def _generate_nodeset_impl(ctx):
    gen_args = ctx.actions.args()
    if ctx.file.blacklist:
        gen_args.add("--blacklist", ctx.file.blacklist.path)

    if ctx.file.ignore:
        gen_args.add("--ignore", ctx.file.ignore.path)

    if ctx.attr.internal:
        gen_args.add("--internal-headers")

    # compute file suffix
    file_suffix = "_" + ctx.label.name + "_generated"
    c_out = ctx.actions.declare_file(file_suffix + ".c")
    h_out = ctx.actions.declare_file(file_suffix + ".h")

    gen_args.add_all(ctx.files.files, format_each = "--xml=%s")
    gen_args.add(c_out.dirname + file_suffix)

    all_inputs = depset(ctx.files.files + [ctx.file.ignore])

    print(gen_args)
    ctx.actions.run(
        executable = ctx.executable._generate_nodeset,
        outputs = [h_out, c_out],
        inputs = all_inputs,
        arguments = [gen_args],
    )

    return DefaultInfo(files = depset([h_out, c_out]))

generate_nodeset = rule(
    implementation = _generate_nodeset_impl,
    attrs = {
        "files": attr.label_list(allow_files = True),
        "blacklist": attr.label(allow_single_file = True),
        "ignore": attr.label(allow_single_file = True),
        "internal": attr.bool(),
        #"file_csv": attr.label(allow_single_file = True),
        #"file_bsd": attr.label(allow_single_file = True),
        "_generate_nodeset": attr.label(executable = True, default = "//:nodeset_compiler", cfg = "exec"),
    },
)
