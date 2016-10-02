project "gtest"
    kind "StaticLib"
    location "output/gtest"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    files { "testing/gtest/**.h", "testing/gtest/**.cc" }

    filter "configurations:Debug"
        defines { "DEBUG" }
        flags { "Symbols" }

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"