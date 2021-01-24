section .bss
    i resb 1    ;1 byte memory for i

section .text:
    global _start   ;enter point

_start:
    mov eax, 3  ;call read
    mov ebx, 0  ;stdin
    mov ecx, i  ;i
    mov edx, 1  ;len i
    int 0x80    ;syscall

    mov eax, 4  ;call write
    mov ebx, 1  ;stdout
    add [i], BYTE 1 ;add to i 1 byte, for next ascii char
    mov ecx, i  ;i
    mov edx, 1  ;len i
    int 0x80    ;syscall

    mov eax, 1  ;return 0
    mov ebx, 0
    int 0x80
