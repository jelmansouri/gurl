project "gmock"
    kind "StaticLib"
    location "output/gmock"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    files { "testing/gmock/**.h", "testing/gmock/**.cc" }

    filter "configurations:Debug"
        defines { "DEBUG" }
        flags { "Symbols" }

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"