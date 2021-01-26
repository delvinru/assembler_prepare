; Написать процедуру сортировки по убыванию массива однобайтных элементов

; Complete
; Известный баг: почему-то не хочет работать с числами большими чем 0xF0.
; Не понимаю, с чем это может быть связано

section .data
	array db 15,1,5,2,7,4,56
	len equ $ - array

section .text
	global _start

_start:
	mov esi, array
	mov ecx, len
	call procedure
	mov eax, 1
	mov ebx, 0
	int 0x80

procedure:
	;save register
	push esi
	push ecx

	; dec ecx
	;prepare registers
	;create bubble sort
	xor eax, eax
	for_i:
		cmp eax, ecx
		jge end_sort
		xor edx, edx
		for_j:
			mov ebx, ecx
			sub ebx, eax
			dec ebx
			cmp edx, ebx
			jge end_for_j

			;do swap, check and other shit
			mov bh, BYTE [esi+edx]		;arr[j]
			mov bl, BYTE [esi+edx+1]	;arr[j+1]
			cmp bh, bl
			jl swap_elements
			jmp skip_swap

			swap_elements:
				mov [esi+edx], bl		;arr[j]   = arr[j+1]
				mov [esi+edx+1], bh		;arr[j+1] = arr[j]

			;increase counter
			skip_swap:
			inc edx
			jmp for_j

		end_for_j:
			inc eax
			jmp for_i

	end_sort:
	;restore register
	pop ecx
	pop esi
	ret
