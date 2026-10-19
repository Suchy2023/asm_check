

add_library(asm_check_internal STATIC)

target_sources(
	asm_check_internal
	PRIVATE
	initialize.asm
	check.asm
	audit_data.inc
	assembly_checker.asm
	asm_check.cpp
)

target_include_directories(
	asm_check_internal
	PRIVATE
	${CMAKE_SOURCE_DIR}/include
	${CMAKE_CURRENT_SOURCE_DIR}
)
