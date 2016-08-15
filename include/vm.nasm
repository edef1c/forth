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

%macro callword 0
  mov rsi, %%inst
  jmp [rax]
  %%inst: dq %%word
  %%word: dq %%cont
  %%cont:
%endmacro

%macro callword 1
  mov rax, %1
  callword
%endmacro
