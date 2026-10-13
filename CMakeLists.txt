cmake_minimum_required(VERSION 4.3)

project(asm_check)

enable_language(CXX ASM_NASM)

set(CMAKE_CXX_STANDARD 23)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_library(
	asm_check
	STATIC
)

target_sources(
	asm_check
	PRIVATE
	${CMAKE_SOURCE_DIR}/include/asm_check/asm_check.h
)

target_link_libraries(
	asm_check
	PRIVATE
	asm_check_internal
)

set_target_properties(
	asm_check
	PROPERTIES
	LINKER_LANGUAGE
	CXX
)
add_subdirectory(src)

enable_testing()

add_subdirectory(tests)
