
find_package(GTest CONFIG REQUIRED)

add_executable(asm_check_tests)

target_sources(
	asm_check_tests
	PRIVATE
	asm_check.test.cpp
	asm_check.register_preservation.test.cpp
	misbehaving_functions.asm
	stack_corruption.test.cpp
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


