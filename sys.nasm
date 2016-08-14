;; Words for host system interaction
; vim: ft=nasm

; trap ( -- )
defcode 'trap', TRAP
  int3
  next

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

; sysexit ( -- )
defword 'sysexit', SYS_EXIT, LIT, 60, SYSCALL1

; emit ( char -- )
defword 'emit', EMIT, PTR, LIT, 1, SWAP, LIT, 1, LIT, 1, SYSCALL3, DROP, EXIT
