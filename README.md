Wilton [work in progress]
=========================

TODO: description

Link to the [JavaScript API documentation](https://wilton-iot.github.io/wilton/docs/html/namespaces.html).

How to build
------------

_Note: see [releases](https://github.com/wilton-iot/wilton/releases) for Windows binaries (MSI installer)_

Obtain sources and build tools:

    git clone --recursive https://github.com/wilton-iot/wilton.git

See platform-specific instructions below.

### Android

Run on Linux `x86_64`:

    cd wilton
    . resources/scripts/env-linux.sh
    mkdir build
    cd build
    cmake .. -DSTATICLIB_TOOLCHAIN=android_armeabi_gcc -DANDROID_SDK_ENABLE_LIBC_PRELOAD=OFF
    make android_apk

Resulting APK can be tested in VirtualBox using [Android x86](http://www.android-x86.org/) image with [native bridge](https://stackoverflow.com/a/13005569/314015) enabled.

### Windows

32-bit build:

    cd wilton
    resources\scripts\set-compile-env-vs12-sdk71a-x86.bat
    mkdir build
    cd build
    cmake ..
    nmake installer

64-bit build: TODO

### Fedora 27+

Install dependencies:

    sudo dnf install gcc-c++ make pkg-config zip zlib-devel jansson-devel log4cplus-devel openssl-devel curl-devel asio-devel popt-devel sqlite-devel postgresql-devel soci-devel soci-sqlite3-devel soci-postgresql-devel libharu-devel systemd-devel libusbx-devel webkitgtk4-jsc-devel

Build:

    cd wilton
    . resources/scripts/env-linux.sh
    mkdir build
    cd build
    cmake .. -DWILTON_BUILD_FLAVOUR=fedora
    make dist

### Ubuntu 16.04

Install dependencies:

    sudo apt install build-essential pkg-config zip zlib1g-dev libjansson-dev liblog4cplus-dev libssl-dev libcurl4-openssl-dev libasio-dev libpopt-dev libsqlite3-dev libpq-dev libsoci-dev libpng12-dev libusb-1.0-0-dev libudev-dev libglib2.0-dev libjavascriptcoregtk-4.0-dev

Build:

    cd wilton
    . resources/scripts/env-linux.sh
    mkdir build
    cd build
    cmake .. -DWILTON_BUILD_FLAVOUR=xenial
    make dist

### CentOS 7

Enable [EPEL repository](https://fedoraproject.org/wiki/EPEL):

    sudo yum install epel-release

Install dependencies:

    sudo yum install gcc-c++ make pkgconfig zip zlib-devel jansson-devel log4cplus-devel openssl-devel asio-devel popt-devel sqlite-devel postgresql-devel soci-devel soci-sqlite3-devel soci-postgresql-devel libpng-devel systemd-devel libusbx-devel webkitgtk3-devel

Build:

    cd wilton
    . resources/scripts/env-linux.sh
    mkdir build
    cd build
    cmake .. -DWILTON_BUILD_FLAVOUR=el7
    make dist

### Mac OS X

Install Xcode, Xcode Command Line Tools and Java (required for dist bundling).

Install build tools and dependencies:

    brew install cmake pkg-config openssl popt

Setup environment (adjust OpenSSL version as needed):

    export JAVA_HOME=path/to/jdk
    export PATH=$PATH:$JAVA_HOME/bin
    export PKG_CONFIG_PATH=/usr/local/Cellar/openssl/1.0.2m/lib/pkgconfig/:$PKG_CONFIG_PATH

Build:

    cd wilton
    mkdir build
    cd build
    cmake ..
    make dist

License information
-------------------

This project is released under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Changelog
---------

**2017-10-08**

 * build support for Ubuntu 16.04, Fedora 27 and CentOS 7
 * readme added
