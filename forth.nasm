; vim: ft=nasm
%include "dict.nasm"
%include "vm.nasm"

extern RUN
extern __dict_start, __dict_end
defvar latest

global _start
_start:
  cld
linker:
  xor rbx, rbx
  mov rsi, __dict_start
.next:
  lodsq
  mov [rax], rbx
  mov rbx, rax
  cmp rsi, __dict_end
  jne .next
  mov [var_latest], rbx
main:
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
