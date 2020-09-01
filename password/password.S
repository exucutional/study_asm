;-----------------password.S-------------------
section .text
global main
main:
		mov rdi, 1
		mov rsi, entermsg
		mov rdx, entermsglen
		mov rax, 1
		syscall
		sub rsp, 16
		mov rdi, 1	;stdout
		mov rsi, buff   ;buffer
		mov rdx, 32	;count
		mov rax, 0
		syscall	
		mov rcx, passlen
		xor rax, rax
check:
		mov bl, byte [pswrd + rax]	
		cmp bl, byte [rsp + rax]
		jne fail
		inc rax
		loop check
		jmp success
fail:
		mov rdi, 1
		mov rsi, msgfail
		mov rdx, msgflen
		jmp exit
success:
		mov rdi, 1
		mov rsi, msgpass
		mov rdx, msgplen
		jmp exit
exit:
		add rsp, 16
		mov rax, 1
		syscall
		mov rax, 60
		xor rdi, rdi
		syscall
section .data
buff times 10 db 0
pswrd db "a3e46cb349"
def times 16 db 0
passlen equ $ - pswrd - 16
msgpass db "Correct password!", 0xA, 0
msgplen equ $ - msgpass
msgfail db "Wrong password!", 0xA, 0
msgflen equ $ - msgfail
entermsg db "Enter password: ", 0
entermsglen equ $ - entermsg