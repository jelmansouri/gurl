gurlProject("net", "StaticLib")
    useBaseLib()
    useCryptoLib()
    useUrlLib()
    useProtobufLiteLib()
    useSdch()

    files {
        "net/**.h",
        "net/**.cc",
        "net/**.cpp",
        "net/**.c",
        "net/**.mm"
    }

    excludes {
        "net/**unittest.*",
        "net/**perftest.*",
        "net/**_test*",
        "net/**test_*",
        "net/**mock_*",
        "net/**_mock*",
        "net/test/**",
        "net/**fuzzer*",
        "net/**fuzzed*",
        "net/**fuzzing**",
        "net/spdy/spdy_deframer_visitor.*",
        "net/quic/core/congestion_control/send_algorithm_simulator.*",
        "net/quic/core/congestion_control/simulation/**",
        "net/base/stale_while_revalidate_experiment_domains.*",
        "net/quic/test_tools/**",
        "net/ssl/ssl_platform_key_chromecast.cc",
        "net/server/**",
        "net/proxy/*_v8*",
        "net/dns/*mojo*",
        "net/proxy/*mojo*",
        "net/tools/**",
        "net/extras/**",
        "net/quic/core/crypto/common_cert_set_*.c",
    }

    defines {
        "DLOPEN_KERBEROS",
        "NET_IMPLEMENTATION",
        "ENABLE_BUILT_IN_DNS",
    }

    filter {
        "files:net/**-inc.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "options:not use-openssl-certs", 
        "files:net/base/crypto_module_openssl.cc or " .. 
        "files:net/base/keygen_handler_openssl.cc or " ..
        "files:net/base/openssl_private_key_store_memory.cc or " ..
        "files:net/cert/cert_database_openssl.cc or " ..
        "files:net/cert/cert_verify_proc_openssl.cc or " ..
        "files:net/cert/test_root_certs_openssl.cc or " ..
        "files:net/cert/x509_certificate_openssl.cc or " ..
        "files:net/ssl/openssl_client_key_store.cc",
    }
        flags { "ExcludeFromBuild" }
    
    filter {
        "options:not use-nss-certs",
        "files:net/**nss_* or " ..
        "files:net/**_nss* or " ..
        "files:net/third_party/mozilla_security_manager/** or " ..
        "files:net/ssl/client_key_store.cc or " ..
        "files:net/ssl/ssl_platform_key_nss.cc or " ..
        "files:net/third_party/nss/ssl/*"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "options:not use-brotli", 
        "files:net/filter/brotli_filter.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "options:use-brotli", 
        "files:net/filter/brotli_filter_disabled.cc"
    }
        flags { "ExcludeFromBuild" }

    filter { 
        "options:not enable-net-file-support",

    }

    filter {
        "system:windows",
        "files:net/http/http_auth_handler_ntlm_portable.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "system:not enable-net-file-support",
        "files:net/base/directory_lister.cc or " ..
        "files:net/base/directory_listing.cc or " ..
        "files:net/url_request/file_protocol_handler.cc or " ..
        "files:net/url_request/url_request_file_dir_job.cc or " ..
        "files:net/url_request/url_request_file_job.cc",
    }
        flags { "ExcludeFromBuild" }

    excludeSysFilesFromBuild()

    function addNetDefinesAndIncludes()
        filter { }

        defines {
            "ENABLE_WEBSOCKETS",
        }
        filter { "options:not enable-net-file-support" }
            defines { "DISABLE_FILE_SUPPORT" }

        filter { }

        includedirs { "./" }
    end

    addNetDefinesAndIncludes()

    function useNetLib()
        addNetDefinesAndIncludes()

        useBaseLib()
        useCryptoLib()
        useUrlLib()
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "net"
    end

gurlProject("net_test", "StaticLib")
    useGTestLib()
    useGmockLib()
    useNetLib()
    useProtobufLiteLib()
    useBaseTestLib()

    files {
        "net/**test_*.h",
        "net/**test_*.cc",
        "net/**mock_*.h",
        "net/**mock_*.cc",
        "net/**_mock*.h",
        "net/**_mock*.cc",
        "net/test/**.h",
        "net/test/**.cc",
        "net/cookies/**_test.h",
        "net/cookies/**_test.cc",
        "net/quic/test_tools/**",
        "net/base/stale_while_revalidate_experiment_domains.*",
        "net/spdy/spdy_deframer_visitor.*",
    }

    excludes {
        "net/**unittest.*",
        "net/**perftest.*",
        "net/server/**",
        "net/proxy/*_v8*",
        "net/dns/*mojo*",
        "net/proxy/*mojo*",
        "net/tools/**",
        "net/extras/**",
        "net/**fuzzer*",
        "net/**fuzzed*",
        "net/**fuzzing**",
        "net/test/run_all_unittests.cc",
        "net/quic/test_tools/**_test.cc",
        "net/quic/core/congestion_control/simulation/**",
    }

    files {
        "net/tools/quic/test_tools/mock_quic_server_session_visitor.*",
        "net/tools/quic/test_tools/quic_in_memory_cache_peer.*",
        "net/tools/quic/chlo_extractor.cc",
        "net/tools/quic/chlo_extractor.h",
        "net/tools/quic/quic_client_base.cc",
        "net/tools/quic/quic_client_base.h",
        "net/tools/quic/quic_client_session.cc",
        "net/tools/quic/quic_client_session.h",
        "net/tools/quic/quic_dispatcher.cc",
        "net/tools/quic/quic_dispatcher.h",
        "net/tools/quic/quic_in_memory_cache.cc",
        "net/tools/quic/quic_in_memory_cache.h",
        "net/tools/quic/quic_per_connection_packet_writer.cc",
        "net/tools/quic/quic_per_connection_packet_writer.h",
        "net/tools/quic/quic_process_packet_interface.h",
        "net/tools/quic/quic_simple_client.cc",
        "net/tools/quic/quic_simple_client.h",
        "net/tools/quic/quic_simple_crypto_server_stream_helper.cc",
        "net/tools/quic/quic_simple_crypto_server_stream_helper.h",
        "net/tools/quic/quic_simple_dispatcher.cc",
        "net/tools/quic/quic_simple_dispatcher.h",
        "net/tools/quic/quic_simple_per_connection_packet_writer.cc",
        "net/tools/quic/quic_simple_per_connection_packet_writer.h",
        "net/tools/quic/quic_simple_server.cc",
        "net/tools/quic/quic_simple_server.h",
        "net/tools/quic/quic_simple_server_packet_writer.cc",
        "net/tools/quic/quic_simple_server_packet_writer.h",
        "net/tools/quic/quic_simple_server_session.cc",
        "net/tools/quic/quic_simple_server_session.h",
        "net/tools/quic/quic_simple_server_session_helper.cc",
        "net/tools/quic/quic_simple_server_session_helper.h",
        "net/tools/quic/quic_simple_server_stream.cc",
        "net/tools/quic/quic_simple_server_stream.h",
        "net/tools/quic/quic_spdy_client_stream.cc",
        "net/tools/quic/quic_spdy_client_stream.h",
        "net/tools/quic/quic_time_wait_list_manager.cc",
        "net/tools/quic/quic_time_wait_list_manager.h",
        "net/tools/quic/stateless_rejector.cc",
        "net/tools/quic/stateless_rejector.h",
        "net/tools/quic/synchronous_host_resolver.cc",
        "net/tools/quic/synchronous_host_resolver.h",
    }

    filter {
        "files:net/**-inc.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "options:not use-openssl-certs",
        "files:net/cert/test_root_certs_openssl.cc or " .. 
        "files:net/test/cert_test_util_nss.cc"
    }
        flags { "ExcludeFromBuild" }
    
    filter {
        "options:not use-nss-certs",
        "files:net/cert/test_root_certs_nss.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "options:not android",
        "files:net/test/spawned_test_server/remote_test_server.cc or " ..
        "files:net/test/spawned_test_server/spawner_communicator.cc"
    }
        flags { "ExcludeFromBuild" }

    excludeSysFilesFromBuild()

    function useNetTestLib()
        useGTestLib()
        useGmockLib()
        useBaseLib()
        useBaseTestLib()
        useCryptoLib()
        useNetLib()
        useProtobufLiteLib()
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "net_test"
    end


gurlProject("net_extras", "StaticLib")
    useNetLib()

    files {
        "net/extras/**.h",
        "net/extras/**.cc",
    }

    excludes {
        "net/**unittest.*",
        "net/**perftest.*",
    }

    excludeSysFilesFromBuild()

gurlProject("net_http_server", "StaticLib")
    useNetLib()

    files {
        "net/server/**.h",
        "net/server/**.cc",
    }

    excludes {
        "net/**unittest.*",
        "net/**perftest.*",
    }

    excludeSysFilesFromBuild()

    function useNetHttpServerLib()
        useNetLib()
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "net_http_server"
    end

gurlProject("net_unittest", "ConsoleApp")
    useNetTestLib()
    useNetHttpServerLib()
    useUrlLib()

    files {
        "net/**unittest.h",
        "net/**unittest.cc",
        "net/**_test.h",
        "net/**_test.cc",
        "net/server/*unitest.cc",
        "net/test/run_all_unittests.cc"
    }

    excludes {
        "net/cookies/**_test.h",
        "net/cookies/**_test.cc",
        "net/proxy/*_v8*",
        "net/dns/*mojo*",
        "net/proxy/*mojo*",
        "net/tools/**",
        "net/extras/**",
        "net/**fuzzer*",
        "net/**fuzzed*",
        "net/**fuzzing**",
        "net/quic/core/quic_client_promised_info_test.cc",
        "net/quic/core/congestion_control/simulation/**",
    }

    filter {
        "files:net/**-inc.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "options:not use-openssl-certs",
        "files:net/ssl/openssl_client_key_store_unittest.cc",
    }
        flags { "ExcludeFromBuild" }
    
    filter {
        "options:not use-nss-certs",
        "files:net/**nss_* or " ..
        "files:net/**_nss* or " ..
        "files:net/third_party/mozilla_security_manager/** or " ..
        "files:net/third_party/nss/ssl/*"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "system:not enable-net-file-support",
        "files:net/base/directory_lister_unittest.cc or " ..
        "files:net/base/directory_listing_unittest.cc or " ..
        "files:net/url_request/url_request_file_dir_job_unittest.cc or " ..
        "files:net/url_request/url_request_file_job_unittest.cc",
    }
        flags { "ExcludeFromBuild" }

    excludeSysFilesFromBuild()

    linkSystemLibs()
    linkSystemNetLibs()