; vim: ft=nasm
%include "forth"
extern W0RD, FIND, TCFA, KEY, LIT, SYS_EXIT

defword 'run', RUN, W0RD, FIND, TCFA, INVOKE, LIT, 0, SYS_EXIT

; invoke ( wordptr -- ?? )
defcode 'invoke', INVOKE
  pop rax
  callword
  next
