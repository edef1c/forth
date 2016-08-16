;; Words for host system interaction
; vim: ft=nasm
%include "forth"
extern LIT, SP_FETCH, SWAP, DROP

; trap ( -- )
defcode 'trap', TRAP
  int3
  next

%macro synthpop 0-*
  %rep %0
    pop %1
  %rotate 1
  %endrep
%endmacro

; syscall1 ( num -- ret )
defcode 'syscall1', SYSCALL1
  synthpop rax, rdi
  syscall
  push rax
  next

; syscall3 ( arg1 arg2 arg3 num -- ret )
defcode 'syscall3', SYSCALL3
  pushret rsi
  synthpop rax, rdx, rsi, rdi
  syscall
  push rax
  popret rsi
  next

; sysexit ( ret -- )
defword 'sysexit', SYS_EXIT, LIT, 60, SYSCALL1

; emit ( char -- )
defword 'emit', EMIT, SP_FETCH, LIT, 1, SWAP, LIT, 1, LIT, 1, SYSCALL3, DROP, EXIT

; key ( -- char )
defword 'key', KEY, LIT, 0, SP_FETCH, LIT, 0, SWAP, LIT, 1, LIT, 0, SYSCALL3, DROP, EXIT
