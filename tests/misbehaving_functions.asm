
USE64

default rel

STACK_RANDOM_1 equ 0x49107143aea5697c
STACK_RANDOM_2 equ 0xbb04fd8841dad8b1
STACK_RANDOM_3 equ 0xc7b0d6597b40bf54

RBP_MOCK equ 0x7762e80d91303b24

RBX_MOCK equ 0xa3cbc52998fe7f3c
R12_MOCK equ 0x8a433fcf728cb889
R13_MOCK equ 0x820670a66f9808c2
R14_MOCK equ 0x635b3981f48735e2
R15_MOCK equ 0x7e9b7f0ed3b2656e


section .text

	global not_preserving_rsp
	global not_preserving_rbp

	global not_preserving_rbx
	global not_preserving_r12
	global not_preserving_r13
	global not_preserving_r14
	global not_preserving_r15

	global stack_corrupting
	
	not_preserving_rbp:
		
		mov rbp, RBP_MOCK

		ret

	not_preserving_rsp:

		;; pop return address into rax
		pop rax
		
		;; reserve 32 bytes on the stack 
		sub rsp, 32

		;; push return address back
		push rax

		ret

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

		mov r15, R15_MOCK

		ret

	stack_corrupting:

		;; at start, the value at the top of the stack
		;; is return address
		;; before it, there are three temporiaries,
		;; the main objective for this function is to corrupt (change values) of thses temporiaries
	
		;; corrupt values before return address
		;; if this function would take on the stack params, it would corrupts it's own params, but sice it doesnt, it corrupts someone else's data
		
		;; cannot do mov qword [rsp + x], imm64
		;; because mov addr cannot take immediate 64 value
		;; but register can take imm64

		mov rax, STACK_RANDOM_1
		mov qword [rsp + 8], rax

		mov rax, STACK_RANDOM_2
		mov qword [rsp + 16], rax

		mov rax, STACK_RANDOM_3
		mov qword [rsp + 24], rax

		ret
