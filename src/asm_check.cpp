
#include "asm_check/asm_check.h"

namespace asm_check
{
	asm_check_result asm_check(VoidFuncPtr func)
	{
		return internal::assembly_checker(func);	
	};

}
