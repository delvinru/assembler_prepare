#!/bin/bash

echo "section .data" >> main.asm

echo "" >> main.asm

echo "section .text" >> main.asm
echo -e "\tglobal _start" >> main.asm

echo "" >> main.asm
echo "_start:" >> main.asm

echo -e "\tcall procedure" >> main.asm

echo -e "\tmov eax, 1" >> main.asm
echo -e "\tmov ebx, 0" >> main.asm
echo -e "\tint 0x80" >> main.asm

echo "" >> main.asm
echo "procedure:" >> main.asm
echo -e "\tret" >> main.asm
