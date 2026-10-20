default rel

%include "audit_data.inc"

section .bss

	rbp_static: resb 8

section .text

	global assembly_checker

	;;asm_check_result assembly_checker(void(*)());
	assembly_checker:
	
	.enter:
		;; enter
		push rbp
		mov rbp, rsp	

		mov [rbp_static], rbp

	.preserve_registers:

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

	.push_canary_data:
		
		mov rax, STACK_AUDIT_1
		push rax

		mov rax, STACK_AUDIT_2
		push rax

		mov rax, STACK_AUDIT_3
		push rax
	
	.call:

		call rdi

	.check_stack:
		
		pop rax
		pop rcx
		pop rdx

		mov rsi, STACK_AUDIT_3
		cmp rsi, rax
		jne .ret_stack_err

		mov rsi, STACK_AUDIT_2
		cmp rsi, rcx
		jne .ret_stack_err

		mov rsi, STACK_AUDIT_1
		cmp rsi, rdx
		jne .ret_stack_err

	.check_preserved_registers:

		mov rax, [rbp_static]
		cmp rax, rbp
		jne .ret_reg_err

		mov rax, RBX_AUDIT
		cmp rax, rbx
		jne .ret_reg_err

		mov rax, R12_AUDIT
		cmp rax, r12
		jne .ret_reg_err

		mov rax, R13_AUDIT
		cmp rax, r13
		jne .ret_reg_err

		mov rax, R14_AUDIT
		cmp rax, r14
		jne .ret_reg_err

		mov rax, R15_AUDIT
		cmp rax, r15
		jne .ret_reg_err
		
		;; no error before, return success
		mov al, 1

	.restore_preserved_registers:

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx

	.leave:
		;; leave	
		mov rsp, [rbp_static]

		;; here breaks the bus error
		pop rbp

		ret	
	
	.ret_stack_err:
	
		mov al, 0
		jmp .restore_preserved_registers
		
	.ret_reg_err:

		mov al, 0
		jmp .restore_preserved_registers
