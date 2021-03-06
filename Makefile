objects = hello interpreter
libs = main core/vm core/linker core/compiler core/heap lib/arith lib/flow lib/stack lib/sys lib/io
ASFLAGS = -f elf64 -g

all: $(objects)
.PHONY: all clean

ASFLAGS += -I include/
LDSCRIPT = core/linker.ld
-include $(objects:=.d)
-include $(libs:=.d)

%: $(LDSCRIPT) %.o $(libs:=.o)
	ld -static -nostdlib -T $(LDSCRIPT) $(filter %.o,$^) -o $@

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $(ASFLAGS) $<) > $@

%.o: %.nasm
	nasm $(ASFLAGS) $< -o $@

clean:
	rm -f $(objects) {.,core,lib}/*.{o,d}
