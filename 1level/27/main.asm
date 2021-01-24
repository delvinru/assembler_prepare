section .data
  A dw 1337
  b db 59
  c db 1

section .bss
  R resw 1

section .text
  global _start

_start:
  mov ax, [A]
  mov bl, [b]
  mov cl, [c]
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  pusha
  not ax
  or bx, ax   ;(b ∨ ¬A)
  and ax, bx  ;(A ∧ (b ∨ ¬A))
  shl ax, cl  ;(A ∧ (b ∨ ¬A)) << c
  mov [R], ax
  popa
  ret