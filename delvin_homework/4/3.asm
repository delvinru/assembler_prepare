section .bss
    num1 resb 2
    num2 resb 2
    num  resb 1

section .data
    wrong   db 'Enter 2 numbers in argc', 0xA, 0xD, 0
    wrong_len equ $-wrong
    outstr  db 'Sub = ', 0
    outstr_len equ $ - outstr
    carrynum db '-', 0
    newline db 0xA, 0xD, 0

section .text
    global _start

_start:
    pop ebx         ;argc
    cmp ebx, 3
    jl bad_input

    ;get input from argc
    pop ebx         ;argv[0]
    pop ebx
    mov eax, [ebx]
    mov [num1], ax
    pop ebx
    mov eax, [ebx]
    mov [num2], ax

    ;convert ascii to decimal
    xor eax, eax
    mov al, BYTE [num1 + 1]
    cmp al, 0x00
    je onenumber_ax
    jne twonumber_ax

onenumber_ax:
    mov al, BYTE [num1]
    sub al, 0x30
    jmp prepare_bx

twonumber_ax:
    mov ah, BYTE [num1]
    sub al, 0x30
    sub ah, 0x30

    ;tmp var
    mov cl, al
    ;pack value in register
    shr ax, 4
    or al, cl

prepare_bx:
    xor ebx, ebx
    mov bl, BYTE [num2 + 1]
    cmp bl, 0x00
    je onenumber_bx
    jne twonumber_bx

onenumber_bx:
    mov bl, BYTE [num2]
    sub bl, 0x30
    jmp substruction

twonumber_bx:
    sub bl, 0x30
    mov bh, BYTE [num2]
    sub bh, 0x30

    ;tmp var
    mov cl, bl
    ;pack value in register
    shr bx, 4
    or bl, cl

substruction:
    ; now ax store first value
    ; now bx store second value
    nop
    nop
    nop
    sub al, bl
    das                ;decimal adjust for addition
    push ax
    pushf               ;save carry flag

    ; print 'Sub = '
    mov eax, 4
    mov ebx, 1
    mov ecx, outstr
    mov edx, outstr_len
    int 0x80

    popf                ;restore carry flag
    jc carryflag       ;if carry flag was set
    jmp nocarryflag

carryflag:
    mov eax, 4
    mov ebx, 1
    mov ecx, carrynum
    mov edx, 1
    int 0x80

    ;sub 100 from ax
    pop ax
    xor ecx, ecx
    mov cl, al
    mov al, 0x00
    mov ah, 0x01
    sub al, cl
    das
    and ax, 0xFF
    jmp nocarryflag_after_carry

nocarryflag:
    pop ax

nocarryflag_after_carry:
    xor ecx, ecx
    mov cl, al
    push cx
    shr al, 4       ;rotate half byte in last part
    add al, 0x30
    mov BYTE [num], al

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 0x80

    pop cx
    and cl, 0x0F
    add cl, 0x30
    mov BYTE [num], cl

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 0x80

    jmp exit

bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, wrong
    mov edx, wrong_len
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80