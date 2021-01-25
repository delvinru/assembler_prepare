section .data

a db 5

b db 4

C dw 333

D dw 444


section .bss

	r resb 1

section .text
	global _start

_start:

mov al,[a]

mov bl,[b]

mov cx, [C]

mov dx, [D]

call procedure

mov [r],al
mov eax,1
mov ebx,0
int 0x80


procedure:



push ebx
push ecx
push edx

mov ah,0; Делается для того, чтобы очистить возможный мусор
mov bh,0

OR ax,bx

AND dx,cx

SUB ax,cx

AND ax,31; приведение по модулю 32

pop edx
pop ecx
pop ebx


ret
