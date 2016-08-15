; vim: ft=nasm
%include "util.nasm"
%include "def.nasm"
%include "vm.nasm"
%include "stack.nasm"
%include "sys.nasm"

extern RUN

global _start
_start:
  cld
  mov rbp, retstack
  callword RUN
  ud2

section .data
align 4096
times 4096 db 0
retstack:

defcode '+', PLUS
  pop rax
  add [rsp], rax
  next

global stdlib
stdlib equ wordlink
