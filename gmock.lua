project "gmock"
    -- kind is used to indicate the type of this project.
    kind "StaticLib"

    -- We set the location of the files Premake will generate
    location "output/gmock"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    -- The library's public headers
    includedirs { "testing/gmock/include", "testing/gmock" }

    useGTestLib()

    files { "testing/gmock/include/gmock/**.h", "testing/gmock/src/**.cc" }
    excludes { "testing/gmock/src/gmock_main.cc" }

    filter "files:testing/gmock/src/gmock-all.cc"
        flags { "ExcludeFromBuild" }

    function addGMockDefinesAndIncludes()
        filter {}
        addGTestDefinesAndIncludes()
        includedirs { "testing/gmock/include" }
    end

    function useGmockLib()
        addGMockDefinesAndIncludes()
        links "gmock"
    end

project "gmock_unittest"
    kind "ConsoleApp"
    location "output/gmock_unittest"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    -- The library's public headers
    includedirs { "testing/gmock", "testing/gtest" }

    useGTestLib()
    useGmockLib()

    files {
        "testing/gmock/test/**.h",
        "testing/gmock/test/gmock-actions_test.cc",
        "testing/gmock/test/gmock-cardinalities_test.cc",
        "testing/gmock/test/gmock-generated-actions_test.cc",
        "testing/gmock/test/gmock-generated-function-mockers_test.cc",
        "testing/gmock/test/gmock-generated-internal-utils_test.cc",
        "testing/gmock/test/gmock-generated-matchers_test.cc",
        "testing/gmock/test/gmock-internal-utils_test.cc",
        -- "testing/gmock/test/gmock-matchers_test.cc",
        "testing/gmock/test/gmock-more-actions_test.cc",
        "testing/gmock/test/gmock-nice-strict_test.cc",
        "testing/gmock/test/gmock-port_test.cc",
        -- "testing/gmock/test/gmock-spec-builders_test.cc",
        "testing/gmock/test/gmock_test.cc",
		"testing/gmock/src/gmock_main.cc"
    }