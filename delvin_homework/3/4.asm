section .bss
    fd_orig resb 1
    fd_temp resb 1
    buf resb 1024

section .data
    tempfile db 'tmp_98293847298.txt', 0
    nofile db 'Plz enter 1 filename in arguments', 0xD, 0xA, 0
    nofile_len equ $ - nofile

section .text
    global _start

_start:
    pop ebx         ;argc
    cmp ebx, 2
    jl bad_input

    pop ebx         ;skip argv[0]

    ; open file
    pop ebx
    push ebx

    mov eax, 5
    mov ecx, 0      ;O_READ
    mov edx, 0
    int 0x80
    mov [fd_orig], al

    ; create tmp_file
    mov eax, 8      ;ebx store outfile name
    mov ebx, tempfile
    mov ecx, 420
    int 0x80

    ;open temp file
    mov eax, 5
    mov ebx, tempfile
    mov ecx, 2      ;O_WRITE
    mov edx, 0
    int 0x80
    mov [fd_temp], al

read_file:
    xor ebx, ebx
    mov eax, 3
    mov bl, BYTE [fd_orig]
    mov ecx, buf
    mov edx, 1024
    int 0x80
    ; if end stop read
    cmp eax, 0
    je exit
    call write_to_temp
    jmp read_file

write_to_temp:
    mov esi, buf
    call strlen

    push eax
    mov esi, buf
    call cyclic_rotate
    pop eax

    mov edx, eax
    mov ecx, buf
    xor ebx, ebx
    mov bl, BYTE [fd_temp]
    mov eax, 4
    int 0x80
    ret

bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, nofile
    mov edx, nofile_len
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

exit:
    mov eax, 6
    xor ebx, ebx
    mov bl, BYTE [fd_orig]
    int 0x80

    mov eax, 6
    xor ebx, ebx
    mov bl, BYTE [fd_temp]
    int 0x80

    mov eax, 10
    pop ebx
    push ebx
    int 0x80

    pop ebx
    mov ecx, ebx
    mov eax, 38
    mov ebx, tempfile
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

; eax store len
cyclic_rotate:
    mov ecx, eax        ;init loop
    xor ebx, ebx
cyclic_rotate_loop:

    xor eax, eax
    mov al, BYTE [esi+ebx]
    ror al, 4
    mov BYTE [esi+ebx], al
    inc ebx

    loop cyclic_rotate_loop
cyclic_rotate_end:
    ret

strlen:
    xor ebx, ebx
strlen_loop:
    cmp BYTE [esi+ebx], 0
    je strlen_end
    inc ebx
    jmp strlen_loop
strlen_end:
    mov eax, ebx
    ret