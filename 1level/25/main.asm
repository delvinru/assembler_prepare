section .data
  A dw 1337
  b db 17
  B dw 456
  c db 10

section .bss
  r resb 1

section .text
  global _start

_start:
  mov ax, [A]
  mov bl, [b]
  mov cx, [B]
  mov dl, [c]

  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  pusha       ;save all registers
  xor ax, bx  ;(A^b)
  xor cx, dx  ;(c^B)
  or ax, cx   ;(A^b) | (c^B)

  ;by modulo 64
  mov edx, 0
  mov ebx, 64
  div ebx
  mov [r], dl
  popa        ;restore all registers
  ret
