; vim: ft=nasm
%include "vm"
%include "dict"
extern dovar

section .bss
align 4096
heap: resb 4096*4096
defvar here, heap
