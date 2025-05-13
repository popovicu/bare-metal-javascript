OUTPUT_FORMAT("elf64-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 64M
}

SECTIONS
{
  /* Code section */
  .text : {
    *(.text.init)
    *(.text)
  } > RAM

  /* Read-only data */
  .rodata : {
    *(.rodata)
  } > RAM

  /* Initialized data */
  .data : {
    *(.data)
  } > RAM

  /* Small initialized data */
  .sdata : {
    *(.sdata)
  } > RAM

  /* BSS section with explicit symbols */
  .bss : {
    _bss_start = .;  /* Define BSS start symbol */
    *(.bss)
    *(COMMON)
    . = ALIGN(8);
    _bss_end = .;    /* Define BSS end symbol */
  } > RAM

  /* Small BSS section */
  .sbss : {
    _sbss_start = .;
    *(.sbss)
    *(.sbss.*)
    . = ALIGN(8);
    _sbss_end = .;
  } > RAM

  /* End marker for heap start */
  . = ALIGN(8);
  _end = .; /* Heap starts here and grows upwards */
  
  /* Stack grows downward from the end of RAM */
  _stack_size = 64K;
  _stack_top = ORIGIN(RAM) + LENGTH(RAM);
  _stack_bottom = _stack_top - _stack_size;
  
  /* Ensure we don't overlap with heap */
  ASSERT(_end <= _stack_bottom, "Error: Heap collides with stack")
}