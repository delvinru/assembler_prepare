BITS 32

section .bss
    string resb 255
    sym    resb 1
    size   resb 1
    tmp    resb 1

section .data
    error     db 'Provide string and symbol', 0xA, 0
    error_len equ $ - error
    kek       db 'lol find', 0xA, 0
    kek_len equ $ - kek

section .text
    global _start

_start:
    ;parse arguments
    pop ebx                 ;argc
    dec ebx
    cmp ebx, 1
    jle bad_input
    pop ebx                 ;argv[0]
    pop ebx                 ;argv[1] filename
    mov [string], ebx

    pop ebx                 ;argv[2] symbols
    mov eax, [ebx]
    mov [sym], al

    mov esi, [string]
    call strlen             ;eax store string len
    ; mov [size], eax

    mov ecx, eax
    mov edi, [string]
    mov al, [sym]
count_symb:
; count symbol in string
    cld                     ;clear direction flag
    repne scasb
    je found
    jmp not_found

found:
    inc edx
not_found:
    cmp ecx, 0
    je print_int
    jmp count_symb

; get value from edx
print_int:
    ; dec ebx
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
    

strlen:
    xor ebx, ebx
strlen_loop:
    cmp BYTE [esi+ebx], 0
    je strlen_end
    inc ebx
    jmp strlen_loop
strlen_end:
    mov eax, ebx
    ret

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