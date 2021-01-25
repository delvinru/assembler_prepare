section .data
    C dw 333
    a db 5
    c db 4
    d db 6
    D dw 444

section .bss
    R resb 2

section .text
    global _start

_start:
    mov al, [a]
    mov cx, [C]
    mov bl, [c]
    mov dx,[D]
    mov bh,[d]

    call procedure

    mov eax,1
    mov ebx,0
    int 0x80

procedure:
    push ebx; этот пуш для того, чтобы сохранять все используемые регистры
    push ecx; тоже самое 
    push edx;тоже самое

    push ebx
    mov bh,0
    and cx,bx

    pop ebx

    mov bl,bh
    mov bh,0
    or bx,dx
    add cx,bx
    and cx,63

    mov ah,0
    sub ax,cx

    pop edx
    pop ecx
    pop ebx
    ret