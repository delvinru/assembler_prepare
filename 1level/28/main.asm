section .data
  C dw 1
  A dw 1
  c db 1
  B dw 1

section .bss
  R resw 1

section .text
  global _start

_start:
  mov ax, [A]
  mov bx, [B]
  mov cx, [C]
  mov dl, [c]
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  pusha
  
  popa
  ret
