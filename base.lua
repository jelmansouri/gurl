project "base"
    kind "StaticLib"
    location "output/base"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    exceptionhandling "Off"
    rtti "Off"

    includedirs { "." }

    useGTestLib()
    useGmockLib()
    
    useCedLib()
    useIcuLib()
    useModp_b64Lib()

    files { "base/**.h", "base/**.cc", "base/**.cpp", "base/**.c", "base/**.mm" }
    
    excludes { 
        "base/test/**", 
        "base/**unittest.cc",
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
        "system:windows", 
        "files:base/strings/string16.cc or " ..
        "files:base/message_loop/message_pump_libevent.cc or " ..
        "files:base/allocator/allocator_shim*.cc or " ..
        "files:base/allocator/winheap_stubs_win.cc or " ..
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
        
    function useBaseLib()
        -- The library's public headers
        addIcuDefinesAndIncludes()
        includedirs { "./" }
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "base"
    end

project "base_unittest"
    kind "ConsoleApp"
    location "output/base"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    -- The library's public headers
    includedirs { "./" }

    useGTestLib()
    useGmockLib()
    useBaseLib()

    files { "base/**unittest.h", "base/**unittest.cc" }
    
    filter {
        "system:windows",
        "files:base/message_loop/message_pump_libevent_unittest.cc",
        "files:base/message_loop/message_pump_glib_unittest.cc",
    } 
        flags { "ExcludeFromBuild" }

    excludeSysFilesFromBuild()