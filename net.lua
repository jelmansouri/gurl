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
        "net/**_fuzzer*",
        "net/**fuzzed*",
        "net/**fuzzing**",
        "net/spdy/spdy_deframer_visitor.*",
        "net/quic/core/congestion_control/send_algorithm_simulator.*",
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

gurlProject("net_extras", "StaticLib")
    useNetLib()

    files {
        "net/extras/**.h",
        "net/extras/**.cc",
    }
    excludeSysFilesFromBuild()


gurlProject("net_http_server", "StaticLib")
    useNetLib()

    files {
        "net/server/**.h",
        "net/server/**.cc",
    }
    excludeSysFilesFromBuild()

gurlProject("net_unittest", "ConsoleApp")
    useGTestLib()
    useGmockLib()
    useBaseTestLib()
    useNetLib()

    files {
        "net/**unittest.h",
        "net/**unittest.cc",
        "base/test/run_all_unittests.cc"
    }

    excludeSysFilesFromBuild()

    links {
        "cfgmgr32",
        "powrprof",
        "setupapi",
        "userenv",
        "winmm",
        "advapi32",
        "comdlg32",
        "dbghelp",
        "delayimp",
        "dnsapi",
        "gdi32",
        "kernel32",
        "msimg32",
        "ole32",
        "oleaut32",
        "psapi",
        "shell32",
        "shlwapi",
        "user32",
        "usp10",
        "uuid",
        "version",
        "wininet",
        "winmm",
        "winspool",
        "ws2_32",
        "crypt32",
        "dhcpcsvc",
        "iphlpapi",
        "ncrypt",
        "rpcrt4",
        "secur32",
        "urlmon",
        "winhttp",
    }