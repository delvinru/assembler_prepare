%include "functions.asm"

section .data
    input_prompt db 'Введите имя файла: ', 0
    prepare db 'Size of file ', 0
    my_file db 'my_file', 0
    after_prepare db ' = 0x', 0

section .bss    
    statbuf resb 144
    input_filename resb 128

section .text
    global _start

_start:
    mov esi, input_prompt
    call print_str

    mov edi, input_filename
    call input_str

    mov esi, prepare
    call print_str

    mov esi, input_filename
    call print_str

    mov esi, after_prepare
    call print_str

    mov esi, input_filename
    mov ecx, statbuf
    call get_file_size

    mov edx, eax
    call print_hex

    mov eax, 1
    mov ebx, 0
    int 0x80
