OUTPUT_ARCH( "riscv" )
ENTRY(reset_vector)

SECTIONS
{
  . = 0x10010000;
  .text : { *(.text) }
  .data : { *(.data) }
  . = ALIGN(0x1000);
  .bss	: { *(.bss) }
  .zz 0x20010000 : { *(.vma) }
  .bootdata : {*(.bootdata)}
}
