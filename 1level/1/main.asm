section .data
    arr db 45, 35, 12, 3, 0, 7, 34 ;init array for test
    len db 7    ;size of array

section .text
    global _start

_start:
    mov esi, arr
    mov ecx, [len]
    mov bl, 1
    call search_element

    mov eax, 1
    mov ebx, 0
    int 0x80

search_element:
    through_arr:
        lodsb 
        cmp al, bl
        je find
        loop through_arr

    not_find:
    mov edi, -1
    ret

    find:
    mov edi, esi
    ret