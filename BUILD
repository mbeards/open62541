load("//:build_defs.bzl", "generate_config_h", "generate_datatypes", "generate_nodeset")

cc_library(
    name = "open62541",
    srcs = [
        # Main Library
        #${PROJECT_BINARY_DIR}/src_generated/open62541/transport_generated.h
        "src/ua_types_encoding_binary.h",
        "src/util/ua_util_internal.h",
        "src/ua_securechannel.h",
        "src/server/ua_session.h",
        "src/server/ua_subscription.h",
        "plugins/ua_log_stdout.c",
        "src/server/ua_discovery.h",
        "src/pubsub/ua_pubsub_networkmessage.h",
        "src/pubsub/ua_pubsub.h",
        "src/pubsub/ua_pubsub_ns0.h",
        "src/pubsub/ua_pubsub_keystorage.h",
        "src/server/ua_services.h",
        "src/server/ua_server_async.h",
        "src/server/ua_server_internal.h",
        "src/client/ua_client_internal.h",
        "arch/clock.c",
    ] + [
        "src/ua_securechannel.c",
        "src/ua_securechannel_crypto.c",
        "src/ua_types.c",
        "src/ua_types_encoding_binary.c",
        "src/util/ua_util.c",
    ] + [
        # server
        "src/server/ua_session.c",
        "src/server/ua_discovery.c",
        "src/server/ua_nodes.c",
        "src/server/ua_server.c",
        "src/server/ua_server_ns0.c",
        "src/server/ua_server_ns0_diagnostics.c",
        "src/server/ua_server_config.c",
        "src/server/ua_server_binary.c",
        "src/server/ua_server_utils.c",
        "src/server/ua_server_async.c",
        "src/server/ua_services.c",
        "src/server/ua_services_view.c",
        "src/server/ua_services_method.c",
        "src/server/ua_services_session.c",
        "src/server/ua_services_attribute.c",
        "src/server/ua_services_discovery.c",
        "src/server/ua_subscription.c",
        "src/server/ua_subscription_eventfilter.c",
        "plugins/crypto/ua_securitypolicy_none.c",
        "plugins/crypto/ua_certificategroup_none.c",
        "src/server/ua_subscription_datachange.c",
        "src/server/ua_services_subscription.c",
        "src/server/ua_services_monitoreditem.c",
        "src/server/ua_services_securechannel.c",
        "src/server/ua_services_nodemanagement.c",
    ] + [
        # pubsub
        "src/pubsub/ua_pubsub_networkmessage.c",
        "src/pubsub/ua_pubsub_eventloop.c",
        "src/pubsub/ua_pubsub_connection.c",
        "src/pubsub/ua_pubsub_dataset.c",
        "src/pubsub/ua_pubsub_writer.c",
        "src/pubsub/ua_pubsub_writergroup.c",
        "src/pubsub/ua_pubsub_reader.c",
        "src/pubsub/ua_pubsub_readergroup.c",
        "src/pubsub/ua_pubsub_manager.c",
        "src/pubsub/ua_pubsub_ns0.c",
        "src/pubsub/ua_pubsub_keystorage.c",
        "src/pubsub/ua_pubsub_securitygroup.c",
        "src/pubsub/ua_pubsub_config.c",
    ] + [
        # client
        "src/client/ua_client.c",
        "src/client/ua_client_connect.c",
        "src/client/ua_client_discovery.c",
        "src/client/ua_client_highlevel.c",
        "src/client/ua_client_subscriptions.c",
    ] + [
        "plugins/include/open62541/plugin/create_certificate.h",
        ":include/open62541/statuscodes.c",
    ] + glob([
        "plugins/crypto/openssl/*.c",
        "plugins/crypto/openssl/*.h",
    ]),
    hdrs = [
        "include/open62541/common.h",
        "include/open62541/types.h",
        "include/open62541/plugin/log.h",
        "include/open62541/util.h",
        "include/open62541/plugin/accesscontrol.h",
        "include/open62541/plugin/certificategroup.h",
        "include/open62541/plugin/securitypolicy.h",
        "include/open62541/plugin/eventloop.h",
        "include/open62541/plugin/nodestore.h",
        "include/open62541/plugin/historydatabase.h",
        "plugins/include/open62541/client_config_default.h",
        "plugins/include/open62541/plugin/securitypolicy_default.h",
        "plugins/include/open62541/plugin/certificategroup_default.h",
        "include/open62541/server_pubsub.h",
        "include/open62541/pubsub.h",
        "include/open62541/client.h",
        "include/open62541/server.h",
        "include/open62541/client_highlevel.h",
        "include/open62541/client_subscriptions.h",
        "include/open62541/client_highlevel_async.h",
        ":config_h",
        ":namespace0",
        #":types",
        #":transport",
        #":include/open62541/nodeids.h",
        ":nodeid_header",
        ":include/open62541/statuscodes.h",
        "plugins/include/open62541/plugin/log_stdout.h",
    ],
    copts = [
        "-Isrc/util",
        "-Isrc/server",
        "-Isrc",
        "-Ideps",
        "-Isrc/pubsub",
        "-Iplugins/include",
        "-Wno-unused-variable",
        "-Wno-incompatible-pointer-types",  # type punning w/ boringssl?
    ],
    includes = ["include"],
    deps = [
        ":base64",
        ":cj5",
        ":dtoa",
        ":itoa",
        ":libc_time",
        ":mp_printf",
        ":open62541_queue",
        ":parse_num",
        ":pcg_basic",
        ":transport",
        ":types",
        ":ziptree",
        "@boringssl//:crypto",
    ],
)

cc_library(
    name = "ziptree",
    srcs = ["deps/ziptree.c"],
    hdrs = ["deps/ziptree.h"],
    includes = ["deps"],
)

cc_library(
    name = "pcg_basic",
    srcs = ["deps/pcg_basic.c"],
    hdrs = ["deps/pcg_basic.h"],
    includes = ["deps"],
)

cc_library(
    name = "libc_time",
    srcs = ["deps/libc_time.c"],
    hdrs = ["deps/libc_time.h"],
    includes = ["deps"],
)

cc_library(
    name = "parse_num",
    srcs = ["deps/parse_num.c"],
    hdrs = ["deps/parse_num.h"],
    includes = ["deps"],
)

cc_library(
    name = "base64",
    srcs = ["deps/base64.c"],
    hdrs = ["deps/base64.h"],
    includes = ["deps"],
    deps = [
        ":types",
    ],
)

cc_library(
    name = "cj5",
    srcs = ["deps/cj5.c"],
    hdrs = ["deps/cj5.h"],
    includes = ["deps"],
    deps = [
        ":parse_num",
    ],
)

cc_library(
    name = "dtoa",
    srcs = ["deps/dtoa.c"],
    hdrs = ["deps/dtoa.h"],
    includes = ["deps"],
)

cc_library(
    name = "itoa",
    srcs = ["deps/itoa.c"],
    hdrs = ["deps/itoa.h"],
    includes = ["deps"],
    deps = [":types"],
)

cc_library(
    name = "open62541_queue",
    hdrs = ["deps/open62541_queue.h"],
)

cc_library(
    name = "mp_printf",
    srcs = ["deps/mp_printf.c"],
    hdrs = ["deps/mp_printf.h"],
    includes = ["deps"],
    deps = [":dtoa"],
)

#"deps/mp_printf.h",

cc_library(
    name = "common",
    hdrs = [
        "include/open62541/common.h",
        ":config_h",
        ":include/open62541/nodeids.h",
    ],
    defines = ["HAVE_CONFIG_H"],
    includes = ["include"],
)

py_binary(
    name = "generate_nodeid_header",
    srcs = ["tools/generate_nodeid_header.py"],
)

#NAME "nodeids" ID_PREFIX "NS0" TARGET_SUFFIX "ids-ns0"
# UA_FILE_NODEIDS
genrule(
    name = "nodeid_header",
    srcs = ["tools/schema/NodeIds.csv"],
    outs = ["include/open62541/nodeids.h"],  # DO NOT SUBMIT
    cmd = "./$(location :generate_nodeid_header) $< $(RULEDIR)/include/open62541/nodeids NS0",
    tools = [":generate_nodeid_header"],
)

py_binary(
    name = "nodeset_compiler",
    #srcs = [
    #    "tools/nodeset_compiler/nodeset_compiler.py",
    #],
    srcs = glob(["tools/nodeset_compiler/*.py"]),
    imports = ["tools/nodeset_compiler"],
)

generate_nodeset(
    name = "namespace0",
    files = [
        # this is ordering dependent! ffs...
        "tools/schema/Opc.Ua.NodeSet2.Reduced.xml",  # is this one right? this was UA_FILE_NS0
        "tools/schema/Opc.Ua.NodeSet2.DiagnosticsMinimal.xml",
        "tools/schema/Opc.Ua.NodeSet2.EventsMinimal.xml",
        "tools/schema/Opc.Ua.NodeSet2.HistorizingMinimal.xml",
        "tools/schema/Opc.Ua.NodeSet2.PubSubMinimal.xml",
        "tools/schema/Opc.Ua.NodeSet2.Part8_Subset.xml",
        # oof there's a submodule involved here... Need to recheck
    ],
    # file ${UA_FILE_NODESETS}
    # blacklist ${UA_FILE_NS0_BLACKLIST} #mpty!
    # ignore ${PROJECT_SOURCE_DIR}/tools/nodeset_compiler/NodeID_NS0_Base.tx
    ignore = "tools/nodeset_compiler/NodeID_NS0_Base.txt",
    internal = True,
    prefix = "include/open62541",
    #
)

generate_config_h(
    name = "config_h",
    output_path = "include/open62541/config.h",
)

py_binary(
    name = "generate_datatypes",
    #srcs = ["tools/generate_datatypes.py"],

    # NO BUENO THIS IS A LIB!
    srcs = [
        "tools/generate_datatypes.py",
        "tools/nodeset_compiler/__init__.py",
        "tools/nodeset_compiler/backend_open62541_typedefinitions.py",
        "tools/nodeset_compiler/opaque_type_mapping.py",
        "tools/nodeset_compiler/type_parser.py",
    ],
    #srcs = glob(["tools/nodeset_compiler/*.py"]) + ["tools/generate_datatypes.py"],
    #imports = ["tools/nodeset_compiler"],
    imports = ["tools"],
    main = "tools/generate_datatypes.py",
)

generate_datatypes(
    name = "types",
    builtin = True,
    file_csv = "tools/schema/NodeIds.csv",
    files_bsd = ["tools/schema/Opc.Ua.Types.bsd"],
    gen_doc = True,
    prefix = "include/open62541",
    target_suffix = "types",
    #files_selected =  built with some complex per-feature stuff
    # NAMESPACE_IDX 0
)

generate_datatypes(
    name = "transport",
    builtin = True,
    file_csv = "tools/schema/NodeIds.csv",
    files_bsd = ["tools/schema/Custom.Opc.Ua.Transport.bsd"],
    # needs import!
    files_selected = "tools/schema/datatypes_transport.txt",
    gen_doc = True,
    prefix = "include/open62541",
    target_suffix = "transport",
    # NAMESPACE_IDX 1
    deps = [":types"],
)

py_binary(
    name = "generate_statuscode_descriptions",
    srcs = ["tools/generate_statuscode_descriptions.py"],
)

genrule(
    name = "statuscodes",
    srcs = ["tools/schema/StatusCode.csv"],
    outs = [
        "include/open62541/statuscodes.h",
        "include/open62541/statuscodes.c",
    ],
    cmd = "./$(location :generate_statuscode_descriptions) $< $(RULEDIR)/include/open62541/statuscodes",
    tools = [":generate_statuscode_descriptions"],
)

cc_test(
    name = "check_chunking",
    srcs = ["tests/check_chunking.c"],
    includes = [
        "deps",
        "src",
    ],
    deps = [
        ":open62541",
        "@libcheck//:check",
    ],
)

cc_test(
    name = "check_cj5",
    srcs = ["tests/check_cj5.c"],
    includes = [
        "deps",
        "src",
    ],
    deps = [
        ":cj5",
        ":types",
        "@libcheck//:check",
    ],
)

cc_library(
    name = "testing_clock",
    srcs = [
        "tests/testing-plugins/testing_clock.c",
    ],
    hdrs = [
        "tests/testing-plugins/testing_clock.h",
    ],
    includes = ["tests/testing-plugins"],
    deps = [
        ":open62541",
    ],
)

# probably needs to collapse into main lib
cc_library(
    name = "eventloop_posix",
    srcs = glob([
        "arch/eventloop_posix/*.c",
        "arch/eventloop_posix/*.h",
    ]) + [
        "arch/eventloop_common/eventloop_common.c",
        "arch/eventloop_common/eventloop_common.h",
        "arch/eventloop_common/timer.c",
        "arch/eventloop_common/timer.h",
    ],
    hdrs = ["include/open62541/plugin/eventloop.h"],
    deps = [
        ":common",
        ":open62541",
        ":types",
    ],
)

cc_test(
    name = "check_eventloop",
    srcs = [
        "tests/check_eventloop.c",
    ],
    includes = [
        "deps",
        "src",
    ],
    deps = [
        ":eventloop_posix",
        ":open62541",
        ":testing_clock",
        "@libcheck//:check",
    ],
)

cc_library(
    name = "log_stdout",
    srcs = [
    ],
    hdrs = [
    ],
    includes = ["plugins/include"],
    deps = [
        ":open62541",
        ":types",
    ],
)

cc_test(
    name = "check_eventloop_interrupt",
    srcs = [
        "tests/check_eventloop_interrupt.c",
    ],
    includes = [
        "deps",
        "src",
    ],
    deps = [
        ":eventloop_posix",
        ":log_stdout",
        ":open62541",
        ":testing_clock",
        "@libcheck//:check",
    ],
)

cc_test(
    name = "check_eventloop_tcp",
    srcs = [
        "tests/check_eventloop_tcp.c",
    ],
    includes = [
        "deps",
        "src",
    ],
    deps = [
        ":eventloop_posix",
        ":log_stdout",
        ":open62541",
        ":testing_clock",
        "@libcheck//:check",
    ],
)

cc_test(
    name = "check_eventloop_udp",
    srcs = [
        "tests/check_eventloop_udp.c",
    ],
    includes = [
        "deps",
        "src",
    ],
    deps = [
        ":eventloop_posix",
        ":log_stdout",
        ":open62541",
        ":testing_clock",
        "@libcheck//:check",
    ],
)

#cc_test(
#    name = "check_eventloop_eth",
#    srcs = [
#        "tests/check_eventloop_eth.c",
#    ],
#    includes = [
#        "deps",
#        "src",
#    ],
#    deps = [
#        ":eventloop_posix",
#        ":log_stdout",
#        ":open62541",
#        ":testing_clock",
#        "@libcheck//:check",
#    ],
#)

cc_test(
    name = "check_ziptree",
    srcs = ["tests/check_ziptree.c"],
    includes = ["deps"],
    deps = [
        ":ziptree",
        "@libcheck//:check",
    ],
)
