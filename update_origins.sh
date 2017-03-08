#!/bin/bash

function update_origin() {
    pushd .
    cd ..
    if [ ! -d $1 ]; then
        echo "Directory $1 not found, cloning the repo"
        git clone git@github.com:jelmansouri/$1
    fi
    cd $1
    if ! git remote | grep upstream > /dev/null; then
        echo "Adding upstream repository $2"
        git remote add upstream $2
    fi
    git fetch upstream
    git checkout master
    git merge upstream/master
    git push origin master
    popd
}

update_origin chromium-boringssl https://boringssl.googlesource.com/boringssl.git
update_origin chromium-ced https://chromium.googlesource.com/external/github.com/google/compact_enc_det
update_origin chromium-icu https://chromium.googlesource.com/chromium/deps/icu
update_origin chromium-gmock https://chromium.googlesource.com/external/googlemock
update_origin chromium-gtest https://chromium.googlesource.com/external/github.com/google/googletest
update_origin chromium-open-vcdiff  https://chromium.googlesource.com/external/github.com/google/open-vcdiff
update_origin chromium-yasm-binaries https://chromium.googlesource.com/chromium/deps/yasm/binaries
update_origin chromium-base https://chromium.googlesource.com/chromium/src/base
update_origin chromium-net https://chromium.googlesource.com/chromium/src/net
update_origin chromium-crypto https://chromium.googlesource.com/chromium/src/crypto
