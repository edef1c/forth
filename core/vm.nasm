; vim: ft=nasm
%include "vm"
%include "dict"

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

defcode 'jump', JUMP
  pop rax
  jmp [rax]

defcode 'exit', EXIT
  popret rsi
  next
