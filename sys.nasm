; vim: ft=nasm

defcode 'trap', TRAP
  int3
  next

defcode 'syscall1', SYSCALL1
  synthpop rax, rdi
  syscall
  push rax
  next

defcode 'syscall3', SYSCALL3
  pushret rsi
  synthpop rax, rdx, rsi, rdi
  syscall
  push rax
  popret rsi
  next

defword 'sysexit', SYS_EXIT, LIT, 60, SYSCALL1

defword 'emit', EMIT, PTR, LIT, 1, SWAP, LIT, 1, LIT, 1, SYSCALL3, DROP, EXIT
