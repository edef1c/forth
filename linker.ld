OUTPUT_FORMAT("elf64-x86-64")
ENTRY(_start)
SECTIONS {
  PROVIDE(__executable_start = 0x200000);
  . = 0x200000 + SIZEOF_HEADERS;
  .text : ALIGN(0x1000) {
    *(.text)
  }
  .rodata : ALIGN(0x1000) {
    *(.rodata)
  }
  .data : ALIGN(0x1000) {
    *(.data)
  }
  .bss : ALIGN(0x1000) {
    *(.bss)
  }
}
