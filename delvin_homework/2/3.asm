section .bss
    input resb 1

section .data
    msg db 'You input number', 0xA, 0xD, 0
    msg_len equ $-msg

section .text
    global _start

_start:
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 2
    int 0x80

    ; check if input less or equal 0x29 than it not number and jump to exit
    cmp [input], BYTE 0x29
    jle exit
    ; check if input greater or eqal 0x40 than it not number and jump to exit
    cmp [input], BYTE 0x40
    jge exit
    ; if all okay than input is number and just print message

print_msg:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

; just exit from program
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80