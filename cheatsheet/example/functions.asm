; Вспомогательные функции для работы с программами, чтобы не писать каждый раз велосипеды

;Аргументы: esi - адрес строки
;Usage:
;   mov esi, string
;   call strlen
;Возвращается длина строки в регистре eax
strlen:
    push esi
    push ebx
    xor ebx, ebx
strlen_loop:
    cmp BYTE [esi+ebx], 0       ;check end string or not
    je strlen_end
    inc ebx
    jmp strlen_loop
strlen_end:
    mov eax, ebx
    pop ebx
    pop esi
    ret


;Аргументы: esi - адрес строки
;Usage:
;   mov esi, string
;   call print_str
;Функция ничего не возвращает
print_str:
    pusha
    call strlen         ;get strlen from esi
    mov edx, eax
    mov eax, 4          ;syscall for write
    mov ebx, 1          ;print in stdout
    mov ecx, esi
    int 0x80
    popa
    ret


;Аргументы: edx - значение регистра, которое нужно распечатать
;Usage:
;   mov edx, 100
;   call print_hex
;Ничего не возвращается
print_hex:
    pusha
    mov ecx, 28
print_hex_loop:
    push ecx
    push edx

    shr edx, cl
    and edx, 0xF
    cmp edx, 0x9
    jg add_0x37

add_0x30:                   ;if we get number than we should add 0x30
    add edx, 0x30
    jmp print_hex_call

add_0x37:                   ;if we get letter than we should add 0x37
    add edx, 0x37

print_hex_call:
    push dx                 ;save value on stack, so ass not to use additional memory

    mov eax, 4
    mov ebx, 1
    mov ecx, esp            ;use head of stack like pointer to value
    mov edx, 1
    int 0x80

    pop dx

    pop edx
    pop ecx
    cmp cl, 0
    je print_hex_exit

    sub cl, 4
    jmp print_hex_loop

print_hex_exit:
    popa
    ret


;Аргументы: esi - имя файла, ecx - buffer for structure
;Usage:
;   mov esi, filename
;   mov ecx, statbuf
;   call get_file_size
get_file_size:
    push ebx
    mov eax, 0xc3
    mov ebx, esi
    int 0x80

    mov eax, [ecx+44]

    pop ebx
    ret


;Аргументы: esi - адрес, куда нужно будет сохранить введеную строку
;Usage:
;   mov edi, user_input
;   call input_str
;Функция ничего не возвращает
input_str:
    pusha
input_str_loop:
    mov eax, 3
    mov ebx, 0
    mov ecx, edi
    mov edx, 1
    int 0x80

    cmp BYTE [edi], 0x0A    ;if user press enter, than end input
    jz input_str_end
    inc edi
    jmp input_str_loop

input_str_end:
    mov BYTE [edi], 0
    popa
    ret
