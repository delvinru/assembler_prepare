section .data
	array db 1,2,3,4,5,6,7,8,10,20,50,67
	len equ $-array

section .text
	global _start

_start:
	mov esi, array
	mov ecx, len
	mov bl, 10
	call binary_search
	mov eax, 1
	mov ebx, 0
	int 0x80

binary_search:
	push esi
	push ecx
	push ebx

	mov eax, 0		;left=0
	dec ecx
	mov ebx, ecx	;right=n-1

	xor ecx, ecx
	add ecx, eax
	add ecx, ebx	
	shr ecx, 1		;mid = (left+right)/2

	while_left_less_right:
		cmp eax, ebx
		jge end_search	;while (left <= right)

		xor ecx, ecx
		add ecx, eax
		add ecx, ebx	
		shr ecx, 1		;mid = (left+right)/2

		pop ebx
		cmp BYTE [esi+ecx], bl			;if arr[mid] == x
		push ebx
		je find_el						;find element; break
		jg decrease_right_border		;right = mid-1
		jl increase_left_border			;left= mid+1

		increase_left_border:
			mov eax, ecx
			inc eax
			jmp while_left_less_right

		decrease_right_border:
			mov ebx, ecx
			dec ebx
			jmp while_left_less_right


	find_el:
		lea edi, [esi+ecx]		;return addr of element
		jmp end

	end_search:
		lea edi, -1				;0xffff in di mean that element not found

	end:
	pop ebx
	pop ecx
	pop esi
	ret
