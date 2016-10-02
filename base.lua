project "base"
    kind "StaticLib"
    location "output/base"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    files { "base/**.h", "base/**.cc" }
    excludes { "**unitest.cc", "**unitest.cc", "third_party/**" }
    files { "third_party/google/**.cc" }
    
    filter "files:**posix.cc"
        flags {"ExcludeFromBuild"}

    filter "files:**mac.cc"
        flags {"ExcludeFromBuild"}
    
    useGTestLib()

project "base_test"
    kind "ConsoleApp"
    location "output/base"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"

    files { "base/**unitest.h", "base/**unitest.cc" }
    
    filter "files:**posix_unitest.cc"
        flags {"ExcludeFromBuild"}

    filter "files:**posix_mac.cc"
        flags {"ExcludeFromBuild"}

    links "base"