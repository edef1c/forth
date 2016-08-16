; vim: ft=nasm
%include "forth"
extern LIT, TELL, SYS_EXIT

section .rodata
hello: db 'hello, world', 0x0a
hello_len equ $-hello

defword 'run', RUN, \
  LIT, hello, LIT, hello_len, TELL, \
  LIT, 0, SYS_EXIT
