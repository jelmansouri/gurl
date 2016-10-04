project "icu"
    kind "StaticLib"
    location "output/third_party/icu"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    exceptionhandling "Off"
    rtti "On"

    -- The library's public headers
    includedirs { 
        "third_party/icu/source/i18n",
        "third_party/icu/source/common"
    }

    files {
        "third_party/icu/source/i18n/**.h", 
        "third_party/icu/source/i18n/**.cpp", 
        "third_party/icu/source/i18n/**.c", 
        "third_party/icu/source/common/**.h", 
        "third_party/icu/source/common/**.cpp", 
        "third_party/icu/source/common/**.c",
    }

    filter { "system:windows" }
        disablewarnings {
            "4005", -- Macro redefinition.
            "4068", -- Unknown pragmas.
            "4267", -- Conversion from size_t on 64-bits.
            "4996", -- Deprecated functions.
        }

    filter { "system:windows or options:icu-use-data-file" }
        files { "third_party/icu/source/stubdata/stubdata.c" }

    if not _OPTIONS["icu-use-data-file"] then
        os.copyfile("third_party/icu/common/icudtl.dat", "output/bin/%{cfg.buildcfg}/icudtl.dat")
    elseif _OS == "windows" then
        os.copyfile("third_party/icu/windows/icudt.dll", "output/bin/%{cfg.buildcfg}/icudt.dll")
    else
        -- todo(jelmansouri) support this case
    end

   -- Carefull here we changed the to the workspace scope 
    project "*"
        defines {
            "U_USING_ICU_NAMESPACE=0",
            "U_ENABLE_DYLOAD=0",
            "U_NOEXCEPT=",
            "U_STATIC_IMPLEMENTATION",
            "U_COMMON_IMPLEMENTATION",
            "U_I18N_IMPLEMENTATION"
        }
        filter { "system:windows or options:icu-use-data-file" }
            defines { "U_ICUDATAENTRY_IN_COMMON"}

        filter { "options:icu-use-data-file" }
            defines { "ICU_UTIL_DATA_IMPL=ICU_UTIL_DATA_FILE" }
        filter { "options:not icu-use-data-file", "system:windows" }
            defines { "ICU_UTIL_DATA_IMPL=ICU_UTIL_DATA_SHARED" }
        filter { "options:not icu-use-data-file", "system:not windows" }
            defines { "ICU_UTIL_DATA_IMPL=ICU_UTIL_DATA_STATIC" }
        -- Reset filters
        filter {}


project "ced"
    kind "StaticLib"
    location "output/third_party/ced"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    exceptionhandling "Off"
    rtti "Off"

    includedirs { "third_party/ced/src" }

    useGTestLib()

    files {
        "third_party/ced/src/**.h", 
        "third_party/ced/src/**.cc",
    }
    excludes {  
        "third_party/ced/src/**unittest.cc",
    }

    -- Carefull here we changed the to the workspace scope 
    project "*"
        filter { "system:windows" }
            defines { "COMPILER_MSVC"}
        
        filter { "system:not windows" }
            defines { "COMPILER_GCC"}

        -- Reset filters
        filter {}

project "modp_b64"
    kind "StaticLib"
    location "output/third_party/modp_b64"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    exceptionhandling "Off"
    rtti "Off"

    includedirs {
        ".", 
        "third_party/modp_b64"
    }

    files {
        "third_party/modp_b64/**.h", 
        "third_party/modp_b64/**.cc",
    }
    excludes {  
        "third_party/modp_b64/**unittest.cc",
    }