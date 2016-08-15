; vim: ft=nasm
%include "util.nasm"
%include "def.nasm"
%include "vm.nasm"
%include "stack.nasm"
%include "sys.nasm"

global main
main:
  cld
  mov rbp, retstack
  callword RUN
  ud2

defword 'run', RUN, \
  LIT, 'h', EMIT,   \
  LIT, 'e', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'o', EMIT,   \
  LIT, ',', EMIT,   \
  LIT, ' ', EMIT,   \
  LIT, 'w', EMIT,   \
  LIT, 'o', EMIT,   \
  LIT, 'r', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'd', EMIT,   \
  LIT, 0Ah, EMIT,   \
  LIT, 42, DUP, PLUS, SYS_EXIT

defcode '+', PLUS
  pop rax
  add [rsp], rax
  next

section .data
align 4096
times 4096 db 0
retstack:
