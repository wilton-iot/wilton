# Copyright 2017, alex at staticlibs.net
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
# toolchain for linux: https://github.com/staticlibs/android-ndk-r9d-arm-linux-androideabi-4.8

cmake_minimum_required ( VERSION 2.8.12 )

set ( CMAKE_BUILD_TYPE "Release" CACHE STRING "Default build type" )

set ( ANDROID_TOOLCHAIN_NAME arm-linux-androideabi CACHE INTERNAL "" )
set ( ANDROID_TOOLCHAIN_DIR "${WILTON_DIR}/tools/android/android-ndk-r9d-${ANDROID_TOOLCHAIN_NAME}-4.8" CACHE STRING "" )
set ( ANDROID_TOOLCHAIN_PREFIX ${ANDROID_TOOLCHAIN_DIR}/bin/${ANDROID_TOOLCHAIN_NAME} CACHE INTERNAL "" )
set ( ANDROID_GNUSTL_SHARED_PATH ${ANDROID_TOOLCHAIN_DIR}/${ANDROID_TOOLCHAIN_NAME}/lib/armv7-a/thumb )

set ( CMAKE_SYSTEM_NAME Generic )
set ( UNIX 1 CACHE INTERNAL "" )
set ( CMAKE_HOST arm-eabi-linux )
set ( CMAKE_SYSROOT ${ANDROID_TOOLCHAIN_DIR}/sysroot CACHE INTERNAL "" )
set ( CMAKE_C_COMPILER ${ANDROID_TOOLCHAIN_PREFIX}-gcc CACHE INTERNAL "" )
set ( CMAKE_CXX_COMPILER ${ANDROID_TOOLCHAIN_PREFIX}-g++ CACHE INTERNAL "" )

# CMAKE_C_FLAGS
set ( CMAKE_C_FLAGS_LIST
        -fPIC
        -DANDROID
        -mandroid
        --sysroot=${CMAKE_SYSROOT}
        -march=armv7-a
        -mthumb
        -mfloat-abi=softfp
        -mfpu=vfpv3-d16 )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS}  " )
string ( REPLACE ";" " " CMAKE_C_FLAGS "${CMAKE_C_FLAGS_LIST}" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE INTERNAL "" )

# CMAKE_C_FLAGS_DEBUG
set ( CMAKE_C_FLAGS_DEBUG_LIST
        -g
        -O0 )
string ( REPLACE ";" " " CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG_LIST}" )
set ( CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "" )

# CMAKE_C_FLAGS_RELEASE
set ( CMAKE_C_FLAGS_RELEASE_LIST
        -Os
        -DNDEBUG )
string ( REPLACE ";" " " CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE_LIST}" )
set ( CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "" )

# STATICLIB_CXX_STANDARD
if ( NOT DEFINED STATICLIB_CXX_STANDARD )
    set ( STATICLIB_CXX_STANDARD c++11 CACHE INTERNAL "" )
endif ( )

# CMAKE_CXX_FLAGS
set ( CMAKE_CXX_FLAGS_LIST
        --std=${STATICLIB_CXX_STANDARD}
        -fPIC
        -Wall
        -Werror
        -Wextra
        -fno-strict-overflow
        -fno-strict-aliasing
        -fstack-protector-all
        -Wlogical-op
        -DANDROID
        -mandroid
        -lgnustl_shared
        --sysroot=${CMAKE_SYSROOT}
        -march=armv7-a
        -mthumb
        -mfloat-abi=softfp
        -mfpu=vfpv3-d16
)
string ( REPLACE ";" " " CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS_LIST}" )
set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" CACHE INTERNAL "" )

# CMAKE_CXX_FLAGS_DEBUG
set ( CMAKE_CXX_FLAGS_DEBUG_LIST
        -g
        -O0 )
string ( REPLACE ";" " " CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG_LIST}" )
set ( CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}" CACHE INTERNAL "" )

# CMAKE_CXX_FLAGS_RELEASE
set ( CMAKE_CXX_FLAGS_RELEASE_LIST
        -Os
        -DNDEBUG )
string ( REPLACE ";" " " CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE_LIST}" )
set ( CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}" CACHE INTERNAL "" )

# CMAKE_EXE_LINKER_FLAGS_LIST
set ( CMAKE_EXE_LINKER_FLAGS_LIST
        -DANDROID
        -mandroid
        -march=armv7-a
        -mthumb
        -Wl,--fix-cortex-a8 )
string ( REPLACE ";" " " CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS_LIST}" )
set ( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" CACHE INTERNAL "" )

set ( CMAKE_AR ${ANDROID_TOOLCHAIN_PREFIX}-ar CACHE INTERNAL "" )
set ( CMAKE_AS ${ANDROID_TOOLCHAIN_PREFIX}-as CACHE INTERNAL "" )
set ( CMAKE_LD ${ANDROID_TOOLCHAIN_PREFIX}-ld CACHE INTERNAL "" )
set ( CMAKE_NM ${ANDROID_TOOLCHAIN_PREFIX}-nm CACHE INTERNAL "" )
set ( CMAKE_OBJCOPY ${ANDROID_TOOLCHAIN_PREFIX}-objcopy CACHE INTERNAL "" )
set ( CMAKE_OBJDUMP ${ANDROID_TOOLCHAIN_PREFIX}-objdump CACHE INTERNAL "" )
set ( CMAKE_RANLIB ${ANDROID_TOOLCHAIN_PREFIX}-ranlib CACHE INTERNAL "" )
set ( CMAKE_STRIP ${ANDROID_TOOLCHAIN_PREFIX}-strip CACHE INTERNAL "" )
