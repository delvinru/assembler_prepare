BITS 32

section .bss
    filename:   resb 128
    statbuf:    resb 144
    fsize:      resd 1
    tmp:        resb 1

section .data
    error     db 'Provide file name', 0xA, 0
    error_len equ $ - error
    size_str  db 'Size = 0x', 0
    size_str_len equ $ - size_str

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

    mov eax, 4
    mov ebx, 1
    mov ecx, size_str
    mov edx, size_str_len
    int 0x80

    mov edx, [fsize]
    jmp print_int 

    jmp _exit

; get value from edx
print_int:
    mov ecx, 28
print_int_loop:
    push ecx
    push edx

    shr edx, cl
    and edx, 0xF
    cmp edx, 0x9
    jle add_0x30
    jmp add_0x37

add_0x30:
    add edx, 0x30
    jmp print_call

add_0x37:
    add edx, 0x37

print_call:
    mov [tmp], BYTE dl

    mov eax, 4
    mov ebx, 1
    mov ecx, tmp
    mov edx, 1
    int 0x80

    pop edx
    pop ecx
    cmp cl, 0
    je _exit

    sub cl, 4
    jmp print_int_loop
    

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
