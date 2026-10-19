
find_package(GTest CONFIG REQUIRED)

add_executable(asm_check_tests)

target_sources(
	asm_check_tests
	PRIVATE
	asm_check.error_cases.cpp
	asm_check.success_cases.cpp
	misbehaving_functions.asm
	test_helpers.asm
	asm_check.abi.test.cpp
	check_registers_preserved.asm
	check_stack_corrupted.asm
)

target_include_directories(
	asm_check_tests
	PRIVATE
	${CMAKE_SOURCE_DIR}/include
	${CMAKE_CURRENT_SOURCE_DIR}/include
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(
	asm_check_tests
	PRIVATE
	asm_check
	GTest::gtest
	GTest::gtest_main
)

include(GoogleTest)

gtest_discover_tests(asm_check_tests)


