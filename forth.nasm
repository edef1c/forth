; vim: ft=nasm
%include "util.nasm"
%include "dict.nasm"
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

global docol
docol:
  pushret rsi
  lea rsi, [rax+8]
  next

defcode 'exit', EXIT
  popret rsi
  next

defcode '+', PLUS
  pop rax
  add [rsp], rax
  next

global stdlib
stdlib equ wordlink
