; vim: ft=nasm

%macro synthpop 0-*
  %rep %0
    pop %1
  %rotate 1
  %endrep
%endmacro
