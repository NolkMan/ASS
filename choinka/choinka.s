section .text
	global _start

jmp _start

print_line:
	mov rcx, 0
	mov rax, size
pl_clear_loop:
	mov byte [rcx + line], ' '

	inc rcx
	cmp rcx, rax
	jne pl_clear_loop

	mov rcx, 0

pl_draw_loop:
	mov rax, mid
	mov rdx, mid
	add rax, rcx
	sub rdx, rcx
	mov byte [rax+line], '*'
	mov byte [rdx+line], '*'

	inc rcx
	cmp rcx, rdi
	jne pl_draw_loop
	
	mov rax, 1
	mov rdi, 1
	mov rsi, line
	mov rdx, size
	add rdx, 2
	syscall
	ret

draw_triangle:
	push r12
	push r13

	mov r12, rsi
	mov r13, rdi

dt_loop:
	mov rdi, r12
	call print_line

	inc r12
	cmp r12, r13
	jne dt_loop
	
	pop r13
	pop r12
	ret


	

_start:
	mov rdi, 5
	mov rsi, 1
	call draw_triangle
	mov rdi, 6
	mov rsi, 2
	call draw_triangle
	mov rdi, 2
	mov rsi, 1
	call draw_triangle

	mov rax, 60
	xor rdi, rdi
	syscall

section .data
line db "123456789", 10 , 0
mid equ 4
size equ 9
