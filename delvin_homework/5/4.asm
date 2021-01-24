section .bss
    string resb 256
    tmp resb 4
    str_size resb 1

section .data
    gamma dd 0x44434241
    error db 'the string is not 4-byte aligned', 0xA, 0
    error_len equ $ - error

section .text
    global _start

_start:
    call input_string

    mov eax, [str_size]
    xor edx, edx
    mov ebx, 4

    div ebx
    cmp edx, 0
    jne not_do

    cld
    lea esi, [string]
    xor ecx, ecx
start_xor:
    mov eax, [gamma]
    xor DWORD [esi], eax

    cmp cl, [str_size]
    je end
    add esi, 4
    add cl, 4
    jmp start_xor

end:
    
    mov esi, string
    call print_str
    jmp exit


not_do:
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, error_len
    int 0x80
    jmp exit

print_str:
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, [str_size]
    int 0x80
    jmp exit

input_string:
    mov edi, string

input_loop:
    mov eax, 3
    mov ebx, 0
    mov ecx, edi
    mov edx, 1
    int 0x80
    
    cmp BYTE [edi], 0x0A
    jz just_ret
    inc edi
    inc BYTE [str_size]
    jmp input_loop

just_ret:
    mov BYTE [edi], 0
    ret

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80