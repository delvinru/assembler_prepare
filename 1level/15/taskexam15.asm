section .data

	arr1 db 0, 2, 3, 6, 5, 4, 1, 5
	arr2 db 4, 5, 6, 3, 2, 0, 6, 4

	len dw 8; размер последовательности

section .bss

arr3  resb 8


section .text
	global _start

_start:

mov ebx, arr3; адрес получившейся последовательности

mov esi, arr1; адрес 1-ой последовательности

mov edi, arr2; адрес 2-ой последовательности

mov ecx,[len]


call taskexam

mov eax,1
mov ebx,0
int 0x80


taskexam:

cmp cx,0

jz end_of_null

push esi

push edi

push ebx

push ecx

push eax

cld; это для того, чтобы cld двигалось вперёд по памяти

begin_loop:


lodsb

mov dl,[edi]

ADD al,dl; сложили 2 последовательности

AND al,7; взяли по модулю

mov [ebx],al; поместили в последовательность для результата

inc edi; везде где используется косвенная адресация надо делать инкрементирование

inc ebx; тоже самое

dec cx; уменьшаем счётчик

cmp cx,0

jnz begin_loop



pop edi
pop esi
pop ebx
pop ecx
pop eax

end_of_null:

ret
