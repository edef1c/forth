forth: forth.o
include forth.d

%.d: %.nasm
	@(echo -n $(@:.d=.o) $@ && nasm -M $<) > $@

%.o: %.nasm
	nasm -f elf64 $< -o $@
