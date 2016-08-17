; vim: ft=nasm
%include 'forth'
extern SWAP, DROP

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
