#!/bin/bash
#
# Copyright 2018, alex at staticlibs.net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
set -x

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then

    # tools
    git submodule update --init tools/maven
    mkdir tools/linux
    git clone https://github.com/wilton-iot/tools_linux_jdk8.git tools/linux/jdk8
    git clone --recursive https://github.com/wilton-iot/android-tools-ci-repo.git tools/android

    # env
    export PATH=`pwd`/tools/linux/jdk8/bin:$PATH
    export JAVA_HOME=`pwd`/tools/linux/jdk8
    export M2_HOME=`pwd`/tools/maven

    # build linux
    mkdir build
    pushd build
    cmake .. -DWILTON_BUILD_FLAVOUR=wheezy
    make
    # JSC is broken subtly on u1404
    # make test_js > test_js.log
    make test_duktape > test_duktape.log
    make test_chakracore > test_chakracore.log
    make test_mozjs > test_mozjs.log
    make test_v8 > test_v8.log
    make test_jvm > test_jvm.log
    make dist_linux_jre
    make test_rhino > test_rhino.log
    make test_nashorn > test_nashorn.log
    make valgrind
    popd

    # build android
    mv build build-linux
    mkdir build
    pushd build
    cmake .. -DSTATICLIB_TOOLCHAIN=android_armeabi_gcc
    cp ../build-linux/std.wlib .
    make
    make android_jar > android_jar.log
    make android_apk
fi

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    set +e
    mkdir /Users/travis/build/staticlibs
    mkdir build
    pushd build
    set -e
    cmake ..
    make
    # hangs on ci
    #make test_js > test_js.log
    make dist_unversioned
    ./wilton_dist/bin/wilton -m ../js ../js/wilton/test/index.js -j jsc
    make test_duktape > test_duktape.log
fi
