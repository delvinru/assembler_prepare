section .data
  a db 1
  C dw 1
  D dw 1

section .bss
  r resb 1

section .text
  global _start

_start:
  mov al, [a]
  mov cx, [C]
  mov dx, [D]
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  pusha
  add cx, dx

  xor dx, dx
  mov dl, al

  and ax, cx
  sub ax, dx

  and ax, 0xff
  mov [r], al
  popa
  ret
