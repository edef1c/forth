; vim: ft=nasm
%include "vm"
%include "dict"
extern KEY, LIT, FETCH, EXIT
extern dovar, docol
extern here, var_here
extern latest, var_latest

section .data
wordbuf: times 32 db 0
wordbuf_len: db 0

; word ( -- str len )
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

; create ( str len -- )
defcode 'create', CREATE
  ; create a new dict node
  mov rdi, [var_here]
  mov rax, [var_latest]
  stosq
  ; write the length byte
  pop rcx
  mov al, cl
  stosb
  ; copy the name
  pop rsi
  rep movsb
  ; alignment
  add rdi, 7
  and rdi, ~7
  ; commit
  mov rax, [var_here]
  mov [var_here], rdi
  mov [var_latest], rax
  next

; hidden ( wordptr -- )
defcode 'hidden', HIDDEN
  pop rax
  xor byte [rdi+8], F_HIDDEN
  next

defvar state

defcode '[', LBRAC, F_IMM
  mov qword [var_state], 0
  next

defcode ']', RBRAC
  mov qword [var_state], 1
  next

; , d:( x -- ) m:( -- x)
defcode ',', COMMA
  mov rdi, [var_here]
  pop qword [rdi]
  lea rdi, [rdi+8]
  mov [var_here], rdi
  next

defword ':', COLON, W0RD, CREATE, LIT, docol, COMMA, latest, FETCH, HIDDEN, LBRAC, EXIT
defwordx ';', SEMICOLON, F_IMM, LIT, EXIT, COMMA, latest, FETCH, HIDDEN, LBRAC, EXIT
