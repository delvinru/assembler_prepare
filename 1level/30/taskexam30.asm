section .data
    A dw 333
    a db 5
    b db 4
    C dw 444

section .bss
    R resb 2

section .text
    global _start

_start:
    mov bl, [a]
    mov cx, [C]
    mov bh, [b]
    mov ax, [A]

    call procedure

    mov eax,1
    mov ebx,0
    int 0x80

procedure:
    push ebx; этот пуш для того, чтобы сохранять все используемые регистры
    push ecx; тоже самое 
    push ebx; этот пуш для того, чтобы сохранить bl

    mov ah,0; взять по модулю 256
    mov bh,0; мы убираем лишнее из 16-разрядного операнда 'б' маленькое
    sub ax,bx

    pop ebx
    mov ch,0; мы занулили старшую часть регистра cx. привели по модулю 256. cx по прежнему 16 разрядный
    mov bl,bh; переместили значение 'б' в младшую часть
    mov bh,0; занулили копию
    sub bx,cx; посчитали 2-ую скобку
    add ax,bx

    pop ecx
    pop ebx
    ret