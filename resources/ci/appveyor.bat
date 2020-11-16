@echo off
rem Copyright 2018, alex at staticlibs.net
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.

@echo on

rem shortcuts from script directory
set BAD_SLASH_SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%BAD_SLASH_SCRIPT_DIR:\=/%
set WILTON_DIR=%SCRIPT_DIR%../..

rem env
call ..\tools\env.bat

rem build
mkdir build || exit /b 1
pushd build || exit /b 1
if "x" NEQ "x%APPVEYOR_REPO_TAG_NAME%" (
    cmake .. -G "Visual Studio 12 2013 Win64" -DWILTON_RELEASE=%APPVEYOR_REPO_TAG_NAME% || exit /b 1
) else (
    cmake .. -G "Visual Studio 12 2013 Win64" || exit /b 1
)
cmake --build . --config Release
if errorlevel 1 (
    echo msbuild error, target: build
    exit /b 1
)
cmake --build . --config Release --target installer > installer.log
if errorlevel 1 (
    echo error, target: installer
    exit /b 1
)

rem test
echo dist_unversioned
cmake --build . --config Release --target dist_unversioned > dist_unversioned.log

echo quickjs
wilton_dist\bin\wilton.exe ../js/wilton/test/index.js -m ../js || exit /b 1
rem exit code is non-zero for some reason
wilton_dist\bin\wilton.exe ../js/wilton/test/esm/index.js -m ../js || echo ES_FAIL
wilton_dist\bin\wilton.exe ../js/test-runners/runSanityTests.js || exit /b 1
wilton_dist\bin\wilton.exe ../js/test-runners/runEsSanityTests.js || exit /b 1
wilton_dist\bin\wilton.exe ../js/test-runners/runStdLibTests.js -m ../js > quickjs_stdlib.log
if errorlevel 1 (
    echo error: quickjs_stdlib
    exit /b 1
)

echo chakra
echo chakra_wilton
wilton_dist\bin\wilton.exe ../js/wilton/test/index.js -m ../js -j chakra || exit /b 1
echo chakra_sanity
wilton_dist\bin\wilton.exe ../js/test-runners/runSanityTests.js -j chakra || exit /b 1
echo chakra_stdlib
wilton_dist\bin\wilton.exe ../js/test-runners/runStdLibTests.js -m ../js -j chakra > chakra_stdlib.log
if errorlevel 1 (
    echo error: chakra_stdlib
    exit /b 1
)

echo duktape
wilton_dist\bin\wilton.exe ../js/wilton/test/index.js -m ../js  -j duktape || exit /b 1
wilton_dist\bin\wilton.exe ../js/test-runners/runSanityTests.js -j duktape || exit /b 1

echo jvm
pushd "../jni" || exit /b 1
cmd /c %WILTON_DIR%/tools/maven/bin/mvn --batch-mode clean test || exit /b 1
popd || exit /b 1

echo rhino
wilton_dist\bin\wilton.exe ../js/wilton/test/index.js -m ../js  -j rhino || exit /b 1
wilton_dist\bin\wilton.exe ../js/test-runners/runSanityTests.js -j rhino || exit /b 1

echo WILTON_FINISH_SUCCESS
