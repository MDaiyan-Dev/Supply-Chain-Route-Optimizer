# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 4.0

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\CMake\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\CMake\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\Users\amiru\OneDrive\Desktop\tsp_solver

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:\Users\amiru\OneDrive\Desktop\tsp_solver\build

# Include any dependencies generated for this target.
include CMakeFiles/test_basic.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/test_basic.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/test_basic.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/test_basic.dir/flags.make

CMakeFiles/test_basic.dir/codegen:
.PHONY : CMakeFiles/test_basic.dir/codegen

CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj: CMakeFiles/test_basic.dir/flags.make
CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj: CMakeFiles/test_basic.dir/includes_CXX.rsp
CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj: C:/Users/amiru/OneDrive/Desktop/tsp_solver/tests/test_basic.cpp
CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj: CMakeFiles/test_basic.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=C:\Users\amiru\OneDrive\Desktop\tsp_solver\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj -MF CMakeFiles\test_basic.dir\tests\test_basic.cpp.obj.d -o CMakeFiles\test_basic.dir\tests\test_basic.cpp.obj -c C:\Users\amiru\OneDrive\Desktop\tsp_solver\tests\test_basic.cpp

CMakeFiles/test_basic.dir/tests/test_basic.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/test_basic.dir/tests/test_basic.cpp.i"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\amiru\OneDrive\Desktop\tsp_solver\tests\test_basic.cpp > CMakeFiles\test_basic.dir\tests\test_basic.cpp.i

CMakeFiles/test_basic.dir/tests/test_basic.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/test_basic.dir/tests/test_basic.cpp.s"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\amiru\OneDrive\Desktop\tsp_solver\tests\test_basic.cpp -o CMakeFiles\test_basic.dir\tests\test_basic.cpp.s

CMakeFiles/test_basic.dir/src/Graph.cpp.obj: CMakeFiles/test_basic.dir/flags.make
CMakeFiles/test_basic.dir/src/Graph.cpp.obj: CMakeFiles/test_basic.dir/includes_CXX.rsp
CMakeFiles/test_basic.dir/src/Graph.cpp.obj: C:/Users/amiru/OneDrive/Desktop/tsp_solver/src/Graph.cpp
CMakeFiles/test_basic.dir/src/Graph.cpp.obj: CMakeFiles/test_basic.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=C:\Users\amiru\OneDrive\Desktop\tsp_solver\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/test_basic.dir/src/Graph.cpp.obj"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/test_basic.dir/src/Graph.cpp.obj -MF CMakeFiles\test_basic.dir\src\Graph.cpp.obj.d -o CMakeFiles\test_basic.dir\src\Graph.cpp.obj -c C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\Graph.cpp

CMakeFiles/test_basic.dir/src/Graph.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/test_basic.dir/src/Graph.cpp.i"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\Graph.cpp > CMakeFiles\test_basic.dir\src\Graph.cpp.i

CMakeFiles/test_basic.dir/src/Graph.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/test_basic.dir/src/Graph.cpp.s"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\Graph.cpp -o CMakeFiles\test_basic.dir\src\Graph.cpp.s

CMakeFiles/test_basic.dir/src/Tour.cpp.obj: CMakeFiles/test_basic.dir/flags.make
CMakeFiles/test_basic.dir/src/Tour.cpp.obj: CMakeFiles/test_basic.dir/includes_CXX.rsp
CMakeFiles/test_basic.dir/src/Tour.cpp.obj: C:/Users/amiru/OneDrive/Desktop/tsp_solver/src/Tour.cpp
CMakeFiles/test_basic.dir/src/Tour.cpp.obj: CMakeFiles/test_basic.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=C:\Users\amiru\OneDrive\Desktop\tsp_solver\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/test_basic.dir/src/Tour.cpp.obj"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/test_basic.dir/src/Tour.cpp.obj -MF CMakeFiles\test_basic.dir\src\Tour.cpp.obj.d -o CMakeFiles\test_basic.dir\src\Tour.cpp.obj -c C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\Tour.cpp

CMakeFiles/test_basic.dir/src/Tour.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/test_basic.dir/src/Tour.cpp.i"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\Tour.cpp > CMakeFiles\test_basic.dir\src\Tour.cpp.i

CMakeFiles/test_basic.dir/src/Tour.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/test_basic.dir/src/Tour.cpp.s"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\Tour.cpp -o CMakeFiles\test_basic.dir\src\Tour.cpp.s

CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj: CMakeFiles/test_basic.dir/flags.make
CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj: CMakeFiles/test_basic.dir/includes_CXX.rsp
CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj: C:/Users/amiru/OneDrive/Desktop/tsp_solver/src/TSPSolver.cpp
CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj: CMakeFiles/test_basic.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=C:\Users\amiru\OneDrive\Desktop\tsp_solver\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj -MF CMakeFiles\test_basic.dir\src\TSPSolver.cpp.obj.d -o CMakeFiles\test_basic.dir\src\TSPSolver.cpp.obj -c C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\TSPSolver.cpp

CMakeFiles/test_basic.dir/src/TSPSolver.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/test_basic.dir/src/TSPSolver.cpp.i"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\TSPSolver.cpp > CMakeFiles\test_basic.dir\src\TSPSolver.cpp.i

CMakeFiles/test_basic.dir/src/TSPSolver.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/test_basic.dir/src/TSPSolver.cpp.s"
	C:\PROGRA~1\X86_64~1.0-R\mingw64\bin\C__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\amiru\OneDrive\Desktop\tsp_solver\src\TSPSolver.cpp -o CMakeFiles\test_basic.dir\src\TSPSolver.cpp.s

# Object files for target test_basic
test_basic_OBJECTS = \
"CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj" \
"CMakeFiles/test_basic.dir/src/Graph.cpp.obj" \
"CMakeFiles/test_basic.dir/src/Tour.cpp.obj" \
"CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj"

# External object files for target test_basic
test_basic_EXTERNAL_OBJECTS =

test_basic.exe: CMakeFiles/test_basic.dir/tests/test_basic.cpp.obj
test_basic.exe: CMakeFiles/test_basic.dir/src/Graph.cpp.obj
test_basic.exe: CMakeFiles/test_basic.dir/src/Tour.cpp.obj
test_basic.exe: CMakeFiles/test_basic.dir/src/TSPSolver.cpp.obj
test_basic.exe: CMakeFiles/test_basic.dir/build.make
test_basic.exe: CMakeFiles/test_basic.dir/linkLibs.rsp
test_basic.exe: CMakeFiles/test_basic.dir/objects1.rsp
test_basic.exe: CMakeFiles/test_basic.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=C:\Users\amiru\OneDrive\Desktop\tsp_solver\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable test_basic.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\test_basic.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/test_basic.dir/build: test_basic.exe
.PHONY : CMakeFiles/test_basic.dir/build

CMakeFiles/test_basic.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\test_basic.dir\cmake_clean.cmake
.PHONY : CMakeFiles/test_basic.dir/clean

CMakeFiles/test_basic.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\Users\amiru\OneDrive\Desktop\tsp_solver C:\Users\amiru\OneDrive\Desktop\tsp_solver C:\Users\amiru\OneDrive\Desktop\tsp_solver\build C:\Users\amiru\OneDrive\Desktop\tsp_solver\build C:\Users\amiru\OneDrive\Desktop\tsp_solver\build\CMakeFiles\test_basic.dir\DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/test_basic.dir/depend

