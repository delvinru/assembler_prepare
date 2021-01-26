; Даны две последовательности a_i и b_i. Написать процедуру поэлементного сложения двух последовательностей по модулю 26,
; не используя команды переходов и деления.
section .data
	seq1 db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
	len1 equ $ - seq1
	seq2 db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
	len2 equ $ - seq1

section .bss
	out_seq resb 25

section .text
	global _start

_start:
	mov esi, seq1
	mov edi, seq2
	mov ebx, out_seq
	mov ecx, len1
	call procedure
	mov eax, 1
	mov ebx, 0
	int 0x80

procedure:
	pusha
	dec ecx
	;ecx contain count of element in array
	addition_loop:
		mov dl, BYTE [esi+ecx]
		add dl, BYTE [edi+ecx]
		mov al, dl						;save to tmp value
		sub dl, 26						;dl - 26
		cmovc dx, ax					;if carry flag was set, it's mean that value bigger than 26 and we should just mov to ebx just dl
		mov BYTE [ebx+ecx], dl
		loop addition_loop
	;correction value, because loop don't check when ecx equal to 0
	;now ecx equal to zero
	mov dl, BYTE [esi+ecx]
	add dl, BYTE [edi+ecx]
	mov al, dl						;save to tmp value
	sub dl, 26						;dl - 26
	cmovc dx, ax					;if carry flag was set, it's mean that value bigger than 26 and we should just mov to ebx just dl
	mov BYTE [ebx+ecx], dl
	popa
	ret
