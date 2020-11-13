
REM publish app as a self-contained (all BCL libs will be in a local folder)
REM and copy a special (Checked-config) version of JIT which is able to print disasm (it's turned off for Release version)
IF NOT EXIST bin\Release\net5.0\win-x64\publish\ (
dotnet publish -r win-x64 -c Release
REM url is copied from here: https://clrjit2.blob.core.windows.net/jitrollingbuild?restype=container&comp=list&prefix=builds
curl -o bin\Release\net5.0\win-x64\publish\clrjit.dll https://clrjit2.blob.core.windows.net/jitrollingbuild/builds/03a09319b76879f99e462314f744a25832d47977/Windows_NT/x64/Checked/clrjit.dll
)

REM quickly rebuild the app and copy JitDisasmSample.dll to the publish dir
dotnet build -c Release

MOVE /y bin\Release\net5.0\JitDisasmSample.dll bin\Release\net5.0\win-x64\publish\JitDisasmSample.dll

set "COMPlus_TieredCompilation=0"
set "COMPlus_JitDiffableDasm=1"
set "COMPlus_JitDisasm=SayHelloWorld"

bin\Release\net5.0\win-x64\publish\JitDisasmSample.exe
