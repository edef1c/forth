;; Words for host system interaction
; vim: ft=nasm
%include "forth"
extern LIT, SP_FETCH, SWAP, DROP, NROT

; trap ( -- )
defcode 'trap', TRAP
  int3
  next

; syscall1 ( num -- ret )
defcode 'syscall1', SYSCALL1
  popeach rax, rdi
  syscall
  push rax
  next

; syscall3 ( arg1 arg2 arg3 num -- ret )
defcode 'syscall3', SYSCALL3
  pushret rsi
  popeach rax, rdx, rsi, rdi
  syscall
  push rax
  popret rsi
  next

; sysexit ( ret -- )
defword 'sysexit', SYS_EXIT, LIT, 60, SYSCALL1
; sysread ( fd buf len -- )
defword 'sysread', SYS_READ, LIT, 0, SYSCALL3, EXIT
; syswrite ( fd buf len -- ret )
defword 'syswrite', SYS_WRITE, LIT, 1, SYSCALL3, EXIT
