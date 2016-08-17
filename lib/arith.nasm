; vim: ft=nasm
%include 'forth'
extern SWAP, DROP, TELL

; + ( a b -- a+b )
defcode '+', ADD
  pop rax
  add [rsp], rax
  next

; - ( a b -- a-b )
defcode '-', SUB
  pop rax
  sub [rsp], rax
  next

; * ( a b -- a*b )
defcode '*', MUL
  popeach rax, rbx
  imul rax, rbx
  push rax
  next

; /mod ( dividend divisor -- remainder quotient )
defcode '/mod', DIVMOD
  xor rdx, rdx
  popeach rbx, rax
  idiv rbx
  pusheach rbx, rax
  next

; / ( dividend divisor -- quotient )
defword '/', DIV, DIVMOD, SWAP, DROP, EXIT

; mod ( dividend divisor -- remainder )
defword 'mod', MOD, DIVMOD, DROP, EXIT

; number ( str len -- number )
defcode 'number', NUMBER
  popeach rcx, rbx
  xor rax, rax
  xor rdi, rdi
  mov r8, 10
.next:
  mul r8
  mov dil, [rbx]
  sub rdi, '0'
  add rax, rdi
  inc rbx
  dec rcx
  jnz .next
.done:
  push rax
  next

section .bss
dotbuffer:
resb 20 ; log10(2^64-1)
dotbuffer_len equ $-dotbuffer

; . ( number -- )
defcode '.', DOT
  pop rax
  mov r8, 10 ; base
  mov rdi, dotbuffer+dotbuffer_len
.next:
  dec rdi
  xor rdx, rdx
  idiv r8
  add rdx, '0'
  mov [rdi], dl
  test rax, rax
  jnz .next
.done:
  push rdi
  sub rdi, dotbuffer+dotbuffer_len
  neg rdi
  push rdi
  next TELL
