;------------------outlib.asm-----------------------
section .data
buff		times 256 db 0
section .code
;------------------------------------------------
;Name: axoutdec
;Entry: rax = number
;Exit:
;Destr: rax, rbx, rcx, rdx, rdi, rsi 
;------------------------------------------------
axoutdec:	
		push rbp
		mov rbp, rsp
		mov rcx, 0
	        mov rdi, buff    
		mov rbx, 10d
divoutd:
		mov rdx, 0
		div rbx	
		add rdx, '0'
		
        	push rdx		
        	inc rcx
		cmp rax, 0
		jne divoutd
        	mov rdx, rcx    	;length
decbuffwrite:
        	pop rax
        	cld             	;di ahead
        	stosb
        	loop decbuffwrite
        	mov rax, 1		;sys_write
		mov rsi, buff		;string
        	mov rdi, 1     		;file descriptor
		syscall
		pop rbp
		ret
		
;------------------------------------------------
;Name: axouthex
;Entry: ax = number
;Exit:
;Destr: rax, rbx, rcx, rdx, rdi, rsi 
;------------------------------------------------
axouthex:
		push rbp
		mov rbp, rsp
                mov rcx, 0
                mov rdi, buff
divouth:
		mov rbx, 000Fh
		and rbx, rax
		shr ax, 4
		cmp rbx, 10d
		jge notnum
		add rbx, '0'
		jmp next		
notnum:	
		sub rbx, 10d
		add rbx, 'a'
next:
		push rbx
		inc rcx
		cmp ax, 0
		jne divouth
		mov rdx, rcx
hexbuffwrite:
                pop rax
                cld                     ;di ahead
                stosb
                loop hexbuffwrite
                mov rax, 1              ;sys_write
                mov rsi, buff           ;string
                mov rdi, 1              ;file descriptor
                syscall
                pop rbp
                ret
;------------------------------------------------
;Name: axoutbin
;Entry: ax = number
;Exit:
;Destr: rax, rbx, rcx, rdx, rdi, rsi 
;------------------------------------------------
axoutbin:
		push rbp
		mov rbp, rsp
                mov rcx, 0
                mov rdi, buff
divoutb:
		mov rbx, 0001h
		and rbx, rax
		add rbx, '0'
		push rbx
		shr rax, 1
		inc rcx
		cmp rax, 0
		jne divoutb
		mov rdx, rcx
binbuffwrite:
		pop rax
                cld                     ;di ahead
                stosb
                loop hexbuffwrite
                mov rax, 1              ;sys_write
                mov rsi, buff           ;string
                mov rdi, 1              ;file descriptor
                syscall
                pop rbp
		ret
