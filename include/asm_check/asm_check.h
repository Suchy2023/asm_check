#include <functional>
#include <concepts>

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
	// Initialization before calling passed function
	// Pollutes preserved registers
	// Pushes canary values on the stack
	extern "C"
	void initialize();

	// Check after function was called
	// checks callee saved registers registers
	// checks canary values on the stack
	extern "C"
	asm_check_result check();	
}

namespace asm_check
{

	template <typename ...TArgs>
	asm_check_result asm_check(std::invocable<TArgs...> auto&& fn, TArgs&&... args)
	{	
		internal::initialize();

		std::invoke(std::forward<decltype(fn)>(fn), std::forward<TArgs>(args)...);

		internal::check();

		return asm_check_result::error;
	}
}
