; vim: ft=nasm
%include "dict.nasm"
%include "vm.nasm"

extern RUN, linker
defvar latest

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

section .text
global docol
docol:
  pushret rsi
  lea rsi, [rax+8]
  next

global dovar
dovar:
  mov rbx, [rax+8]
  push rbx
  next

defcode 'exit', EXIT
  popret rsi
  next

defcode '+', PLUS
  pop rax
  add [rsp], rax
  next
