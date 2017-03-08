#!/bin/bash

pushd .

cd ..
if [ ! -d "chromium" ]; then
    echo "Directory chromium not found, cloning the repo"
    git clone https://chromium.googlesource.com/chromium/src chromium
fi
cd chromium
#git fetch origin
#git checkout master
#git merge origin/master

popd

function replace_dir() {
    echo "Replacing director ./$1 ../chromium/$1"
    rm -r ./$1
    cp -r ../chromium/$1 ./$1 
}

function replace_file() {
    echo "Replacing file ./$1 ../chromium/$1"
    cp ../chromium/$1 ./$1 
}


replace_file build/build_config.h
replace_file build/buildflag.h
replace_dir testing/perf
replace_file testing/gmock_mutant.h
replace_file testing/multiprocess_func_list.cc
replace_file testing/multiprocess_func_list.h
replace_file testing/platform_test.h
replace_file testing/platform_test_mac.mm
replace_dir third_party/boringssl
mkdir ./third_party/boringssl/src
replace_dir third_party/brotli
replace_dir third_party/ced
mkdir ./third_party/ced/src
replace_dir third_party/libxml
replace_dir third_party/modp_b64
replace_dir third_party/protobuf
#replace_dir third_party/sdch
replace_dir third_party/zlib
replace_dir url


#git submodule update --init --recursive