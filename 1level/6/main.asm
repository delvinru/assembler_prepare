; Дана подстановка. Реализовать процедуру простой замены текста по подстановке.
section .data
  text db 'simple text', 0
  len equ $ - text
  alph db 'abcdefghijklmnopqrstuvwxyz', 0
  substituion db 'lyjsifoqwxngctedkapbvhmuzr', 0

section .text
  global _start

_start:
  ; Программа работает с буквами нижнего регистра, а также со словами
  ; разделенными пробелом
  mov esi, text
  mov ebx, substituion
  mov ecx, len
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  my_loop:
    lodsb
    cmp al, 0
    je exit
    cmp al, 0x20
    je skip
    sub al, 0x61
    xlat
    mov BYTE [esi-1], al
    skip:
    loop my_loop
  exit:
  ret
