IF NOT EXIST bin\Release\net5.0\win-x64\publish\ (
    REM publish app as a self-contained (all BCL libs will be in a local folder)
    REM and copy a special (Checked-config) version of JIT which is able to print disasm (it's turned off for Release version)
    dotnet publish -r win-x64 -c Release
    REM url is copied from here: https://clrjit2.blob.core.windows.net/jitrollingbuild?restype=container&comp=list&prefix=builds
    curl -o bin\Release\net5.0\win-x64\publish\clrjit.dll https://clrjit2.blob.core.windows.net/jitrollingbuild/builds/03a09319b76879f99e462314f744a25832d47977/Windows_NT/x64/Checked/clrjit.dll
)

REM quickly rebuild the app and copy Sample2.dll to the publish dir
dotnet build -c Release

MOVE /y bin\Release\net5.0\Sample2.dll bin\Release\net5.0\win-x64\publish\Sample2.dll

set "COMPlus_TieredCompilation=1"
set "COMPlus_TC_CallCountingDelayMs=1"
set "COMPlus_TC_QuickJitForLoops=1"
set "COMPlus_TieredPGO=1"
set "COMPlus_JitInlinePolicyProfile=1"
set "COMPlus_ReadyToRun=0"
REM set "COMPlus_TC_AggressiveTiering=1"
set "COMPlus_JitDiffableDasm=1"
set "COMPlus_JitDisasm=Test"

bin\Release\net5.0\win-x64\publish\Sample2.exe
