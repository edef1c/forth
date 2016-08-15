objects = hello interpreter
libs = forth.o stack.o sys.o
ASFLAGS = -f elf64 -g

all: $(objects)
.PHONY: all

ASFLAGS += -I include/
-include $(objects:.d)
-include $(libs:.d)

%: linker.ld %.o $(libs)
	ld -static -nostdlib -T linker.ld $(filter %.o,$^) -o $@

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $(ASFLAGS) $<) > $@

%.o: %.nasm
	nasm $(ASFLAGS) $< -o $@
