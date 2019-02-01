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

if [ "xwheezy" = "x${WILTON_BUILD_FLAVOUR}" ] ; then
    git clone --quiet https://github.com/wilton-iot/tools_linux_jdk8.git ../jdk8
    export JAVA_HOME=`pwd`/../jdk8
    git clone --quiet https://github.com/wilton-iot/tools_linux_cmake.git ../cmake
    export PATH=${JAVA_HOME}/bin:`pwd`/../cmake/bin:${PATH}
fi

if [ "xfedora" = "x${WILTON_BUILD_FLAVOUR}" ] ; then
    export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
fi

# build
mkdir build
pushd build
if [ "x" = "x${CIRCLE_TAG}" ] ;  then
    cmake .. -DWILTON_BUILD_FLAVOUR=${WILTON_BUILD_FLAVOUR}
else
    cmake .. -DWILTON_BUILD_FLAVOUR=${WILTON_BUILD_FLAVOUR} -DWILTON_RELEASE=${CIRCLE_TAG}
fi
make -j 2
make dist_debug > dist_debug.log

# test
make dist_unversioned > dist_unversioned.log

echo jsc
if [ "xfedora" = "x${WILTON_BUILD_FLAVOUR}" ] ; then
    ./wilton_dist/bin/wilton ../js/wilton/test/index.js -m ../js -j jsc
    ./wilton_dist/bin/wilton ../js/test-runners/runStdLibTests.js -m ../js -j jsc > jsc_stdlib.log
fi
./wilton_dist/bin/wilton ../js/test-runners/runSanityTests.js -m ./wilton_dist/std.min.wlib -j jsc

echo duktape
./wilton_dist/bin/wilton ../js/wilton/test/index.js -m ../js -j duktape
./wilton_dist/bin/wilton ../js/test-runners/runSanityTests.js -m ./wilton_dist/std.min.wlib -j duktape

echo chakracore
./wilton_dist/bin/wilton ../js/wilton/test/index.js -m ../js -j chakracore
./wilton_dist/bin/wilton ../js/test-runners/runSanityTests.js -m ./wilton_dist/std.min.wlib -j chakracore
./wilton_dist/bin/wilton ../js/test-runners/runStdLibTests.js -m ../js -j chakracore > chakracore_stdlib.log

echo mozjs
./wilton_dist/bin/wilton ../js/wilton/test/index.js -m ../js -j mozjs
./wilton_dist/bin/wilton ../js/test-runners/runSanityTests.js -m ./wilton_dist/std.min.wlib -j mozjs
if [ "xfedora" = "x${WILTON_BUILD_FLAVOUR}" ] ; then
    # intermittent out of memory
    ./wilton_dist/bin/wilton ../js/test-runners/runStdLibTests.js -m ../js -j mozjs > mozjs_stdlib.log || true
else
    ./wilton_dist/bin/wilton ../js/test-runners/runStdLibTests.js -m ../js -j mozjs > mozjs_stdlib.log
fi

echo v8
./wilton_dist/bin/wilton ../js/wilton/test/index.js -m ../js -j v8
./wilton_dist/bin/wilton ../js/test-runners/runSanityTests.js -m ./wilton_dist/std.min.wlib -j v8
./wilton_dist/bin/wilton ../js/test-runners/runStdLibTests.js -m ../js -j v8 > v8_stdlib.log

echo jvm
pushd ../jni
../tools/maven/bin/mvn --batch-mode clean test
popd

echo jre
ln -s ${JAVA_HOME}/jre ./wilton_dist/jre

export JAVA_TOOL_OPTIONS="-XX:MaxRAM=512M -XX:+UseSerialGC -XX:+TieredCompilation -XX:TieredStopAtLevel=1"

echo rhino
./wilton_dist/bin/wilton ../js/wilton/test/index.js -m ../js -j rhino
./wilton_dist/bin/wilton ../js/test-runners/runSanityTests.js -m ./wilton_dist/std.min.wlib -j rhino

echo nashorn
./wilton_dist/bin/wilton ../js/wilton/test/index.js -m ../js -j nashorn
./wilton_dist/bin/wilton ../js/test-runners/runSanityTests.js -m ./wilton_dist/std.min.wlib -j nashorn

echo valgrind
make valgrind

echo WILTON_FINISH_SUCCESS
