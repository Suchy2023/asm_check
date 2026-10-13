

#include "gtest/gtest.h"
#include <functional>
#include <asm_check/asm_check.h>
#include "misbehaving_functions.h"
#include <gtest/gtest.h>

namespace 
{
	struct TestHelper
	{
		// This function should misbehave
		std::function<void ()> func;
		asm_check::asm_check_result expected_result {asm_check::asm_check_result::error};
	};

	class RegisterTests : public ::testing::TestWithParam<TestHelper> {};

	TEST_P(RegisterTests, ReturnsError)
	{
		
		const TestHelper param {GetParam()};
		
		const auto result = asm_check::asm_check(param.func);

		EXPECT_EQ(result, param.expected_result);
	}

	const auto TestParams = ::testing::Values<TestHelper>(
		TestHelper {.func = not_preserving_rbx },
		TestHelper {.func = not_preserving_r12 },
		TestHelper {.func = not_preserving_r13 },
		TestHelper {.func = not_preserving_r14 },
		TestHelper {.func = not_preserving_r15 }
	);

	INSTANTIATE_TEST_SUITE_P(ReturnsError, RegisterTests, TestParams);


}
