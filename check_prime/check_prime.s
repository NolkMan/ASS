; This program reads up to 20 characters from input representing a number
; And then finds and prints lowest divisor of that number
; TODO protect from non number inputs
BITS 64;
section .text
	global _start


number:
	xor rax, rax
	mov r8, 10
num_loop:
	xor rcx, rcx
	mov cl, [rdi]
	cmp cl, 10
	je endloop

	sub cl, '0'
	mul r8
	add rax, rcx
	inc rdi
	
	jmp num_loop
endloop:
	ret

check_prime:
	xor rax, rax
;Check if number is divisible by 2
	mov rcx, rdi
	and rcx, 1
	cmp rcx, 0

	jne not_div_by_two
	mov rax, 2
	ret

not_div_by_two:
	mov rcx , 3
check_loop:
	xor rdx, rdx
	mov rax, rdi
	div rcx

	cmp edx, 0
	je found_divider
	
	mov rax, rcx
	mul rax
	cmp rax, rdi
	jge no_divider
	
	inc rcx
	inc rcx
	jmp check_loop

found_divider:
	mov rax, rcx
	ret
no_divider:
	mov rax, rdi
	ret

print_number:
	mov byte [buf+20], 10
	lea r8, [buf+20]
	mov r9, 1
	mov r11, 10
	mov rax, rdi
write_buf:
	cmp rax, 0
	je write_out

	xor rdx, rdx
	idiv  r11
	
	add dl, '0'
	dec r8
	mov byte [r8], dl
	inc r9
	cmp rax, 0
	jmp write_buf
write_out:

	mov rax, 1
	mov rdi, 1
	mov rsi, r8
	mov rdx, r9
	syscall
	ret

_start:
	mov rax, 0
	mov rdi, 0
	mov rsi, buf
	mov rdx, 20
	syscall

	mov rdi, buf
	call number
	
	mov rdi, rax
	call check_prime

	mov rdi, rax
	call print_number

	mov rax, 60
	mov rsi, 0
	syscall
	

section .data
buf db "12345678901234567890", 0
