-- premake5.lua

include "utils.lua"
include "options.lua"

workspace "gurl"

    -- We set the location of the files Premake will generate
    location "output"

    -- We indicate that all the projects are C++ only
    language "C++"

    -- We will compile for x86_64. You can change this to x86 for 32 bit builds.
    architecture "x86_64"

    -- Configurations are often used to store some compiler / linker settings together.
    -- The Debug configuration will be used by us while debugging.
    -- The optimized Release configuration will be used when shipping the app.
    configurations { "Debug", "Release" }

    -- We now only set settings for the Debug configuration
    filter { "configurations:Debug" }
        -- We want debug symbols in our debug config
        flags { "Symbols" }
        defines { 
            "DEBUG",
            "_DEBUG"
        }

    -- We now only set settings for Release
    filter { "configurations:Release" }
        -- Release should be optimized
        optimize "On"
        defines { 
            "NDEBUG",
        }

    -- Reset the filter for other settings
    filter { }


include "gtest.lua"
include "gmock.lua"
include "third_party.lua"
include "base.lua"
include "crypto.lua"
include "url.lua"
include "net.lua"