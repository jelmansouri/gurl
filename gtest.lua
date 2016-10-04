-- gtest.lua, projects:gtest, gtest_unittest

project "gtest"
    -- kind is used to indicate the type of this project.
    kind "StaticLib"

    -- We set the location of the files Premake will generate
    location "output/gtest"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    -- The library's public headers
    includedirs { "testing/gtest/include", "testing/gtest" }

    files { "testing/gtest/include/gtest/**.h", "testing/gtest/src/**.cc" }
    excludes { "testing/gtest/src/gtest_main.cc" }

    filter "files:testing/gtest/src/gtest-all.cc"
        flags { "ExcludeFromBuild" }


function useGTestLib()
    -- The library's public headers
    includedirs { "testing/gtest/include" }

    -- We link against a library that's in the same workspace, so we can just
    -- use the project name - premake is really smart and will handle everything for us.
    links "gtest"
end

project "gtest_main"
    -- kind is used to indicate the type of this project.
    kind "StaticLib"

    -- We set the location of the files Premake will generate
    location "output/gtest"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    useGTestLib()

    files {
		"testing/gtest/src/gtest_main.cc"
    }

project "gtest_unittest"
    kind "ConsoleApp"
    location "output/gtest"
    language "C++"
    targetname "gtest_all_test"
    targetdir "output/bin/%{cfg.buildcfg}"

    -- The library's public headers
    includedirs { "testing/gtest" }

    filter "action:vs201*"
        defines { 
            "GTEST_USE_OWN_TR1_TUPLE=0",
            "_SILENCE_STDEXT_HASH_DEPRECATION_WARNINGS"
        }
        buildoptions { "/bigobj" }

    useGTestLib()

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
		"testing/gtest/src/gtest_main.cc"
    }
