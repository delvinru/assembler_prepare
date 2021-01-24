section .data
  A dw 1337
  b db 128
  c db 56
  d db 1

section .bss
  r resb 1

section .text
  global _start

_start:
  mov ax, [A]
  mov bl, [b]
  mov cl, [c]
  mov dl, [d]
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  pusha

  add ax, bx  ;A+b
  sub ax, cx  ;(A+b)-c
  mov cl, dl
  shr ax, cl  ;((A+b)-c)>>d
  and ax, 0xff
  mov [r], al

  popa
  ret
