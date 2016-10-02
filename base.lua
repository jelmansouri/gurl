project "base"
    kind "StaticLib"
    location "output/base"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    -- The library's public headers
    includedirs { "./" }

    useGTestLib()
    useGmockLib()

    files { "base/**.h", "base/**.cc" }
    excludes { "base/test/**", "base/**unittest.cc", "base/third_party/**" }

    filterSystemFiles()
    
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