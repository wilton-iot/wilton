Wilton [work in progress]
=========================

[![travis](https://travis-ci.org/wilton-iot/wilton.svg?branch=master)](https://travis-ci.org/wilton-iot/wilton)
[![appveyor](https://ci.appveyor.com/api/projects/status/github/wilton-iot/wilton?svg=true)](https://ci.appveyor.com/project/wilton-iot/wilton)
[![circle](https://circleci.com/gh/wilton-iot/wilton.svg?style=svg)](https://circleci.com/gh/wilton-iot/wilton)
[![cirrus](https://api.cirrus-ci.com/github/wilton-iot/wilton.svg)](https://cirrus-ci.com/github/wilton-iot/wilton)

TODO: description

Link to the [JavaScript API documentation](https://wilton-iot.github.io/wilton/docs/html/namespaces.html).

How to build
------------

_Note: see [releases](https://github.com/wilton-iot/wilton/releases) for pre-built binaries_

_Note: see [repo](https://copr.fedorainfracloud.org/coprs/wilton/wilton/) for CentOS 7 and Fedora RPM packages_

Get sources and build tools:

    git clone https://github.com/wilton-iot/wilton.git
    cd wilton
    git submodule update --init

Follow platform-specific instructions:

 - [Android](https://github.com/wilton-iot/wilton/wiki/BuildAndroid)
 - [Windows](https://github.com/wilton-iot/wilton/wiki/BuildWindows)
 - Linux:
   - [CentOS](https://github.com/wilton-iot/wilton/wiki/BuildCentOS)
   - [Debian](https://github.com/wilton-iot/wilton/wiki/BuildDebian)
   - [Fedora](https://github.com/wilton-iot/wilton/wiki/BuildFedora)
   - [Raspbian](https://github.com/wilton-iot/wilton/wiki/BuildRaspbian)
   - [Ubuntu](https://github.com/wilton-iot/wilton/wiki/BuildUbuntu)
 - [MacOS](https://github.com/wilton-iot/wilton/wiki/BuildMacOS)

License information
-------------------

This project is released under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Changelog
---------

**2019-07-24**

 * `v201907241`
 * `--new-project` option for generating projects boilerplate
 * automatic re-open of WebSocket connections for `backendcall`
 * Android enhancements

**2019-06-22**

 * `v201906221`
 * CRLF empty strings fix in `wilton/fs#readLines`
 * SSH by password support in `wilton/git`
 * 'pull' support in `wilton/git`
 * Android launcher app is fully functional
 * test-suite FS use cleanup (for clean Android runs)

**2019-05-12**

 * `v201905121`
 * Android launcher app (first version)
 * Raspbian file logging fix
 * MacOS native libs dep paths fix
 * `wilton/backendcall` responses fix

**2019-04-20**

 * `v201904201`
 * Raspbian Linux support including RaspberryPi Zero
 * `wilton/git` JS API over `libgit2`
 * `wilton/thread` capabilities support for `wiltoncall`s from JS
 * `wilton/kiosk` Windows support (requires `OpenJFX`)
 * `wilton/fs` support deleting read-only files on Windows
 * `wilton/cli` minor enhancements
 * support `JAVA_HOME` for `rhino` and `nashorn` engines
 * `wiltonw` "headful" launcher for Windows
 * handle registry shutdown behaviour fixes
 * `kiosk` GUI app example, refresh `vueapp` web app example

**2019-02-21**

 * `v201902211`
 * `PGConnection` fix
 * `wilton_process` and `wilton_cron` minor fixes
 * `lodash` updated to v4.17.11

**2019-02-02**

 * `v201902021`
 * `PGConnection` and `pwdauth` fixes
 * `OpenSSL` and `cURL` updates
 * CI setup enhancements

**2018-09-06**

 * `v201810281`
 * http file send with partial re-send support
 * inspector support in `wilton/kiosk`
 * `wilton/Server`, `PGConnection`, `wilton/usb` and `pwdauth` fixes

**2018-09-06**

 * `v201809061`
 * dedicated PostgreSQL connection API
 * sqlite crash fix and other DB fixes
 * Debian Stretch AArch64 support

**2018-07-19**

 * `v201807191`
 * serviceability JS API
 * USB connect fix on Windows
 * Ubuntu 18.04 support

**2018-06-24**

 * `v201806241`
 * WebSocket fix for Firefox
 * Windows CI releases setup

**2018-06-20**

 * `v201806201`
 * support for `v8`, `chakracore` and `mozjs` engines (only on Linux-x86_64)
 * WebSocket suport in `wilton/Server`
 * `witon/kiosk` desktop WebViews
 * Linux ARMv7 support
 * a number of JS modules added

**2018-04-08**

 * `v201804081`
 * support for `rhino` and `nashorn` engines in CLI launcher
 * support for pure-JS OpenJFX apps with Rhino engine

**2018-03-25**

 * `v201803251`
 * `Serial` and `USB` support on Windows
 * Fedora 28 builds
 * support for native modules in Rust and Haskell

**2018-03-11**

 * `v201803111`
 * CentOS 7 CI setup
 * debugging with Duktape engine from VSCode
 * native debuginfo bundles for all platforms
 * Chakra JS engine support on windows-x86_64
 * TCP and UDP sockets access from JS
 * native deps update
 * do not require Brew OpenSSL on Mac
 * `xml-js`, `uglify-js` and `es6-shim` JS libs

**2018-01-27**

 * `v201801271`
 * Jansson 2.10 usage fix on CentOS 7

**2018-01-25**

 * `v201801251`
 * more baud rate values for `wilton/Serial`
 * fix spawned process signals on Linux in `wilton/process`
 * update JSC to `webkitgtk-4.0` in CentOS 7

**2018-01-09**

 * `v201801091`
 * PNG images support in `wilton/PDFDocument`

**2017-12-05**

 * `v201712051`
 * `wilton/zip` implementation for ZIP files IO
 * some more JS modules added
 * all JS modules (except `bluebird` and `wilton/*` ) adapted for use in browser
 * `examples/browser` web-app example added

**2017-11-27**

 * `v201711271`
 * binary data (`hex` flag) support in `wilton/fs`
 * use `copyfile` syscall on MacOS for `wilton/fs.copyFile()`
 * about 20 new JS modules adapted from NPM

**2017-11-22**

 * `v201711221`
 * `filesize` JS module added
 * `appname` support in CLI launcher

**2017-11-15**

 * `v201711151`
 * shutdown fix on MacOS 
 * shutdown fix on Windows with JVM engines

**2017-11-07**

 * `v201711071`
 * Android, MacOS and Win64 builds

**2017-10-29**

 * `v201710291`
 * JavaScriptCore engine
 * logging added

**2017-10-21**

 * `v201710221`
 * move all possible logic from core to modules

**2017-10-13**
 
 * `v201710161`
 * better channel api
 * db logging
 * bootstrap example

**2017-10-13**

 * `v201710131`
 * usb and serial fixes
 * fs, logger and hex enhancements


**2017-10-08**

 * build support for Ubuntu 16.04, Fedora 27 and CentOS 7
 * readme added
