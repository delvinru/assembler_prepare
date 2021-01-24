section .data
    message db 'Hello, world! Something happpen in city', 0

section .bss
    buffer resb 1024

section .text:
    global _start

_start:
    ; Prepare for function call
    mov esi, message
    mov edi, buffer
    call split_token

    ;exit
    mov eax, 1
    mov ebx, 0
    int 0x80

split_token:
    cmp BYTE [esi], 0x20
    je change_edi
    cmp BYTE [esi], 0x0D
    je change_edi
    cmp BYTE [esi], 0
    je change_edi

    inc esi
    jmp split_token
change_edi:
    mov edi, esi
    ret
