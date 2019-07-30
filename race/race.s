section .text
	global _start
_start:

	mov r12, 0
	mov r13, 0

_loop:

	xor eax, eax
	xor rdi, rdi
	mov rsi, buf
	mov rdx, 1

	syscall

	xor eax, eax
	mov al, [buf]
	sub al, 97 
	cmp al, 0

	je p1move
	sub al, 11
	je p2move
	
	jmp nomove
	
	
p1move:
	lea eax, [racer1 + r12]
	mov byte [eax], '-'

	inc r12

	mov r14, r12
	sub r14, 20
	cmp r14, 0
	je p1won

	jmp nomove
p1won:
	mov rax, 1
	mov rdi, 0
	lea rsi, [r1w]
	mov rdx, 14
	syscall 

	jmp end

p2move:
	lea eax, [racer2 + r13]
	mov byte [eax], '-'

	inc r13

	mov r14, r13
	sub r14, 20
	cmp r14, 0
	je p2won

	jmp nomove

p2won:
	mov rax, 1
	mov rdi, 0
	lea rsi, [r2w]
	mov rdx, 14
	syscall

	jmp end
	
nomove:
	
	mov rax, 1
	mov rdi, 0
	lea rsi, [racer1]
	mov rdx, 21
	syscall

	mov rax, 1
	mov rdi, 0
	mov rsi, racer2
	mov rdx, 21
	syscall

	
	
	jmp _loop

end:
	mov rax, 1
	mov rdi, 0
	lea rsi, [racer1]
	mov rdx, 21
	syscall

	mov rax, 1
	mov rdi, 0
	mov rsi, racer2
	mov rdx, 21
	syscall

	mov eax, 60
	xor rdi, rdi

	syscall
	
	
section .data
align 8 

buf db "T, twoja stara", 0 ;
racer1 db "                   $", 10, 0 ;
racer2 db "                   $", 10, 0 ;
r1w db "Player 1 won",10,0
r2w db "Player 2 won",10,0
