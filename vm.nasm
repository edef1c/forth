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

defcode 'exit', EXIT
  popret rsi
  next
