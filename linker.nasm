; vim: ft=nasm
extern __dict_start, __dict_end
extern var_latest

global linker
linker:
  mov rbx, [var_latest]
  mov rsi, __dict_start
.next:
  lodsq
  mov [rax], rbx
  mov rbx, rax
  cmp rsi, __dict_end
  jne .next
  mov [var_latest], rbx
  ret
