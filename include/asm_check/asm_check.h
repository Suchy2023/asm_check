#pragma once

namespace asm_check
{
	enum class asm_check_result : unsigned char
	{
		error = 0,
		success = 1
	};
}


namespace asm_check::internal
{
	extern "C"
	asm_check_result assembly_checker(void(*)());
}

namespace asm_check
{	
	using VoidFuncPtr = void(*)();

	asm_check_result asm_check(VoidFuncPtr func);

	#define ASM_CHECK(function_call) \
	asm_check::asm_check([]() { function_call; });

}
