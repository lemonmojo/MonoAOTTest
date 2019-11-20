#!/usr/bin/env bash

set -e

./build.sh
./full_aot.sh
./full_run.sh