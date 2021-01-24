section .bss
    fd resb 1
    buf resb 1024
    file1 resb 128
    file2 resb 128
    outfile resb 128

section .data
    nofile db 'Plz enter 2 filenames in arguments', 0xD, 0xA, 0
    nofile_len equ $ - nofile

section .text
    global _start

_start:
    ;check argc
    pop ebx         ;argc
    cmp ebx, 4
    jl bad_input

    pop ebx         ;skip argv[0]
    pop ebx         ;get argv[1]
    mov [file1], ebx
    pop ebx
    mov [file2], ebx
    pop ebx
    mov [outfile], ebx

    ; create outfile
    mov eax, 8      ;ebx store outfile name
    mov ecx, 420
    int 0x80

    ;open file 1
    mov eax, 5
    mov ebx, [file1]
    mov ecx, 0
    mov edx, 0
    int 0x80
    mov [file1], eax

    ;open file 2
    mov eax, 5
    mov ebx, [file2]
    mov ecx, 0
    mov edx, 0
    int 0x80
    mov [file2], eax

    ; open outfile for write
    mov eax, 5
    mov ebx, [outfile]
    mov ecx, 2      ;O_WRITE
    int 0x80
    ; save register to outfile
    mov [outfile], eax

read_file1:
    mov eax, 3
    mov ebx, [file1]
    mov ecx, buf
    mov edx, 1024
    int 0x80
    ; if reached file end just exit from program
    cmp eax, 0
    je read_file2
    call write_to_output
    jmp read_file1

read_file2:
    mov eax, 3
    mov ebx, [file2]
    mov ecx, buf
    mov edx, 1024
    int 0x80
    ; if reached file end just exit from program
    cmp eax, 0
    je exit
    call write_to_output
    jmp read_file2

write_to_output:
    mov esi, buf
    call strlen     ;return strlen of buffer

    mov ebx, [outfile]
    mov ecx, buf
    mov edx, eax
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
    ; close all file that was opened
    mov eax, 6
    mov ebx, [file1]
    int 0x80

    mov eax, 6
    mov ebx, [file2]
    int 0x80

    mov eax, 6
    mov ebx, [outfile]
    int 0x80

    ; normal exit
    mov eax, 1
    mov ebx, 0
    int 0x80

strlen:
    mov ebx, 0
strlen_loop:
    cmp BYTE [esi+ebx], 0
    je strlen_end
    inc ebx
    jmp strlen_loop
strlen_end:
    mov eax, ebx
    ret