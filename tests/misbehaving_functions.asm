

RBX_MOCK equ 0xa3cbc52998fe7f3c
R12_MOCK equ 0x8a433fcf728cb889
R13_MOCK equ 0x820670a66f9808c2
R14_MOCK equ 0x635b3981f48735e2
R15_MOCK equ 0x7e9b7f0ed3b2656e


section .text

	global not_preserving_rbx
	global not_preserving_r12
	global not_preserving_r13
	global not_preserving_r14
	global not_preserving_r15

	global stack_corrupting

	not_preserving_rbx:
		
		mov rbx, RBX_MOCK

		ret
	
	not_preserving_r12:

		mov r12, R12_MOCK

		ret

	not_preserving_r13:

		mov r13, R13_MOCK

		ret

	not_preserving_r14:

		mov r14, R14_MOCK

		ret

	not_preserving_r15:

		mov r15, R14_MOCK

		ret

	stack_corrupting:

		;; at start, the value at the top of the stack
		;; is return address
		;; before it, there are placed two temporiaries,
		;; the main objective for this function is to corrupt (change values) of thses temporiaries
	
		;; corrupt values before return address
		;; if this function would take on the stack params, it would corrupts it's own params, but sice it doesnt, it corrupts someone else's data
		mov dword [rsp + 8], 0
		mov dword [rsp + 16], 0

		ret
