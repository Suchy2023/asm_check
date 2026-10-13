
%include "audit_data.inc"

section .text

	global initialize
	
	initialize:
		
		;; pop return address into rdi
		pop rdi

		;; setup frame
		push rbp

	.save_preserved_registers:
	
		push rbx
		push r12
		push r13
		push r14
		push r15
		
	.modify_preserved_registers:
	
		mov rbx, RBX_AUDIT
		mov r12, R12_AUDIT
		mov r13, R13_AUDIT
		mov r14, R14_AUDIT
		mov r15, R15_AUDIT
	
	.push_audit_values:
		
		;; push audit values to check later
		;; we need to use register since push instruction can't take imm64
		mov rcx, STACK_AUDIT_1
		push rcx

		mov rcx, STACK_AUDIT_2
		push rcx

		mov rcx, STACK_AUDIT_3
		push rcx

		mov rcx, STACK_AUDIT_4
		push rcx

		;; push return address back
		push rdi

		ret

		
		
