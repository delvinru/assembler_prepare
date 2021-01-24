BITS 32

section .bss
    filename:   resb 128
    statbuf:    resb 144
    fsize:      resd 1
    fd:         resb 1

section .data
    error     db 'Provide file name', 0xA, 0
    error_len equ $ - error
    sym       db '.'

section .text
    global _start

_start:
    ;parse arguments
    pop ebx                 ;argc
    dec ebx
    cmp ebx, 0
    je bad_input
    pop ebx                 ;argv[0]
    pop ebx                 ;argv[1] filename
    mov [filename], ebx

    mov eax, 0xc3           ;syscal for stat64()
    mov ecx, statbuf
    int 0x80

    ; get filesize from stat struct
    mov eax, [statbuf + 44]
    mov [fsize], eax

    mov eax, 0x05           ;open file
    mov ebx, [filename]
    mov ecx, 1
    mov edx, 0
    int 0x80
    mov [fd], eax           ;save file desriptor

    mov ecx, [fsize]
write_loop:
    push ecx
    mov eax, 4
    mov ebx, [fd]
    mov ecx, sym
    mov edx, 1
    int 0x80
    pop ecx
    loop write_loop

    jmp _exit

bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, error_len
    int 0x80
    jmp _exit

_exit:
    mov eax, 1
    mov ebx, 0
    int 0x80