section .bss
    text resb 128

section .text:
    prompt db 'Enter array: ', 0
    prompt_len equ $ - prompt
    message db 'Changed index 1 and 3 to ', 0x41, ': ', 0
    message_len equ $ - message

section .data:
    global _start

_start:
    mov eax, 4  ;call sys_write
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80

    mov eax, 3  ;read array from stdin
    mov ebx, 0
    mov ecx, text
    mov edx, 128
    int 0x80

    mov eax, text
    mov byte[eax + 1], 0x41
    mov byte[eax + 3], 0x41

    mov eax, 4  ;call sys_write
    mov ebx, 1
    mov ecx, message
    mov edx, message_len
    int 0x80

    mov eax, 4  ;call sys_write
    mov ebx, 1
    mov ecx, text
    mov edx, 128
    int 0x80

    jmp _exit

_exit:
    mov eax, 1
    mov ebx, 0
    int 0x80