; vim: ft=nasm

%define wordlink 0

%macro defdict 2
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
%pop
%endmacro

%macro defcode 2
  defdict %1, %2
  dq %%code
  section .text
  %%code:
%endmacro

%macro defword 3+
  defdict %1, %2
  dq docol, %3
%endmacro
