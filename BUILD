load("//:build_defs.bzl", "generate_nodeset")

cc_library(
    name = "open62541",
    srcs = [
        # Main Library
        #${PROJECT_BINARY_DIR}/src_generated/open62541/transport_generated.h
        "deps/open62541_queue.h",
        "deps/pcg_basic.h",
        "deps/libc_time.h",
        "deps/base64.h",
        "deps/dtoa.h",
        "deps/mp_printf.h",
        "deps/itoa.h",
        "deps/ziptree.h",
        "src/ua_types_encoding_binary.h",
        "src/util/ua_util_internal.h",
        "src/ua_securechannel.h",
        "src/server/ua_session.h",
        "src/server/ua_subscription.h",
        "src/pubsub/ua_pubsub_networkmessage.h",
        "src/pubsub/ua_pubsub.h",
        "src/pubsub/ua_pubsub_ns0.h",
        "src/pubsub/ua_pubsub_keystorage.h",
        "src/server/ua_services.h",
        "src/server/ua_server_async.h",
        "src/server/ua_server_internal.h",
        "src/client/ua_client_internal.h",
    ] + [
        #${PROJECT_BINARY_DIR}/src_generated/open62541/types_generated.c
        #${PROJECT_BINARY_DIR}/src_generated/open62541/transport_generated.c
        #${PROJECT_BINARY_DIR}/src_generated/open62541/statuscodes.c
        "src/ua_types.c",
        "src/ua_types_encoding_binary.c",
        "src/util/ua_util.c",
        "src/ua_securechannel.c",
        "src/ua_securechannel_crypto.c",
    ] + [
        # server
        "src/server/ua_session.c",
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
        # dependencies
        "deps/libc_time.c",
        "deps/pcg_basic.c",
        "deps/base64.c",
        "deps/dtoa.c",
        "deps/mp_printf.c",
        "deps/itoa.c",
        "deps/ziptree.c",
    ],
    hdrs = [
        #${PROJECT_BINARY_DIR}/src_generated/open62541/config.h
        #${PROJECT_BINARY_DIR}/src_generated/open62541/statuscodes.h
        #${PROJECT_BINARY_DIR}/src_generated/open62541/nodeids.h
        #${PROJECT_BINARY_DIR}/src_generated/open62541/types_generated.h
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
        "include/open62541/server_pubsub.h",
        "include/open62541/pubsub.h",
        "include/open62541/client.h",
        "include/open62541/server.h",
        "include/open62541/client_highlevel.h",
        "include/open62541/client_subscriptions.h",
        "include/open62541/client_highlevel_async.h",
    ],
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
    outs = ["nodeids.h"],  # DO NOT SUBMIT
    cmd = "./$(location :generate_nodeid_header) $< $(RULEDIR)/nodeids NS0",
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
    name = "gen_ns0",
    files = [
        #"tools/schema/Opc.Ua.NodeSet2.DiagnosticsMinimal.xml",
        #"tools/schema/Opc.Ua.NodeSet2.EventsMinimal.xml",
        #"tools/schema/Opc.Ua.NodeSet2.HistorizingMinimal.xml",
        "tools/schema/Opc.Ua.NodeSet2.PubSubMinimal.xml",
        #"tools/schema/Opc.Ua.NodeSet2.Part8_Subset.xml",
        # oof there's a submodule involved here... Need to recheck
        #"tools/schema/Opc.Ua.NodeSet2.Reduced.xml",  # is this one right? this was UA_FILE_NS0
    ],
    # file ${UA_FILE_NODESETS}
    # blacklist ${UA_FILE_NS0_BLACKLIST} #mpty!
    # ignore ${PROJECT_SOURCE_DIR}/tools/nodeset_compiler/NodeID_NS0_Base.tx
    ignore = "tools/nodeset_compiler/NodeID_NS0_Base.txt",
    internal = True,
    #
)
