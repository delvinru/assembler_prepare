section .text
    global _start

_start:
    ; init eax for Gray code
    mov eax, 4

    call gray_code

    mov eax, 1
    mov ebx, 0
    int 0x80

gray_code:
    mov ecx, eax
    shr eax, 1
    xor eax, ecx
    ret
