; vim: ft=nasm
%include "dict.nasm"

extern docol, LIT, EMIT, DUP, PLUS, SYS_EXIT

defword 'run', RUN, \
  LIT, 'h', EMIT,   \
  LIT, 'e', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'o', EMIT,   \
  LIT, ',', EMIT,   \
  LIT, ' ', EMIT,   \
  LIT, 'w', EMIT,   \
  LIT, 'o', EMIT,   \
  LIT, 'r', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'd', EMIT,   \
  LIT, 0Ah, EMIT,   \
  LIT, 42, DUP, PLUS, SYS_EXIT
