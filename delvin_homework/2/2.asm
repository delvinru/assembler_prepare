section .bss
    num1 resb 1
    num2 resb 1
    tmp resb 1

section .data
    plus db '+'
    equal db '='

section .text
    global _start

_start:
    ; send C^d - to send EOF to stdin and read exactly 1 byte
    ; read num1
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, plus
    mov edx, 1
    int 0x80

    ; read num2
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, equal
    mov edx, 1
    int 0x80

    ; convert ot number
    sub [num1], BYTE 0x30
    sub [num2], BYTE 0x30

addition:
    ; move one byte to al
    mov al, BYTE [num1]
    add eax, [num2]
    ; compare and if eax > 10 jump to print two digits else one digit
    cmp eax, 0x0A
    jge print_double_digit
    jmp print_one_digit

print_double_digit:
    push eax

    mov [tmp], BYTE 0x31
    mov eax, 4
    mov ebx, 1
    mov ecx, tmp
    mov edx, 1
    int 0x80

    pop eax
    sub eax, 0x0A
    add eax, 0x30       ;convert to ascii sym

    mov [tmp], eax
    mov eax, 4
    mov ebx, 1
    mov ecx, tmp
    mov edx, 1
    int 0x80
    jmp exit

print_one_digit:
    add eax, 0x30       ;convert to ascii sym
    mov [tmp], eax
    mov eax, 4
    mov ebx, 1
    mov ecx, tmp
    mov edx, 1
    int 0x80
    jmp exit

; just exit from program
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80