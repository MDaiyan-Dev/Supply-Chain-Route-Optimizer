cmake_minimum_required(VERSION 3.10)
project(TSPSolver VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Include directory for header files
include_directories(${PROJECT_SOURCE_DIR}/include)

# Source files for the main executable
set(SRC_FILES
    src/Graph.cpp
    src/Tour.cpp
    src/TSPSolver.cpp
    src/Timer.cpp
    src/main.cpp    # updated main.cpp
)

add_executable(tsp_solver ${SRC_FILES})

# --- Testing Section ---
enable_testing()

add_executable(test_basic
    tests/test_basic.cpp
    src/Graph.cpp
    src/Tour.cpp
    src/TSPSolver.cpp
)
target_include_directories(test_basic PRIVATE ${PROJECT_SOURCE_DIR}/include)
add_test(NAME basic_test COMMAND test_basic)
