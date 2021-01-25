;Написать процедуру сложения цифр двух байтов по модулю 16. В каждом байте содержится 2 шестнадцатеричные цифр.
section .text
  global _start

_start:
  mov bl, 250
  mov bh, 100
  call procedure
  mov eax, 1
  mov ebx, 0
  int 0x80

procedure:
  push ebx
  xor eax, eax
  add al, bl    ;
  add al, bh    ;bl+bh
  and al, 0x0f  ;(bl+bh)%16
  pop ebx
  ret
