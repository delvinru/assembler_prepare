#!/bin/bash

echo "section .data" >> main.asm

echo "" >> main.asm

echo "section .text" >> main.asm
echo "  global _start" >> main.asm

echo "" >> main.asm
echo "_start:" >> main.asm

echo "  call procedure" >> main.asm

echo "  mov eax, 1" >> main.asm
echo "  mov ebx, 0" >> main.asm
echo "  int 0x80" >> main.asm

echo "" >> main.asm
echo "procedure:" >> main.asm
echo "  ret" >> main.asm