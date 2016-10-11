gurlProject("crypto", "StaticLib")
    
    useBaseLib()

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

gurlProject("cypto_unittest", "ConsoleApp")
    
    useBaseLib()

    files {
        "crypto/**unittest.h",
        "crypto/**unittest.cc",
    }

    filter {
        "options:not use-nss-certs",
        "files:crypto/scoped_test_nss_db.cc"
    }
        flags { "ExcludeFromBuild" }

    excludeSysFilesFromBuild()