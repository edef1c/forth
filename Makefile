objects = hello
all: $(objects)
.PHONY: all

LDFLAGS = -nostdlib
-include forth.d
-include $(objects:.d)
$(objects): forth.o

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $<) > $@

%.o: %.nasm
	nasm -f elf64 $< -o $@
