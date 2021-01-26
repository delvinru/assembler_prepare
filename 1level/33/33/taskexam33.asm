section .data

a db 12
b db 15
c db 5



section .bss

	R resb 2

section .text

global _start

_start:

mov al,[a]
mov bl,[b]
mov cl,[c]

call taskexam

mov eax,1
mov ebx,0
int 0x80

taskexam:


push ebx
push ecx

mov ah,al; переместили в старшую часть регистра ax  значение младшей части
mov bh,bl; переместили в старшую часть регистра bx  значение младшей части


NOT al
OR al,bl

OR al,ah



mul bl

shl ax,cl


pop ecx
pop ebx

ret
