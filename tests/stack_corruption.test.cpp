

#include "gtest/gtest.h"
#include <functional>
#include <gtest/gtest.h>
#include "asm_check/asm_check.h"
#include "misbehaving_functions.h"

namespace 
{
	struct ErrorCaseHelper
	{
		std::function<void ()> fn;
		asm_check::asm_check_result expected_result;
	};
	
	class ErroCase : public ::testing::TestWithParam<ErrorCaseHelper>{};

	TEST_P(ErroCase, ReturnsError)
	{
		const ErrorCaseHelper helper = GetParam();

		const auto check_result = asm_check::asm_check(helper.fn);

		EXPECT_EQ(check_result, helper.expected_result);
	};

	const auto ErrorCaseParams = ::testing::Values<ErrorCaseHelper>(
		ErrorCaseHelper {.fn =  stack_corrupting, .expected_result = asm_check::asm_check_result::error}
	);

	INSTANTIATE_TEST_SUITE_P(StackCorruption, ErroCase, ErrorCaseParams);
}
