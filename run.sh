#!/bin/bash

set -e

TARGET_OS=linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    TARGET_OS=osx
fi

if [ ! -d "bin/Release/net5.0/$TARGET_OS-x64/publish" ]
then
    # publish app as a self-contained (all BCL libs will be in a local folder)
    # and copy a special (Checked-config) version of JIT which is able to print disasm (it's turned off for Release version)
    dotnet publish -r $TARGET_OS-x64 -c Release
    # url is copied from here: https://clrjit2.blob.core.windows.net/jitrollingbuild?restype=container&comp=list&prefix=builds
    curl -o bin/Release/net5.0/$TARGET_OS-x64/publish/libclrjit.dylib \
        https://clrjit2.blob.core.windows.net/jitrollingbuild/builds/03a09319b76879f99e462314f744a25832d47977/$TARGET_OS/x64/Checked/libclrjit.dylib
fi

dotnet build -c Release

cp bin/Release/net5.0/Sample1.dll bin/Release/net5.0/$TARGET_OS-x64/publish/Sample1.dll

# disable tiered jit so everything is compiled with optimizations
export COMPlus_TieredCompilation=0
export COMPlus_JitDiffableDasm=1
export COMPlus_JitDisasm=SayHelloWorld

bin/Release/net5.0/$TARGET_OS-x64/publish/./Sample1

