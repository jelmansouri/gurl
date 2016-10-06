
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