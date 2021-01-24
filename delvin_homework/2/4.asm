section .bss
    num1 resb 1
    num2 resb 1

section .data
    more db 0xA, 0xD, 'Multiplication more than 50', 0xA, 0xD, 0
    more_len equ $ - more
    less db 0xA, 0xD, 'Multiplication less than 50', 0xA, 0xD, 0
    less_len equ $ - less

section .text
    global _start

_start:
    ; send C^d - to send EOF to stdin and read exactly 1 byte
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 1
    int 0x80

    sub [num1], BYTE 0x30
    sub [num2], BYTE 0x30

    mov al, BYTE [num1]
    xor ecx, ecx
    mov cl, BYTE [num2]
    mul ecx
    cmp eax, 50
    jg print_more
    jl print_less

print_more:
    mov eax, 4
    mov ebx, 1
    mov ecx, more
    mov edx, more_len
    int 0x80
    jmp exit

print_less:
    mov eax, 4
    mov ebx, 1
    mov ecx, less
    mov edx, less_len
    int 0x80
    jmp exit

; just exit from program
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80