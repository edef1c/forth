; vim: ft=nasm
%include "vm"
%include "dict"
extern W0RD, FIND, TCFA, JUMP, FETCH, LIT, IS_NUMERIC, NUMBER, BRANCH, ZBRANCH, DUP, DUP2, AND, EXIT, TRAP
extern dovar, docol
extern HERE, var_HERE
extern LATEST, var_LATEST

; create ( str len -- )
defcode 'create', CREATE
  ; create a new dict node
  mov rdi, [var_HERE]
  mov rax, [var_LATEST]
  stosq
  ; write the length byte
  pop rcx
  mov al, cl
  stosb
  ; copy the name
  mov r8, rsi
  pop rsi
  rep movsb
  mov rsi, r8
  ; alignment
  add rdi, 7
  and rdi, ~7
  ; commit
  mov rax, [var_HERE]
  mov [var_HERE], rdi
  mov [var_LATEST], rax
  next

; hidden ( wordptr -- )
defcode 'hidden', HIDDEN
  pop rdi
  xor byte [rdi+8], F_HIDDEN
  next

; immediate ( wordptr -- )
defcode 'immediate', IMMEDIATE
  pop rdi
  xor byte [rdi+8], F_IMM
  next

defvar 'state', STATE

defcode '[', LBRAC, F_IMM
  mov qword [var_STATE], 0
  next

defcode ']', RBRAC
  mov qword [var_STATE], 1
  next

; , d:( x -- ) m:( -- x)
defcode ',', COMMA
  mov rdi, [var_HERE]
  pop qword [rdi]
  lea rdi, [rdi+8]
  mov [var_HERE], rdi
  next

defcode "'", TICK
  lodsq
  push rax
  next

defword ':', COLON, W0RD, CREATE, LIT, docol, COMMA, LATEST, FETCH, HIDDEN, LBRAC, EXIT
defwordx ';', SEMICOLON, F_IMM, LIT, EXIT, COMMA, LATEST, FETCH, HIDDEN, LBRAC, EXIT

defword 'interpret', INTERPRET, W0RD, DUP2, IS_NUMERIC, ZBRANCH, 8*3, INTERPRET_LITERAL, EXIT, INTERPRET_WORD, EXIT

; interpret-literal
; ctime: ( str len -- )
; rtime: ( str len -- n )
defword 'interpret-literal', INTERPRET_LITERAL, \
  NUMBER, STATE, ZBRANCH, 8*5, \
  LIT, LIT, COMMA, COMMA, \
  EXIT

; interpret-word ( ?? str len -- ??? )
defword 'interpret-word', INTERPRET_WORD, \
  FIND, \
  STATE, ZBRANCH, 8*8, \
  DUP, FETCH, LIT, F_IMM, AND, ZBRANCH, 8*4, \
  TCFA, JUMP, EXIT, \
  TRAP

defword 'quit', QUIT, INTERPRET, BRANCH, -8*2
