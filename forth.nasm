; vim: ft=nasm

; rsi = instruction pointer
; rbp = return stack pointer
; rsp = data stack pointer

%macro next 0
  lodsq
  jmp [rax]
%endmacro

%macro pushret 1
  lea rbp, [rbp-8]
  mov [rbp], qword %1
%endmacro

%macro popret 1
  mov qword %1, [rbp]
  lea rbp, [rbp+8]
%endmacro

docol:
  pushret rsi
  lea rsi, [rax+8]
  next

%define wordlink 0

%macro defcode 2
%push
  %define %$name     %1
  %define %$symbol   %2
  %strlen %$name_len %$name

  section .rodata
  %%word:
  dq wordlink
  %define wordlink %%word
  db %$name_len
  dq %$name
  %$symbol:
  dq %$code
  section .text
  %$code:
%pop
%endmacro

%macro defword 3+
%push
  %define %$name     %1
  %define %$symbol   %2
  %strlen %$name_len %$name

  section .rodata
  %%word:
  dq wordlink
  %define wordlink %%word
  db %$name_len
  dq %$name
  %$symbol:
  dq docol, %3
%pop
%endmacro

global main
main:
  cld
  mov rbp, retstack
  xor rsi, rsi

  mov rax, RUN
  jmp [rax]

defword 'run', RUN, \
  LIT, 'h', EMIT,   \
  LIT, 'e', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'o', EMIT,   \
  LIT, ',', EMIT,   \
  LIT, ' ', EMIT,   \
  LIT, 'w', EMIT,   \
  LIT, 'o', EMIT,   \
  LIT, 'r', EMIT,   \
  LIT, 'l', EMIT,   \
  LIT, 'd', EMIT,   \
  LIT, 0Ah, EMIT,   \
  LIT, 42, DUP, PLUS, SYS_EXIT

defcode 'lit', LIT
  lodsq
  push rax
  next

defcode 'litptr', LITPTR
  push rsi
  add rsi, 8
  next

defcode 'ptr', PTR
  push rsp
  next

defcode 'trap', TRAP
  int3
  next

defcode 'dup', DUP
  push qword [rsp]
  next

defcode 'swap', SWAP
  pop rax
  pop rbx
  push rax
  push rbx
  next

defcode 'drop', DROP
  pop rax
  next

defcode 'exit', EXIT
  popret rsi
  next

defcode '+', PLUS
  pop rax
  add [rsp], rax
  next

%macro synthpop 0-*
  %rep %0
    pop %1
  %rotate 1
  %endrep
%endmacro

defcode 'syscall1', SYSCALL1
  synthpop rax, rdi
  syscall
  push rax
  next

defcode 'syscall3', SYSCALL3
  pushret rsi
  synthpop rax, rdx, rsi, rdi
  syscall
  push rax
  popret rsi
  next

defword 'sysexit', SYS_EXIT, LIT, 60, SYSCALL1
defword 'emit', EMIT, PTR, LIT, 1, SWAP, LIT, 1, LIT, 1, SYSCALL3, DROP, EXIT

section .data
align 4096
resb 4096
retstack:
