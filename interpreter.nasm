; vim: ft=nasm
%include "forth"
extern FIND, KEY, TCFA, LIT, SYS_EXIT

defword 'run', RUN, W0RD, FIND, TCFA, INVOKE, LIT, 0, SYS_EXIT

defcode 'word', W0RD
  pushret rsi
  mov byte [wordbuf_len], 0
.fetch:
  callword KEY
  pop rax
  cmp al, 10
  je .done
  xor rsi, rsi
  mov sil, [wordbuf_len]
  mov [wordbuf+rsi], rax
  inc rsi
  mov [wordbuf_len], sil
  jmp .fetch
.done:
  push wordbuf
  xor rax, rax
  mov al, [wordbuf_len]
  push rax
  popret rsi
  next

; invoke ( wordptr -- ?? )
defcode 'invoke', INVOKE
  pop rax
  callword
  next

section .data
wordbuf: times 32 db 0
wordbuf_len: db 0
