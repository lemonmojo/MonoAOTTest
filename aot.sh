#!/usr/bin/env bash

mono --debug --aot=hybrid,dwarfdebug,print-skipped-methods,stats,verbose bin/Debug/AOTTest.exe