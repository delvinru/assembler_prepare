section .bss
    a resb 1
    q resb 1
    r resb 1

section .data:
    global _start

_start:
    mov eax, 3  ;read number from stdin
    mov ebx, 0
    mov ecx, a
    mov edx, 1
    int 0x80

    mov eax, [a]    ;prepare for sum
    sub eax, 0x30

    mov edx, 0      ;edx store remainder
    mov ebx, 3      ;eax store quiotient
    div ebx

    add eax, 0x30
    mov [q], eax
    add edx, 0x30
    mov [r], edx

    mov eax, 4
    mov ebx, 1
    mov ecx, q
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, r
    mov edx, 1
    int 0x80

    jmp _exit

_exit:
    mov eax, 1
    mov ebx, 0
    int 0x80