section .data
  my_word db 'hello123', 0

section .text
  global _start

_start:
  mov esi, my_word
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  push esi

  mov ecx, 0
  xor eax, eax
  xor edx, edx

  my_loop:
    push ecx
    push eax
    lodsb
    xor edx, edx
    mov dl, al
    pop eax

    mov bl, cl
    mov cl, 8
    sub cl, bl  ;(8-i)

    shl edx, cl ;a_i * 2**(8-i)
    add eax, edx; h += value

    pop ecx
    cmp ecx, 8
    je exit_from_loop
    inc ecx
    jmp my_loop

  exit_from_loop:
  pop esi
  ret