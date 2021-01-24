section .data
  string db 'Hello, world! Hello, buddy, how are you? Meet me today.', 0

section .text
  global _start

_start:
  mov esi, string
  call change
  mov eax, 1
  mov ebx, 0
  int 0x80

change:
  my_loop:
    cmp BYTE [esi], 0
    je exit_from_loop

    first_check:
      cmp BYTE [esi], '.'
      je change_dot
      jne second_check

    change_dot:
      mov BYTE [esi], ','
      jmp skip

    second_check:
      cmp BYTE [esi], ','
      je change_semicolon
      jne skip

    change_semicolon:
      mov BYTE [esi], '.'

    skip:
    inc esi
    jmp my_loop

  exit_from_loop:
  ret