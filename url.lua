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