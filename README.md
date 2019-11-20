# MonoAOTTest

A simple C# project to test Mono AOT compilation.

## Compilation

* There are a couple of bash scripts which can be used to compile, AOT and run the project.
* Clone the repository
* Open `Terminal.app`
* cd to the project's path
* Run `./buildaotandrun.sh`

## Expected behaviour

* The project intentionally crashes when calling `NSLog`.
* Why? Because my goal is to use AOT for improved native crash logs and profiling using Instruments.
* So when AOTing the code I expect that native crash logs would contain symbols for managed method calls.

## Problems

* The native code appears to be loaded and used as it's mentioned in mono's log output:
```
Mono: AOT: FOUND method AOTTest.MainClass:Main (string[]) [0x10430cbc0 - 0x10430cbe9 0x10430ceb1]
Mono: AOT: FOUND method AOTTest.MainClass:PrintToConsole (string) [0x10430cbf0 - 0x10430cc21 0x10430ceb4]
```
* However, the generated native crash log doesn't contain those symbols.
* The native crash log can be found by opening `Console.app` and navigating to `Crash Reports`.
* Here's a sample of the crashing stack trace:

```
0   libsystem_kernel.dylib        	0x00007fff6fff949a __pthread_kill + 10
1   libsystem_pthread.dylib       	0x00007fff700b66cb pthread_kill + 384
2   libsystem_c.dylib             	0x00007fff6ff81a1c abort + 120
3   mono                          	0x0000000103deecee mono_post_native_crash_handler + 14
4   mono                          	0x0000000103d8781b mono_handle_native_crash + 475 (mini-exceptions.c:3364)
5   mono                          	0x0000000103ce05b1 mono_sigsegv_signal_handler_debug + 769 (mini-runtime.c:3363)
6   libsystem_platform.dylib      	0x00007fff700abb1d _sigtramp + 29
7   ???                           	000000000000000000 0 + 0
8   com.apple.CoreFoundation      	0x00007fff38a29d70 _CFLogvEx3 + 189
9   com.apple.Foundation          	0x00007fff3b224d05 _NSLogv.llvm.16137531714238344275 + 102
10  com.apple.Foundation          	0x00007fff3b0d63b6 NSLog + 132
11  ???                           	0x000000010426aede 0 + 4364611294
12  mono                          	0x0000000103ce3bc9 mono_jit_runtime_invoke + 1641 (mini-runtime.c:3184)
13  mono                          	0x0000000103f01234 do_runtime_invoke + 84 (object.c:3017)
14  mono                          	0x0000000103f04f5c do_exec_main_checked + 156 (object.c:5120)
15  mono                          	0x0000000103d4533d mono_jit_exec + 429 (driver.g.c:1329)
16  mono                          	0x0000000103d484e8 mono_main + 9048 (driver.g.c:2664)
17  mono                          	0x0000000103cd2db8 main + 264 (main.c:408)
18  libdyld.dylib                 	0x00007fff6feaa2e5 start + 1
```

* Note that line 11 doesn't contain symbols for the `PrintToConsole` method call.
