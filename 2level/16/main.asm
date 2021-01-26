; Написать процедуру, реализуюую умножение двух однобайтовых значений (без знака) используя команды сдвига и сложения.
section .text
	global _start

_start:
	mov al, 10
	mov bl, 10
	call multiplication
	mov eax, 1
	mov ebx, 0
	int 0x80

multiplication:
	push ax
	push bx

	xor ecx, ecx 		;result value
	mult_loop:
		cmp bl, 0
		je end_mult
		test bl, 1
		jnz add_value
		jmp skip

		add_value:
			add cl, al

		skip:
			shl al, 1
			shr bl, 1

		jmp mult_loop

	end_mult:
	pop bx
	pop ax
	ret
