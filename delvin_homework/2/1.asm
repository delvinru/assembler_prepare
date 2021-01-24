section .data
    newline db 0x0A

section .bss
    num resb 1

section .text
    global _start

_start:
    ; read number from stdin
    mov eax, 3
    mov ebx, 0      ;stdin == 0
    mov ecx, num
    mov edx, 1
    int 0x80

    mov eax, [num]
    sub eax, 0x30   ;convert input num to integer
    mov ecx, eax    ;set counter for loop
    mov [num], BYTE 0x41

print_alph:
    push ecx

    ; print characket
    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 0x80

    ; print new line
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; increment value
    inc BYTE [num]
    pop ecx
    loop print_alph
    
; just exit from program
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80