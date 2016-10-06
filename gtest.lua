-- gtest.lua, projects:gtest, gtest_unittest

project "gtest"
    -- kind is used to indicate the type of this project.
    kind "StaticLib"

    -- We set the location of the files Premake will generate
    location "output/gtest"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    rtti "Off"

    -- The library's public headers
    includedirs { "testing/gtest" }

    files { 
        "testing/gtest/include/gtest/**.h", 
        "testing/gtest/src/**.cc",
        "testing/multiprocess_func_list.cc",
        "testing/multiprocess_func_list.h",
    }
    excludes { "testing/gtest/src/gtest_main.cc" }

    filter "files:testing/gtest/src/gtest-all.cc"
        flags { "ExcludeFromBuild" }
    
    function addGTestDefinesAndIncludes()
        filter {}
        defines {
            "GTEST_HAS_POSIX_RE=0",
            "GTEST_LANG_CXX11=1",
            "UNIT_TEST",
        }
        includedirs { "testing/gtest/include" }
    end
    
    addGTestDefinesAndIncludes()

    function useGTestLib()
        addGTestDefinesAndIncludes()
        links "gtest"
    end

project "gtest_main"
    -- kind is used to indicate the type of this project.
    kind "StaticLib"

    -- We set the location of the files Premake will generate
    location "output/gtest"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    rtti "Off"

    useGTestLib()

    files {
		"testing/gtest/src/gtest_main.cc"
    }

    function useGTestMain()
        links "gtest_main"
    end

project "gtest_unittest"
    kind "ConsoleApp"
    location "output/gtest"
    language "C++"
    targetname "gtest_all_test"
    targetdir "output/bin/%{cfg.buildcfg}"
    rtti "Off"

    -- The library's public headers
    includedirs { "testing/gtest" }

    filter "action:vs201*"
        defines {
            "_SILENCE_STDEXT_HASH_DEPRECATION_WARNINGS"
        }
        buildoptions { "/bigobj" }

    useGTestLib()
    useGTestMain()

    files {
        "testing/gtest/test/**.h",
        "testing/gtest/test/gtest-filepath_test.cc",
        "testing/gtest/test/gtest-linked_ptr_test.cc",
        "testing/gtest/test/gtest-message_test.cc",
        "testing/gtest/test/gtest-options_test.cc",
        "testing/gtest/test/gtest-port_test.cc",
        "testing/gtest/test/gtest_pred_impl_unittest.cc",
        "testing/gtest/test/gtest_prod_test.cc",
        "testing/gtest/test/gtest-test-part_test.cc",
        "testing/gtest/test/gtest-typed-test_test.cc",
        "testing/gtest/test/gtest-typed-test2_test.cc",
        "testing/gtest/test/gtest_unittest.cc",
        "testing/gtest/test/production.cc",
    }
