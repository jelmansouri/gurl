gurlProject("url", "StaticLib")
    useBaseLib()

    files {
        "url/**.h",
        "url/**.cc",
        "url/**.cpp",
        "url/**.c",
        "url/**.mm"
    }

    excludes {
        "url/mojo/**",
        "url/ipc/**",
        "url/**unittest.*",
        "url/**perftest.*",
        "url/run_all_unittests.cc",
    }

    defines {
        "URL_IMPLEMENTATION",
    }

    excludeSysFilesFromBuild()

    function useUrlLib()
        useBaseLib()
        -- We link against a library that's in the same workspace, so we can just
        -- use the project name - premake is really smart and will handle everything for us.
        links "url"
    end

gurlProject("url_unittest", "ConsoleApp")
    useGTestLib()
    useGmockLib()
    useBaseLib()
    useBaseTestLib()
    useUrlLib()

    files {
        "url/**unittest.h",
        "url/**unittest.cc",
        "base/test/run_all_unittests.cc"
    }

    excludes {
        "url/mojo/**",
        "url/ipc/**",
    }

    excludeSysFilesFromBuild()

    linkSystemLibs()