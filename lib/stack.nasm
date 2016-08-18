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

; fetch ( x-ptr -- x )
defcode '@', FETCH
  mov rbx, [rsp]
  mov rax, [rbx]
  mov [rsp], rax
  next

; sp@ ( -- a-addr )
defcode 'sp@', SP_FETCH
  push rsp
  next

; dup ( x -- x x )
defcode 'dup', DUP
  push qword [rsp]
  next

; dup2 ( x y -- x y x y )
defcode 'dup2', DUP2
  sub rsp, 16
  mov rax, [rsp+16]
  mov rbx, [rsp+24]
  mov [rsp+0], rax
  mov [rsp+8], rbx
  next

; swap ( x y -- y x )
defcode 'swap', SWAP
  popeach rax, rbx
  pusheach rax, rbx
  next

; drop ( x -- )
defcode 'drop', DROP
  lea rsp, [rsp+8]
  next

; rot ( w1 w2 w3 -- w2 w3 w1 )
defcode 'rot', ROT
  popeach rax, rbx, rcx
  pusheach rbx, rax, rcx
  next

; -rot ( w1  w2  w3  -- w3  w1  w2  )
; this is gforth's -rot, which appears to work differently from Jones Forth's
defcode '-rot', NROT
  popeach rax, rbx, rcx
  pusheach rax, rcx, rbx
  next
