; vim: ft=nasm
%include "forth"
extern SP_FETCH, LIT, SWAP, NROT, SYS_READ, SYS_WRITE, DROP

; key ( -- char )
defword 'key', KEY, LIT, 0, SP_FETCH, LIT, 0, SWAP, LIT, 1, SYS_READ, DROP, EXIT
; emit ( char -- )
defword 'emit', EMIT, SP_FETCH, LIT, 1, SWAP, LIT, 1, SYS_WRITE, DROP, EXIT
; tell ( str len -- )
defword 'tell', TELL, LIT, 0, NROT, SYS_WRITE, DROP, EXIT

section .data
wordbuf: times 32 db 0
wordbuf_len: db 0

; word ( -- str len )
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
