#include "asm_check/asm_check.h"
#include <cstddef>
#include <gmock/gmock.h>
#include <gtest/gtest.h>

namespace 
{
	//Function call check
	std::size_t call_count {0};
	
	std::size_t mock_fn()
	{
		call_count++;
		return call_count;
	}


	TEST(AsmCheckTest, CallsFunctionOnce)
	{
		ASSERT_EQ(call_count, 0);
		
		asm_check::asm_check(mock_fn);
			
		ASSERT_EQ(call_count, 1);
	}

	//Function call check

}
