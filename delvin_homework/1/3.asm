section .bss
    a resb 1
    output resb 2

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

    mov ebx, 2
    mul ebx         ;eax = a * 2 
    aam             ;(Ascii Adjust after Multiply) - коррекция результата после умножения
    add ax, 0x3030  ; добавляем к старшему и младему регистрам отступ для ascii
    mov [output], ah
    mov [output + 1], al

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 2
    int 0x80

    jmp _exit

_exit:
    mov eax, 1
    mov ebx, 0
    int 0x80