section .data
  a db 2
  b db 5
  A dw 1339

section .bss
  R resb 2

section .text
  global _start

_start:
  mov al, [a]
  mov bl, [b]
  mov cx, [A]
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  push eax
  push ebx

  mov ax, cx
  mov edx, 0
  mov ebx, 8
  div ebx
  mov cx, dx

  pop ebx
  pop eax
  and al, bl   ;b and a
  xor ax, cx
  mov [R], ax
  ret
