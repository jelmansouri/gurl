-- premake5.lua

--inlcude "utils.lua"
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
            "DEBUG"
        }

    -- We now only set settings for Release
    filter { "configurations:Release" }
        -- Release should be optimized
        optimize "On"
        defines { 
            "NDEBUG",
        }
    
    filter { "system:windows" }
        defines {
            "NOMINMAX", 
            "_CRT_RAND_S",
            "WIN32_LEAN_AND_MEAN",
            -- _HAS_EXCEPTIONS must match ExceptionHandling in msvs_settings.
            "_HAS_EXCEPTIONS=0",
            -- Silence some warnings; we can't switch the the 'recommended'
            -- versions as they're not available on old OSs.
            "_WINSOCK_DEPRECATED_NO_WARNINGS",
            "NO_TCMALLOC",
        }
        disablewarnings { "4244" }

    -- Reset the filter for other settings
    filter { }

function filterSystemFiles()
    filter { "system:not linux", "files:base/**posix.cc or files:base/posix/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not android", "files:base/**android.cc or files:base/android/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not macosx", "files:base/**mac.cc or files:base/mac/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not ios", "files:base/**ios.cc or files:base/ios/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not linux", "files:base/**nix.cc or files:base/nix/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not chromeos", "files:base/**chromeos.cc or files:base/chromeos/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not linux", "files:base/**linux.cc or files:base/linux/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not bsd", "files:base/**freebsd.cc or files:base/freebsd/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not bsd", "files:base/**openbsd.cc or files:base/openbsd/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not nacl", "files:base/**nacl.cc or files:base/nacl/**" } 
        flags { "ExcludeFromBuild" }
end


include "gtest.lua"
include "gmock.lua"
include "third_party.lua"
include "base.lua"

