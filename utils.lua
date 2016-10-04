-- utils.lua

function filterSystemFiles()
    filter { "system:not linux", "files:**posix.cc or files:posix/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not android", "files:**android.cc or files:android/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not macosx", "files:**mac.cc or files:mac/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not ios", "files:**ios.cc or files:ios/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not linux", "files:**nix.cc or files:nix/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not chromeos", "files:**chromeos.cc or files:chromeos/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not linux", "files:**linux.cc or files:linux/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not bsd", "files:**freebsd.cc or files:freebsd/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not bsd", "files:**openbsd.cc or files:openbsd/**" } 
        flags { "ExcludeFromBuild" }

    filter { "system:not nacl", "files:**nacl.cc or files:nacl/**" } 
        flags { "ExcludeFromBuild" }
end
