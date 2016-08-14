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
  xor rsi, rsi

  mov rax, RUN
  jmp [rax]

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

section .data
align 4096
resb 4096
retstack:
