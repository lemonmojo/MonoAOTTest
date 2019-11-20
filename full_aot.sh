#!/usr/bin/env bash

export MONO_LOG_LEVEL=debug
export MONO_PATH=bin/Debug

cp /Library/Frameworks/Mono.framework/Versions/Current/lib/mono/4.5/mscorlib.dll bin/Debug

mono --debug --aot=full,dwarfdebug,print-skipped-methods,stats,verbose bin/Debug/AOTTest.exe
mono --debug --aot=full,dwarfdebug,print-skipped-methods,stats,verbose bin/Debug/mscorlib.dll