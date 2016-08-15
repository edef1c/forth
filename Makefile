objects = hello interpreter
libs = forth linker stack sys
ASFLAGS = -f elf64 -g

all: $(objects)
.PHONY: all clean

ASFLAGS += -I include/
-include $(objects:=.d)
-include $(libs:=.d)

%: linker.ld %.o $(libs:=.o)
	ld -static -nostdlib -T linker.ld $(filter %.o,$^) -o $@

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $(ASFLAGS) $<) > $@

%.o: %.nasm
	nasm $(ASFLAGS) $< -o $@

clean:
	rm -f $(objects) *.o *.d
