section .bss
    string resb 256

section .data
    alph        db '0123456789', 0
    substituion db '7492548163', 0

section .text
    global _start

_start:
    call input_string

    mov edi, string
    lea ebx, [substituion]
    xor ecx, ecx
sub_loop:
    cmp BYTE [edi], 0x00
    je print_str

    mov al, BYTE [edi]
    sub al, 0x30
    xlat
    mov [string+ecx], BYTE al

    inc edi
    inc ecx
    jmp sub_loop

print_str:
    mov eax, 4
    mov ebx, 1
    mov ecx, string
    mov edx, 256
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
    jmp input_loop

just_ret:
    mov BYTE [edi], 0
    ret

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
