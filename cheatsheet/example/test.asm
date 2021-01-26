%include "functions.asm"

section .data
    mystring db 'Hello, world',0xA, 0xD, 0
    for_print_hex db 'edx = 0x', 0
    prepare db 'Size of file ', 0
    my_file db 'my_file', 0
    after_prepare db ' = 0x', 0

section .bss    
    statbuf resb 144

section .text
    global _start

_start:
    pop ebx                 ;skip argc
    pop ebx                 ;skip argv[0]
    pop ebx

    mov esi, prepare
    call print_str

    mov esi, ebx
    call print_str

    mov esi, after_prepare
    call print_str

    mov esi, ebx
    mov ecx, statbuf
    call get_file_size

    mov edx, eax
    call print_hex

    mov eax, 1
    mov ebx, 0
    int 0x80
