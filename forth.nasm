; vim: ft=nasm
%include "dict.nasm"
%include "vm.nasm"
%include "stack.nasm"

extern RUN
extern __dict_start, __dict_end

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
  mov [dictptr], rbx
main:
  mov rbp, retstack
  callword RUN
  ud2

section .bss
align 4096
resb 4096
retstack:
global dictptr
dictptr: resq 1

section .text
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
