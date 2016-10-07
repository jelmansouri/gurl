project "icu"
    kind "StaticLib"
    location "output/third_party/icu"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    rtti "On"
    noExceptions()

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

    defines {
        "U_COMMON_IMPLEMENTATION",
        "U_I18N_IMPLEMENTATION",
        "HAVE_DLOPEN=0",
        -- Only build encoding coverters and detectors necessary for HTML5.
        "UCONFIG_ONLY_HTML_CONVERSION=1",
        -- No dependency on the default platform encoding.
        -- Will cut down the code size.
        "U_CHARSET_IS_UTF8=1",
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

    function addIcuDefinesAndIncludes()
        filter { }
        defines {
            "U_STATIC_IMPLEMENTATION",
            "U_USING_ICU_NAMESPACE=0",
            "U_ENABLE_DYLOAD=0",
            "U_NOEXCEPT=",
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
        filter { }

        includedirs { 
            "third_party/icu/source/i18n",
            "third_party/icu/source/common"
        }
    end

    addIcuDefinesAndIncludes()

    function useIcuLib()
        addIcuDefinesAndIncludes()
        links "icu"
    end

project "ced"
    kind "StaticLib"
    location "output/third_party/ced"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    rtti "Off"
    noExceptions()

    includedirs { "third_party/ced/src" }

    useGTestLib()

    files {
        "third_party/ced/src/**.h", 
        "third_party/ced/src/**.cc",
    }
    excludes {  
        "third_party/ced/src/**unittest.cc",
    }   

    filter { "system:windows" }
        defines { "COMPILER_MSVC"}
        disablewarnings {
            "4005", -- Macro redefinition.
            "4006", -- #undef expected an identifier.
            "4018", -- '<': signed/unsigned mismatch
            "4309", -- Truncation of constant value.
            "4838", -- Conversion from 'int' to 'char' requires a narrowing conversion
            "4267", -- conversion from 'size_t' to 'unsigned int', possible loss of data
            "4244", -- conversion from '__int64' to 'int', possible loss of data
            "4996", --  This function or variable may be unsafe. Consider using strncpy_s instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. See online help for details.

        }
        
    filter { "system:not windows" }
        defines { "COMPILER_GCC"}

    function addCedDefinesAndIncludes()
        filter {}
        includedirs { "third_party/ced/src" }
    end

    addCedDefinesAndIncludes()

    function useCedLib()
        addCedDefinesAndIncludes()
        links "ced"
    end

project "ced_unittest"
    kind "ConsoleApp"
    location "output/third_party/ced_unittest"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    rtti "Off"
    noExceptions()

    useCedLib()
    useGTestLib()
    useGTestMain()

    files {
        "third_party/ced/src/**unittest.h", 
        "third_party/ced/src/**unittest.cc",
    }

    filter { "system:windows" }
        defines { "COMPILER_MSVC"}
        disablewarnings {
            "4310", -- Truncation of constant value.
            "4267", -- size_t -> int
        }

    filter { "system:not windows" }
        defines { "COMPILER_GCC"}

project "modp_b64"
    kind "StaticLib"
    location "output/third_party/modp_b64"
    language "C++"
    targetdir "output/bin/%{cfg.buildcfg}"
    rtti "Off"
    noExceptions()

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

    function useModp_b64Lib()
        filter {}
        links "modp_b64"
    end