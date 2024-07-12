"""TODO(beardsworth): Write module docstring."""

load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")

def _generate_nodeset_impl(ctx):
    gen_args = ctx.actions.args()
    if ctx.attr.internal:
        gen_args.add("--internal-headers")

    if ctx.file.ignore:
        gen_args.add("--ignore", ctx.file.ignore.path)

    if ctx.file.blacklist:
        gen_args.add("--blacklist", ctx.file.blacklist.path)

    gen_dir_path = ctx.label.package + "/" + ctx.attr.prefix
    if ctx.label.package == "":
        gen_dir_path = ctx.attr.prefix

    #gen_dir = ctx.actions.declare_directory(gen_dir_path)
    #ctx.actions.run_shell(
    #    outputs = [gen_dir],
    #    command = "mkdir %s" % gen_dir.path,
    #)

    # compute file suffix
    #file_suffix = ctx.label.package + "/" + ctx.attr.prefix + "/" + ctx.label.name + "_generated"
    file_suffix = ctx.label.name + "_generated"
    print(ctx.attr.prefix)
    print("fs", file_suffix)
    c_out = ctx.actions.declare_file(ctx.attr.prefix + "/" + file_suffix + ".c")
    h_out = ctx.actions.declare_file(ctx.attr.prefix + "/" + file_suffix + ".h")
    print("h", h_out)

    gen_args.add_all(ctx.files.files, format_each = "--xml=%s")
    gen_args.add("-v")
    gen_args.add("-v")
    gen_args.add("-v")

    #gen_args.add("-v")
    gen_args.add(c_out.dirname + "/" + file_suffix)

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
        "prefix": attr.string(),
        "blacklist": attr.label(allow_single_file = True),
        "ignore": attr.label(allow_single_file = True),
        "internal": attr.bool(),
        #"file_csv": attr.label(allow_single_file = True),
        #"file_bsd": attr.label(allow_single_file = True),
        "_generate_nodeset": attr.label(executable = True, default = "//:nodeset_compiler", cfg = "exec"),
    },
)

def _generate_config_h_impl(ctx):
    output_file = ctx.actions.declare_file(ctx.attr.output_path)

    substitutions = {
        "${OPEN62541_VER_MAJOR}": "0",
        "${OPEN62541_VER_MINOR}": "0",
        "${OPEN62541_VER_PATCH}": "0",
        "${OPEN62541_VER_LABEL}": "bazel",
        "${OPEN62541_VER_COMMIT}": "",
        "${OPEN62541_VERSION}": "0.0.0-bazel",
        "#cmakedefine UA_ARCHITECTURE_WIN32": "#undef UA_ARCHITECTURE_WIN32",
        "#cmakedefine UA_ARCHITECTURE_POSIX": "#define UA_ARCHITECTURE_POSIX 1",
        "${UA_LOGLEVEL}": "0",
        "${UA_MULTITHREADING}": "100",
        "${UA_ARCHITECTURES_NODEF}": "0",
        "${UA_ARCHITECTURE}": "posix",
    }

    defines = [
        "UA_ENABLE_METHODCALLS",
        "UA_ENABLE_PUBSUB_ENCRYPTION",
        "UA_ENABLE_PUBSUB",
        "UA_ENABLE_SUBSCRIPTIONS_EVENTS",
        "UA_ENABLE_SUBSCRIPTIONS",
        "UA_ENABLE_DISCOVERY_SEMAPHORE",
        "UA_ENABLE_DISCOVERY",
        "UA_ENABLE_ENCRYPTION_OPENSSL",
        "UA_ENABLE_MALLOC_SINGLETON",
        "UA_ENABLE_TYPEDESCRIPTION",
        "UA_ENABLE_JSON_ENCODING",
    ]

    undefines = [
        "UA_ENABLE_DISCOVERY_MULTICAST",
        "UA_ENABLE_EXPERIMENTAL_HISTORIZING",
        "UA_ENABLE_WEBSOCKET_SERVER",
        "UA_ENABLE_UNIT_TEST_FAILURE_HOOKS",
        "UA_ENABLE_VALGRIND_INTERACTIVE",
        "UA_PACK_DEBIAN",
        "UA_ENABLE_AMALGAMATION",
        "UA_DEBUG",
        "UA_DEBUG_DUMP_PKGS",
        "UA_DEBUG_FILE_LINE_INFO",
        "UA_DYNAMIC_LINKING",
        "UA_ENABLE_NODEMANAGEMENT",
        "UA_ENABLE_DA",
        "UA_ENABLE_DIAGNOSTICS",
        "UA_ENABLE_HISTORIZING",
        "UA_ENABLE_PARSING",
        "UA_ENABLE_PUBSUB_ETH_UADP",
        "UA_ENABLE_PUBSUB_DELTAFRAMES",
        "UA_ENABLE_PUBSUB_MQTT",
        "UA_ENABLE_PUBSUB_FILE_CONFIG",
        "UA_ENABLE_PUBSUB_INFORMATIONMODEL",
        "UA_ENABLE_PUBSUB_MONITORING",
        "UA_ENABLE_PUBSUB_BUFMALLOC",
        "UA_ENABLE_PUBSUB_SKS",
        "UA_ENABLE_SUBSCRIPTION_EVENTS",
        "UA_ENABLE_XML_ENCODING",
        "UA_ENABLE_MQTT",
        "UA_ENABLE_NODESET_INJECTOR",
        "UA_INFORMATION_MODEL_AUTOLOAD",
        "UA_ENABLE_ENCRYPTION_MBEDTLS",
        "UA_ENABLE_TPM2_SECURITY",
        "UA_ENABLE_ENCRYPTION_LIBRESSL",
        "UA_ENABLE_SUBSCRIPTIONS_ALARMS_CONDITIONS",
        "UA_ENABLE_IMMUTABLE_NODES",
        "UA_ENABLE_STATUSCODE_DESCRIPTIONS",
        "UA_ENABLE_INLINABLE_EXPORT",
        "UA_ENABLE_NODESET_COMPILER_DESCRIPTIONS",
        "UA_ENABLE_DETERMINISTIC_RNG",
        "UA_ENABLE_QUERY",
        "UA_GENERATED_NAMESPACE_ZERO_FULL",
        "UA_GENERATED_NAMESPACE_ZERO",
    ]

    for undefine in undefines:
        substitutions["#cmakedefine %s" % undefine] = "#undef %s" % undefine

    for define in defines:
        substitutions["#cmakedefine %s" % define] = "#define %s 1" % define

    ctx.actions.expand_template(
        template = ctx.file._template_file,
        output = output_file,
        substitutions = substitutions,
    )

    return DefaultInfo(files = depset([output_file]))

generate_config_h = rule(
    implementation = _generate_config_h_impl,
    attrs = {
        "_template_file": attr.label(allow_single_file = True, default = "//:include/open62541/config.h.in"),
        "output_path": attr.string(),
    },
)

def _generate_datatypes_impl(ctx):
    file_suffix = ctx.label.name + "_generated"
    #print(ctx.attr.prefix)
    #print("fs", file_suffix)
    #c_out = ctx.actions.declare_file(ctx.attr.prefix + "/" + file_suffix + ".c")
    #h_out = ctx.actions.declare_file(ctx.attr.prefix + "/" + file_suffix + ".h")

    c_file = ctx.actions.declare_file(ctx.attr.prefix + "/" + file_suffix + ".c")
    h_file = ctx.actions.declare_file(ctx.attr.prefix + "/" + file_suffix + ".h")
    handling_h_file = ctx.actions.declare_file(ctx.attr.prefix + "/" + file_suffix + "_handling.h")

    #if ctx.attr.gen_doc:
    #    doc_file = ctx.actions.declare_file("foo.rst")

    all_inputs = ctx.files.files_bsd + [ctx.file.file_csv]
    if ctx.file.files_selected:
        all_inputs += [ctx.file.files_selected]

    gen_args = ctx.actions.args()
    if not ctx.attr.builtin:
        gen_args.add("--no-builtin")

    #if ctx.attr.gen_doc:
    #    gen_args.add("--gen-doc")

    # --internal
    gen_args.add_all(ctx.files.files_bsd, format_each = "--type-bsd=%s")

    gen_args.add("--type-csv=%s" % ctx.file.file_csv.path)

    #gen_args.add(c_file.dirname + "/" + file_suffix)
    gen_args.add(c_file.dirname + "/" + ctx.label.name)  # wrong?

    #all_inputs = depset(ctx.files.files_bsd + [ctx.file.file_csv, ctx.file.files_selected])

    print(gen_args)
    ctx.actions.run(
        executable = ctx.executable._generate_datatypes,
        outputs = [c_file, h_file, handling_h_file],
        inputs = depset(all_inputs),
        arguments = [gen_args],
    )

    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )
    (compilation_context, compilation_outputs) = cc_common.compile(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        srcs = [c_file, ctx.file._statuscodes_src],
        public_hdrs = [h_file, handling_h_file, ctx.file._types_hdr, ctx.file._statuscodes_hdr],
        compilation_contexts = [ctx.attr._common_lib[CcInfo].compilation_context] + [dep[CcInfo].compilation_context for dep in ctx.attr.deps],
    )

    (linking_context, _linking_outputs) = cc_common.create_linking_context_from_compilation_outputs(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        compilation_outputs = compilation_outputs,
        linking_contexts = [ctx.attr._common_lib[CcInfo].linking_context] + [dep[CcInfo].linking_context for dep in ctx.attr.deps],
    )

    return [
        DefaultInfo(files = depset([c_file, h_file])),
        CcInfo(compilation_context = compilation_context, linking_context = linking_context),
    ]

generate_datatypes = rule(
    implementation = _generate_datatypes_impl,
    attrs = {
        "builtin": attr.bool(),
        "gen_doc": attr.bool(),
        # name is implicit
        "target_suffix": attr.string(),
        # namespace_idx isn't documented?
        "file_csv": attr.label(allow_single_file = True),
        "files_bsd": attr.label_list(allow_files = True),
        "files_selected": attr.label(allow_single_file = True),
        "prefix": attr.string(),
        #"deps": attr.label_list(providers = ["CcInfo"]),
        "deps": attr.label_list(),
        "_generate_datatypes": attr.label(executable = True, default = "//:generate_datatypes", cfg = "exec"),
        "_cc_toolchain": attr.label(default = "@bazel_tools//tools/cpp:current_cc_toolchain"),
        "_common_lib": attr.label(default = "//:common"),
        "_types_hdr": attr.label(allow_single_file = True, default = "//:include/open62541/types.h"),
        "_statuscodes_hdr": attr.label(allow_single_file = True, default = "//:include/open62541/statuscodes.h"),
        "_statuscodes_src": attr.label(allow_single_file = True, default = "//:include/open62541/statuscodes.c"),
    },
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
    fragments = ["cpp"],
)
