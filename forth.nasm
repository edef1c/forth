; vim: ft=nasm
%include "forth"
extern RUN, linker

global _start
_start:
  cld
  call linker
  mov rbp, retstack
  callword RUN
  ud2

section .bss
align 4096
resb 4096
retstack:
