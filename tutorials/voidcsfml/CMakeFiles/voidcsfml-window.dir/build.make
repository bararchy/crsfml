# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/blaxpirit/projects/crsfml

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/blaxpirit/projects/crsfml

# Include any dependencies generated for this target.
include voidcsfml/CMakeFiles/voidcsfml-window.dir/depend.make

# Include the progress variables for this target.
include voidcsfml/CMakeFiles/voidcsfml-window.dir/progress.make

# Include the compile flags for this target's objects.
include voidcsfml/CMakeFiles/voidcsfml-window.dir/flags.make

voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o: voidcsfml/CMakeFiles/voidcsfml-window.dir/flags.make
voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o: voidcsfml/src/voidcsfml/window.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/blaxpirit/projects/crsfml/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o"
	cd /home/blaxpirit/projects/crsfml/voidcsfml && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o -c /home/blaxpirit/projects/crsfml/voidcsfml/src/voidcsfml/window.cpp

voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.i"
	cd /home/blaxpirit/projects/crsfml/voidcsfml && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/blaxpirit/projects/crsfml/voidcsfml/src/voidcsfml/window.cpp > CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.i

voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.s"
	cd /home/blaxpirit/projects/crsfml/voidcsfml && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/blaxpirit/projects/crsfml/voidcsfml/src/voidcsfml/window.cpp -o CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.s

voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.requires:

.PHONY : voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.requires

voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.provides: voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.requires
	$(MAKE) -f voidcsfml/CMakeFiles/voidcsfml-window.dir/build.make voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.provides.build
.PHONY : voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.provides

voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.provides.build: voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o


# Object files for target voidcsfml-window
voidcsfml__window_OBJECTS = \
"CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o"

# External object files for target voidcsfml-window
voidcsfml__window_EXTERNAL_OBJECTS =

voidcsfml/libvoidcsfml-window.so.2.4: voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o
voidcsfml/libvoidcsfml-window.so.2.4: voidcsfml/CMakeFiles/voidcsfml-window.dir/build.make
voidcsfml/libvoidcsfml-window.so.2.4: /usr/lib/libsfml-window.so
voidcsfml/libvoidcsfml-window.so.2.4: /usr/lib/libsfml-system.so
voidcsfml/libvoidcsfml-window.so.2.4: voidcsfml/CMakeFiles/voidcsfml-window.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/blaxpirit/projects/crsfml/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library libvoidcsfml-window.so"
	cd /home/blaxpirit/projects/crsfml/voidcsfml && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/voidcsfml-window.dir/link.txt --verbose=$(VERBOSE)
	cd /home/blaxpirit/projects/crsfml/voidcsfml && $(CMAKE_COMMAND) -E cmake_symlink_library libvoidcsfml-window.so.2.4 libvoidcsfml-window.so.2.4 libvoidcsfml-window.so

voidcsfml/libvoidcsfml-window.so: voidcsfml/libvoidcsfml-window.so.2.4
	@$(CMAKE_COMMAND) -E touch_nocreate voidcsfml/libvoidcsfml-window.so

# Rule to build all files generated by this target.
voidcsfml/CMakeFiles/voidcsfml-window.dir/build: voidcsfml/libvoidcsfml-window.so

.PHONY : voidcsfml/CMakeFiles/voidcsfml-window.dir/build

voidcsfml/CMakeFiles/voidcsfml-window.dir/requires: voidcsfml/CMakeFiles/voidcsfml-window.dir/src/voidcsfml/window.cpp.o.requires

.PHONY : voidcsfml/CMakeFiles/voidcsfml-window.dir/requires

voidcsfml/CMakeFiles/voidcsfml-window.dir/clean:
	cd /home/blaxpirit/projects/crsfml/voidcsfml && $(CMAKE_COMMAND) -P CMakeFiles/voidcsfml-window.dir/cmake_clean.cmake
.PHONY : voidcsfml/CMakeFiles/voidcsfml-window.dir/clean

voidcsfml/CMakeFiles/voidcsfml-window.dir/depend:
	cd /home/blaxpirit/projects/crsfml && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/blaxpirit/projects/crsfml /home/blaxpirit/projects/crsfml/voidcsfml /home/blaxpirit/projects/crsfml /home/blaxpirit/projects/crsfml/voidcsfml /home/blaxpirit/projects/crsfml/voidcsfml/CMakeFiles/voidcsfml-window.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : voidcsfml/CMakeFiles/voidcsfml-window.dir/depend

