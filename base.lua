project "base"
    kind "StaticLib"
    location "output/base"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    exceptionhandling "Off"

    -- The library's public headers
    includedirs { 
        ".", 
        "third_party/icu/source/i18n",
        "third_party/icu/source/common",
        "third_party/ced/src"
    }

    useGTestLib()
    useGmockLib()

    files { "base/**.h", "base/**.cc", "base/**.cpp", "base/**.c" }
    
    excludes { 
        "base/test/**", 
        "base/**unittest.cc",
        "base/profiler/test_support_library.cc",
        "base/allocator/unittest_utils.cc",
        "base/check_example.cc",
        "base/i18n/build_utf8_validator_tables.cc",
        "base/third_party/dmg_fp/dtoa.cc"
    }

    filterSystemFiles()

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
    includedirs { "./" }

    -- We link against a library that's in the same workspace, so we can just
    -- use the project name - premake is really smart and will handle everything for us.
    links "base"
end

project "base_test"
    kind "ConsoleApp"
    location "output/base"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    -- The library's public headers
    includedirs { "./" }

    useGTestLib()
    useGmockLib()

    files { "base/**unittest.h", "base/**unittest.cc" }
    
    filterSystemFiles()

    links "base"