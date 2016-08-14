forth: forth.o
forth.o: forth.nasm
	nasm -f elf64 $< -o $@
