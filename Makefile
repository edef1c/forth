all: hello
.PHONY: all

include forth.d

hello: hello.o forth.o
include hello.d

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $<) > $@

%.o: %.nasm
	nasm -f elf64 $< -o $@
