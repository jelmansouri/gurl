gurlProject("crypto", "StaticLib")
    
    useBaseLib()
    useBoringSSL()

    files {
        "crypto/**.h",
        "crypto/**.cc",
        "crypto/**.cpp",
        "crypto/**.c",
        "crypto/**.mm"
    }

    excludes {  
        "crypto/**unittest.*",
        "crypto/**perftest.*",
        "crypto/scoped_test_system_nss_key_slot.cc",
        "crypto/scoped_test_nss_db.cc",
    }

    defines {
        "CRYPTO_IMPLEMENTATION",
    }

    filter { 
        "system:not macosx", "system:not ios",
        "files:crypto/mock_apple_keychain.cc"
     }
        flags { "ExcludeFromBuild" }

    filter {
        "system:not macosx",
        "files:crypto/cssm_init.cc or " ..
        "files:crypto/mac_security_services_lock"
    }
        flags { "ExcludeFromBuild" }

        
    filter {
        "system:not windows",
        "files:crypto/capi_util.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "options:not use-nss-certs",
        "files:crypto/nss_key_util.cc or " ..
        "files:crypto/nss_util.cc"
    }
        flags { "ExcludeFromBuild" }

    excludeSysFilesFromBuild()

    function useCryptoLib()
        addBoringSSLDefinesAndIncludes()
        useBaseLib()
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "crypto"
    end

gurlProject("cypto_unittest", "ConsoleApp")
    useGTestLib()
    useGmockLib()
    useBaseLib()
    useBaseTestLib()
    useCryptoLib()

    files {
        "crypto/**unittest.h",
        "crypto/**unittest.cc",
        "base/test/run_all_unittests.cc"
    }

    filter {
        "options:not use-nss-certs",
        "files:crypto/scoped_test_nss_db.cc or " ..
        "files:crypto/nss_util_unittest.cc or " ..
        "files:crypto/nss_key_util_unittest.cc" 
    }
        flags { "ExcludeFromBuild" }

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
    }