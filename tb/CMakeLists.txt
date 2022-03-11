cmake_minimum_required(VERSION 3.8)
project(SNN)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
    message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

# Create a new executable target that will contain all your sources
add_executable(SNN tb.cpp)

# Add the Verilated circuit to the target
verilate(SNN COVERAGE TRACE 
    INCLUDE_DIRS "../hdl"
    VERILATOR_ARGS -f ./input.vc -Os -x-assign 0
    SOURCES ../hdl/snn.v)