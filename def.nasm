; vim: ft=nasm

%define wordlink 0

%macro defcode 2
%push
  %define %$name     %1
  %define %$symbol   %2
  %strlen %$name_len %$name

  section .rodata
  %%word:
  dq wordlink
  %define wordlink %%word
  db %$name_len, %$name
  align 8, db 0
  global %$symbol
  %$symbol:
  dq %$code
  section .text
  %$code:
%pop
%endmacro

%macro defword 3+
%push
  %define %$name     %1
  %define %$symbol   %2
  %strlen %$name_len %$name

  section .rodata
  %%word:
  dq wordlink
  %define wordlink %%word
  db %$name_len, %$name
  align 8, db 0
  global %$symbol
  %$symbol:
  dq docol, %3
%pop
%endmacro
