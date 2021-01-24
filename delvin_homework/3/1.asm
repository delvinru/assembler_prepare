section .bss
    fd resb 1
    buf resb 1024

section .data
    nofile db 'Plz enter filename in arguments', 0xD, 0xA, 0
    nofile_len equ $ - nofile

section .text
    global _start

_start:
    ;check argc
    pop ebx     ;argc
    cmp ebx, 2
    jl bad_input
    
    pop ebx         ;skip argv[0]
    pop ebx         ;get argv[1]
    
    ;open file
    mov eax, 5
    mov ecx, 0
    mov edx, 0
    int 0x80

    ;save file descriptor to var
    mov [fd], BYTE al

    call read_file

    ;close file
close_file:
    mov eax, 6
    mov ebx, [fd]
    int 0x80

    jmp exit

read_file:
    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    mov eax, 3
    mov bl, BYTE [fd]
    mov ecx, buf
    mov edx, 1024
    int 0x80
    ; if reached file end just exit from program
    cmp eax, 0
    je close_file

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1024
    int 0x80
    
    jmp read_file

bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, nofile
    mov edx, nofile_len
    int 0x80
    jmp exit

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80