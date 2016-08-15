objects = hello interpreter
libs = forth.o stack.o sys.o

all: $(objects)
.PHONY: all

-include $(objects:.d)
-include $(libs:.d)

%: linker.ld %.o $(libs)
	ld -static -nostdlib -T linker.ld $(filter %.o,$^) -o $@

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $<) > $@

%.o: %.nasm
	nasm -g -f elf64 $< -o $@
