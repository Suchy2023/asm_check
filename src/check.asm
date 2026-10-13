

%include "audit_data.inc"

;; stack looks like this there (stack grows downwards)
;; saved rbp
;; preserved registers (5)
;; stack audit values (4)

section .text

	global check

	check:

		;; save return address into rcx
		pop rcx
	
	.audit_stack:

		;; pop all the audit values
		pop rdx
		pop rsi
		pop rdi
		pop r8
		
		mov r9, STACK_AUDIT_4
		cmp r9, rdx
		jne .ret_err_stack

		mov r9, STACK_AUDIT_3
		cmp r9, rsi
		jne .ret_err_stack

		mov r9, STACK_AUDIT_2
		cmp r9, rdi
		jne .ret_err_stack

		mov r9, STACK_AUDIT_1
		cmp r9, r8
		jne .ret_err_stack

	.audit_registers:
		
		mov rdx, RBX_AUDIT
		cmp rdx, rbx
		jne .ret_err_reg

		mov rdx, R12_AUDIT
		cmp rdx, r12
		jne .ret_err_reg

		mov rdx, R13_AUDIT
		cmp rdx, r13
		jne .ret_err_reg

		mov rdx, R14_AUDIT
		cmp rdx, r14
		jne .ret_err_reg

		mov rdx, R15_AUDIT
		cmp rdx, r15
		jne .ret_err_reg

		jmp .ret_success

	
	.ret_err_stack:
	
		;; return false (error)
		mov al, 0

		jmp .restore_preserved_registers

	.ret_err_reg:

		mov al, 0

		jmp .restore_preserved_registers
	
	.ret_success:
	
		mov al, 1

		jmp .restore_preserved_registers
		

	.restore_preserved_registers:
		
		;; restore callee saved registers
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx

		;; restore base pointer
		pop rbp
		
		;; push return addrss back so ret will go back properly
		push rcx

		ret

		
		



		



