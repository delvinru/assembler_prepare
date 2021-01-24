section .data
    string      db 0xA, 0xD, 'EDX = ', 0
    string_len  equ $ - string
    predict     db 'In binary, but why not? :)', 0
    predict_len equ $ - predict
    one_bit     db '1', 0
    zero_bit    db '0', 0

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, predict
    mov edx, predict_len
    int 0x80

    mov edx, 0xDEADBEEF
    call print_register

    mov edx, 0xCAFEBABE
    call print_register

    mov edx, 0x1337CAFE
    call print_register

    ;normal exit from program
    mov eax, 1
    mov ebx, 0
    int 0x80

print_register:
    push edx

    ; print 'EDX = '
    mov eax, 4
    mov ebx, 1
    mov ecx, string
    mov edx, string_len
    int 0x80

    pop edx
    xor ecx, ecx
    mov ecx, 31
print_register_loop:
    push edx
    push ecx
    ; Print value from edx
    bt edx, ecx
    jc print_one_bit

print_zero_bit:
    mov eax, 4
    mov ebx, 1
    mov ecx, zero_bit
    mov edx, 1
    int 0x80
    jmp print_register_loop_end

print_one_bit:
    mov eax, 4
    mov ebx, 1
    mov ecx, one_bit
    mov edx, 1
    int 0x80

print_register_loop_end:
    pop ecx
    pop edx
    cmp ecx, 0
    je just_ret
    dec ecx
    jmp print_register_loop


just_ret:
    ret