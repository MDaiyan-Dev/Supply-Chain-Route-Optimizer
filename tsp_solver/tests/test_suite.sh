#!/bin/bash
set -e

# Create a 'build' directory, run CMake, build, then run tests.
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release

# Run the single test; CTest will pick up 'test_basic'.
ctest --output-on-failure
