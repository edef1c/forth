;; Words for stack operations
; vim: ft=nasm
%include "forth"

; lit
; compile-time: ( x -- )
; runtime: ( -- x )
defcode 'lit', LIT
  lodsq
  push rax
  next

; sp@ ( -- a-addr )
defcode 'sp@', SP_FETCH
  push rsp
  next

; dup ( x -- x x )
defcode 'dup', DUP
  push qword [rsp]
  next

; swap ( x y -- y x )
defcode 'swap', SWAP
  pop rax
  pop rbx
  push rax
  push rbx
  next

; drop ( x -- )
defcode 'drop', DROP
  pop rax
  next
