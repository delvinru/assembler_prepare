section .data
  arr db 1,2,3,4,125,84,93,51,92,69
  len db 10

section .text
  global _start

_start:
  mov esi, arr
  mov ecx, [len]
  mov bl, 4

  call change

  mov eax, 1
  mov ebx, 0
  int 0x80

change:
  for_loop:
    lodsb
    cmp al, bl
    jle skip
    mov [esi-1], bl
    skip:
    loop for_loop
  ret
