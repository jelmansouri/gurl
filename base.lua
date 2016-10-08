gurlProject("base", "StaticLib") 
    useGTestLib()
    useCedLib()
    useIcuLib()
    useModp_b64Lib()

    files {
        "base/**.h",
        "base/**.cc",
        "base/**.cpp",
        "base/**.c",
        "base/**.mm"
    }
    
    excludes { 
        "base/test/**", 
        "base/**unittest.*",
        "base/**perftest.*",
        "base/profiler/test_support_library.cc",
        "base/allocator/unittest_utils.cc",
        "base/check_example.cc",
        "base/i18n/build_utf8_validator_tables.cc",
        "base/third_party/dmg_fp/dtoa.cc"
    }

    defines {
        "BASE_IMPLEMENTATION",
        "BASE_I18N_IMPLEMENTATION"
    }

    excludeSysFilesFromBuild()

    filter {
        "system:windows", "configurations:Debug",
        "files:base/allocator/allocator_shim*.cc or " ..
        "files:base/allocator/winheap_stubs_win.cc",
    }
        flags { "ExcludeFromBuild" }

    filter {
        "system:windows", 
        "files:base/strings/string16.cc or " ..
        "files:base/message_loop/message_pump_libevent.cc or " ..
        "files:base/allocator/debugallocation_shim.cc or " ..
        "files:base/process/memory_stubs.cc or " ..
        "files:base/i18n/icu_util_nacl_win64.cc or " ..
        "files:base/files/file_path_watcher_stub.cc or " ..
        "files:base/third_party/libevent/** or " ..
        "files:base/third_party/symbolize/** or " ..
        "files:base/third_party/xdg_mime/**"
    } 
        flags { "ExcludeFromBuild" }

    filter {
        "system:not linux", 
        "files:base/linux_util.cc or files:base/message_loop/message_pump_glib.cc"
    } 
        flags { "ExcludeFromBuild" }

    filter { 
        "system:not macosx or system:not ios", 
        "files:base/files/file_path_watcher_fsevents.cc or files:base/files/file_path_watcher_kqueue.cc"
    } 
        flags { "ExcludeFromBuild" }
    
    filter { "system:windows" }
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

    function addBaseDefinesAndIncludes()
        addIcuDefinesAndIncludes()

        filter { "system:windows", "configurations:Release" }
            defines { 
                "ALLOCATOR_SHIM",
            }
        filter { }

        includedirs { "./" }
    end
    
    addBaseDefinesAndIncludes()

    function useBaseLib()
        addBaseDefinesAndIncludes()
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "base"
    end

gurlProject("base_test", "StaticLib")
    useGTestLib()
    useGmockLib()
    useBaseLib()
    useLibxml2()

    files {
        "base/test/**.h",
        "base/test/**.cc",
        "base/test/**.cpp",
        "base/test/**.c",
        "base/test/**.mm",
        "testing/perf/**.h",
        "testing/perf/**.cc",
    }
    
     excludes {  
        "base/**unittest.*",
        "base/**perftest.*",
     }

    excludeSysFilesFromBuild()
    
    filter { 
        "files:base/test/run_all_base_unittests.cc or " ..
        "files:base/test/run_all_unittests.cc or " ..
        "files:base/test/run_all_perftests.cc"
    }
        flags { "ExcludeFromBuild" }
    
    function useBaseTestLib()
        useBaseLib()
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "base_test"
    end

gurlProject("base_unittest", "ConsoleApp")
    useGTestLib()
    useGmockLib()
    useBaseLib()
    useBaseTestLib()

    files {
        "base/**unittest.h",
        "base/**unittest.cc",
        --"base/allocator/unittest_utils.cc",
        "base/test/run_all_unittests.cc",
    }

    filter {
        "system:windows",
        "files:base/message_loop/message_pump_libevent_unittest.cc or " ..
        "files:base/message_loop/message_pump_glib_unittest.cc",
    } 
        flags { "ExcludeFromBuild" }

    filter {
        "system:windows", "configurations:Debug",
        "files:base/allocator/allocator_shim_unittest.cc"
    }
        flags { "ExcludeFromBuild" }

    filter {
        "system:windows",
        "files:base/message_loop/message_pump_libevent_unittest.cc or " ..
        "files:base/message_loop/message_pump_glib_unittest.cc or " ..
        "files:base/allocator/tcmalloc_unittest.cc",
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

gurlProject("base_perftest", "ConsoleApp")
    useGTestLib()
    useGmockLib()
    useBaseLib()
    useBaseTestLib()

    files {
        "base/**perftest.h",
        "base/**perftest.cc",
        "base/test/run_all_perftests.cc",
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
    }
