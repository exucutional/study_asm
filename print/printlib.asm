;-----------------printlib.asm------------------
section .data
buffch		times 16 db 0
section .text
;-----------------------------------------------
;Name: mprint
;Entry: rsi = file out descriptor, 
;	rdi = offset string,
;	stack arguments
;Exit:	
;Destr: rax, rbx, rcx, rdx, rsi, r8, r9, r10
;-----------------------------------------------
mprint:		
		push rbp
		mov rbp, rsp
		mov r10, 2
		push rdi		;save rdi
		call strlen
		mov rcx, rax		;rcx = strlen
		pop rdi			;recovery rdi
againprint:
		
		cld			;search ahead string
		mov rax, '%'
		mov rbx, rdi		;save begin string
		repne scasb
		jne lttr
		dec rdi
		jmp lttr		
dec:
		cmp byte [rdi], 'd'
		jne hex
		mov rax, [rbp + r10 * 8]
		inc r10
		push rsi		;save rsi
		push rdi		;save rdi
		push rcx		;save rcx
		call axoutdec
		pop rcx			;recovery rcx
		pop rdi			;recovery rdi
		pop rsi			;recovery rsi
		inc rdi
		dec rcx
		jmp againprint 
hex:
		cmp byte [rdi], 'x'
		jne bin
                mov rax, [rbp + r10 * 8]
                inc r10
                push rsi                ;save rsi
                push rdi                ;save rdi
                push rcx                ;save rcx
                call axouthex
                pop rcx                 ;recovery rcx
                pop rdi                 ;recovery rdi
                pop rsi                 ;recovery rsi
                inc rdi
                dec rcx
                jmp againprint

bin:
		cmp byte [rdi], 'b'
		jne char
                mov rax, [rbp + r10 * 8]
                inc r10
                push rsi                ;save rsi
                push rdi                ;save rdi
                push rcx                ;save rcx
                call axoutbin
                pop rcx                 ;recovery rcx
                pop rdi                 ;recovery rdi
                pop rsi                 ;recovery rsi
                inc rdi
                dec rcx
                jmp againprint
char:	
		cmp byte [rdi], 'c'
		jne str
		mov rax, [rbp + r10 * 8]
		inc r10
		mov byte [buffch], al
prcntchar: 
		mov rax, 1		;sys_write
		mov rdx, 1		;length
                push rsi                ;save rsi
                push rdi                ;save rdi
                push rcx                ;save rcx
		mov rdi, rsi		;file descriptor
		mov rsi, buffch		;string
		syscall
                pop rcx                 ;recovery rcx
                pop rdi                 ;recovery rdi
                pop rsi                 ;recovery rsi
		inc rdi
		dec rcx
		jmp againprint
str:
		cmp byte [rdi], 's'
		jne prcnt
		push rsi		;save rsi
		push rdi		;save rdi
		push rcx		;save rcx
		mov rdi, [rbp + r10 * 8]
		inc r10
		push rdi		;save rdi
		call strlen
		pop rbx			;recovery rdi
		mov rdi, rsi		;file descriptor
		mov rdx, rax		;length
		mov rsi, rbx		;string
		mov rax, 1
		syscall
		pop rcx			;recovery rcx
		pop rdi			;recovery rdi
		pop rsi			;recovery rsi
		inc rdi
		dec rcx
		jmp againprint
prcnt:
		cmp byte [rdi], '%'
		jne lttr
		mov byte [buffch], '%'
		jmp prcntchar
lttr:	
		push rcx		;save rcx
		mov rax, 1		;sys_write
		mov rdx, rdi		;length
		sub rdx, rbx
		mov r8, rsi		;save rsi
		mov r9, rdi		;save rdi
		mov rdi, rsi		;file descriptor
		mov rsi, rbx		;string
		syscall
		inc rbx
		mov rsi, r8		;recovery rsi
		mov rdi, r9		;recovery rdi
		pop rcx			;recovery rcx
		cmp rcx, 0
		je endprint
		inc rdi
		jmp dec
endprint:
		pop rbp
		ret
;-----------------------------------------------
;Name: strlen
;Entry: rdi = offset string
;Exit:  rax = string length
;Destr: rdi
;-----------------------------------------------
strlen:
		xor rax, rax
strlenloop:
		cmp byte [rdi], 0
		je endstrlen
		inc rax
		inc rdi
		jmp strlenloop
endstrlen:
		ret
%include "outlib.asm"
