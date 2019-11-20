#!/usr/bin/env bash

set -e

./build.sh
./aot.sh
./run.sh