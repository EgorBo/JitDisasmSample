# JitDisasmSample

CLR JIT is able to print "disam" for any method it compiles (or asked to compile via `RuntimeHelpers.PrepareMethod`)
However, this (and other) capabilities are enabled only in a special (Checked) version of clrjit

So we can download it (published from dotnet/runtime builds now) and use.
It also allows to play with experimental or inner features which are stripped in release versions.

# Known issue
Doesn't work on Linux/macOS for some reason (JIT<->VM version mismatch?) so only Windows at the moment

# Alternatives
[https://github.com/xoofx/JitBuddy](https://github.com/xoofx/JitBuddy) - it's based on clrmd so it doesn't require any
special version of JIT. But disasm output is less friendly (addresses instead of friendly names for calls/CORINFO helpers, branch weights, etc)
