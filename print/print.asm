;-----------------print.asm-------------------
section .text
global _start
_start:
		mov rsi, 1		;stdout
		mov rdi, msg
		
		
		push 31
		push 100
		push 3802
		push msg3
		push 2
		push 10
		push msg2
		push 's'
		push 'i'
		push 0xEDA
		call mprint
		
		mov rax, 60
		xor rdi,rdi
		syscall
section .data
msg	db "%%this %x %c%c %s taste %d out of %b%%",0xA,"I %s %x %d %% %c",0xA,0
msg2	db "pretty",0
msg3 	db "love",0
%include "printlib.asm"
