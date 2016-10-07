
function excludeSysFilesFromBuild()
    filter { 
        "system:not linux",
        "system:not android",
        "system:not macosx",
        "system:not openbsd",
        "system:not freebsd",
        "files:**_posix*.c* or files:**/posix/**"
    } 
        flags { "ExcludeFromBuild" }

    filter { 
        "system:not windows", 
        "files:**_win_.c* or files:**_win.c* or files:**/win/**"
    } 
        flags { "ExcludeFromBuild" }

    filter { 
        "system:not android", 
        "files:**_android*.c* or files:**/android/**"
    } 
        flags { "ExcludeFromBuild" }

    filter { 
        "system:not macosx",
        "files:**_mac_*.c* or files:**_mac.c* or files:**_mac_*.mm or files:**_mac.mm or files:**/mac/**"
    } 
        flags { "ExcludeFromBuild" }

    filter {
        "system:not ios",
        "files:**_ios_*.c* or files:**_ios.c* or files:**_ios_*.mm or files:**_ios.mm or files:**/ios/**"
    } 
        flags { "ExcludeFromBuild" }

    filter {
        "system:not ios",
        "system:not macosx",
        "files:**.mm"
    } 
        flags { "ExcludeFromBuild" }

    filter {
        "system:not linux",
        "system:not android",
        "system:not openbsd",
        "system:not freebsd",
        "files:**_nix*.c* or files:**/nix/**"
    } 
        flags { "ExcludeFromBuild" }


    filter {
        "system:not linux",
        "files:**_linux*.c* or files:**/linux/**"
    } 
        flags { "ExcludeFromBuild" }

    filter {
        "system:not freebsd",
        "files:**_freebsd*.c* or files:**/freebsd/**"
    } 
        flags { "ExcludeFromBuild" }

    filter { 
        "system:not openbsd",
        "files:**_openbsd*.c* or files:**/openbsd/**"
    } 
        flags { "ExcludeFromBuild" }

    filter {
        "system:not chromeos",
        "files:**_chromeos*.c* or files:**/chromeos/**"
    } 
        flags { "ExcludeFromBuild" }
        
    filter {
        "system:not nacl",
        "files:**_nacl*.c* or files:**/nacl/**"
    } 
        flags { "ExcludeFromBuild" }
end

function noExceptions()
    exceptionhandling "Off"
    filter { "system:windows" }
        defines { "_HAS_EXCEPTIONS=0" }
    filter { }
end

function gurlProject(name, pkind)
    project (name)
        kind (pkind)
        location ("output/" .. (name))
        language "C++"
        targetdir "output/bin/%{cfg.buildcfg}"
        rtti "Off"
        noExceptions()
    
        includedirs { "." }

        filter { "configurations:Debug" }
            defines {
                "DYNAMIC_ANNOTATIONS_ENABLED=1",
                "WTF_USE_DYNAMIC_ANNOTATIONS=1",
            }

        filter { "configurations:Release" }
            defines { 
                "NVALGRIND",
                "DYNAMIC_ANNOTATIONS_ENABLED=0",
            }

        filter { "system:linux" }
            defines {
                "_GLIBCXX_DEBUG=1",
            }

        filter { "system:windows" }
            defines {
                "NOMINMAX",
                "WIN32_LEAN_AND_MEAN",
                "_WINSOCK_DEPRECATED_NO_WARNINGS",
                "NO_TCMALLOC",
                "PSAPI_VERSION=1",
                "_CRT_RAND_S",
                "CERT_CHAIN_PARA_HAS_EXTRA_FIELDS",
                "WIN32",
                "_WINDOWS",
            }
            disablewarnings {
                -- C4091: 'typedef ': ignored on left of 'X' when no variable is
            --                    declared.
            -- This happens in a number of Windows headers. Dumb.
            "4091",

            -- C4127: conditional expression is constant
            -- This warning can in theory catch dead code and other problems, but
            -- triggers in far too many desirable cases where the conditional
            -- expression is either set by macros or corresponds some legitimate
            -- compile-time constant expression (due to constant template args,
            -- conditionals comparing the sizes of different types, etc.).  Some of
            -- these can be worked around, but it's not worth it.
            "4127",

            -- C4351: new behavior: elements of array 'array' will be default
            --        initialized
            -- This is a silly "warning" that basically just alerts you that the
            -- compiler is going to actually follow the language spec like it's
            -- supposed to, instead of not following it like old buggy versions
            -- did.  There's absolutely no reason to turn this on.
            "4351",

            -- C4355: 'this': used in base member initializer list
            -- It's commonly useful to pass |this| to objects in a class'
            -- initializer list.  While this warning can catch real bugs, most of
            -- the time the constructors in question don't attempt to call methods
            -- on the passed-in pointer (until later), and annotating every legit
            -- usage of this is simply more hassle than the warning is worth.
            "4355",

            -- C4503: 'identifier': decorated name length exceeded, name was
            --        truncated
            -- This only means that some long error messages might have truncated
            -- identifiers in the presence of lots of templates.  It has no effect
            -- on program correctness and there's no real reason to waste time
            -- trying to prevent it.
            "4503",

            -- Warning C4589 says: "Constructor of abstract class ignores
            -- initializer for virtual base class." Disable this warning because it
            -- is flaky in VS 2015 RTM. It triggers on compiler generated
            -- copy-constructors in some cases.
            "4589",

            -- C4611: interaction between 'function' and C++ object destruction is
            --        non-portable
            -- This warning is unavoidable when using e.g. setjmp/longjmp.  MSDN
            -- suggests using exceptions instead of setjmp/longjmp for C++, but
            -- Chromium code compiles without exception support.  We therefore have
            -- to use setjmp/longjmp for e.g. JPEG decode error handling, which
            -- means we have to turn off this warning (and be careful about how
            -- object destruction happens in such cases).
            "4611",

            -- TODO(maruel): These warnings are level 4. They will be slowly
            -- removed as code is fixed.
            "4100", -- Unreferenced formal parameter
            "4121", -- Alignment of a member was sensitive to packing
            "4244", -- Conversion from 'type1' to 'type2', possible loss of data
            "4505", -- Unreferenced local function has been removed
            "4510", -- Default constructor could not be generated
            "4512", -- Assignment operator could not be generated
            "4610", -- Object can never be instantiated
            "4838", -- Narrowing conversion. Doesn't seem to be very useful.
            "4995", -- 'X': name was marked as --pragma deprecated
            "4996", -- 'X': was declared deprecated (for GetVersionEx).

            -- These are variable shadowing warnings that are new in VS2015. We
            -- should work through these at some point -- they may be removed from
            -- the RTM release in the /W4 set.
            "4456", "4457", "4458", "4459",

            -- TODO(brucedawson): http://crbug.com/554200 4312 is a VS
            -- 2015 64-bit warning for integer to larger pointer
            "4312",

            -- TODO(brucedawson): http://crbug.com/593448 - C4595 is an 'illegal
            -- inline operator new' warning that is new in VS 2015 Update 2.
            -- This is equivalent to clang's no-inline-new-delete warning.
            -- See http://bugs.icu-project.org/trac/ticket/11122
            "4595",
            -- conversion from 'size_t' to 'int32_t', possible loss of data
            "4267",
        }
        filter { }
end