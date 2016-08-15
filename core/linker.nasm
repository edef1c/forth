; vim: ft=nasm
%include "vm"
%include "dict"
extern __dict_start, __dict_end, dovar
defvar latest

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

; find ( str len -- dictptr? )
defcode 'find', FIND
  pushret rsi
  pop r8  ; str.len
  pop r9  ; str.ptr
  mov rdx, [var_latest]
.start:
  test rdx, rdx
  je .done
  ; check if length matches
  mov al, [rdx+8]
  and al, F_HIDDEN|F_LENMASK ; mask out the flags, but respect F_HIDDEN
  cmp al, r8b
  jne .next
  ; check if the content matches
  mov rcx, r8
  mov rdi, r9
  lea rsi, [rdx+8+1]
  repe cmpsb
  je .done
.next:
  mov rdx, [rdx]
  jmp .start
.done:
  push rdx
  popret rsi
  next

; >CFA ( dictptr -- wordptr )
defcode '>CFA', TCFA
  pop rdi
  xor rax, rax
  mov al, [rdi+8]
  and al, F_LENMASK
  lea rdi, [rdi+8+rax]
  add rdi, 7
  and rdi, ~7
  push rdi
  next
