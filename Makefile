objects = hello interpreter
all: $(objects)
.PHONY: all

-include forth.d
-include $(objects:.d)

%: linker.ld %.o forth.o
	ld -static -nostdlib -T linker.ld $(filter %.o,$^) -o $@

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $<) > $@

%.o: %.nasm
	nasm -g -f elf64 $< -o $@
