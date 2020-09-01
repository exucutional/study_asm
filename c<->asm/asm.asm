extern printf
extern puts
section .text
global _mprintf
_mprintf:
	push rbp
	mov rbp, rsp
	;mov rdi, [rbp + 16]
	push r9
	push r8
	push rcx
	push rdx
	push rsi
	push rdi
	call printf
	add rsp, 48
	pop rbp
	ret
section .data
msg:	db "HELLO WORLD", 0xA, 0
