; vim: ft=nasm
%include "forth"

defcode 'branch', BRANCH
  add rsi, [rsi]
  next

defcode '0branch', ZBRANCH
  pop rax
  test rax, rax
  jz BRANCH.body
  lea rsi, [rsi+8]
  next
