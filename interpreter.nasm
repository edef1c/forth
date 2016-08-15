; vim: ft=nasm
%include "dict.nasm"
%include "vm.nasm"

extern dictptr, docol, KEY, LIT, SYS_EXIT

defword 'run', RUN, W0RD, FIND, TCFA, INVOKE, LIT, 0, SYS_EXIT

defcode 'word', W0RD
  pushret rsi
  mov byte [wordbuf_len], 0
.fetch:
  callword KEY
  pop rax
  cmp al, 10
  je .done
  xor rsi, rsi
  mov sil, [wordbuf_len]
  mov [wordbuf+rsi], rax
  inc rsi
  mov [wordbuf_len], sil
  jmp .fetch
.done:
  push wordbuf
  xor rax, rax
  mov al, [wordbuf_len]
  push rax
  popret rsi
  next

; find ( str len -- dictptr? )
defcode 'find', FIND
  pushret rsi
  pop r8  ; str.len
  pop r9  ; str.ptr
  mov rdx, [dictptr]
.start:
  test rdx, rdx
  je .done
  ; check if length matches
  mov al, [rdx+8]
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
  mov al,  [rdi+8]
  lea rdi, [rdi+8+rax]
  add rdi, 7
  and rdi, ~7
  push rdi
  next

; invoke ( wordptr -- ?? )
defcode 'invoke', INVOKE
  pop rax
  callword
  next

section .data
wordbuf: times 32 db 0
wordbuf_len: db 0
