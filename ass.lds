OUTPUT_ARCH( "riscv" )
ENTRY(reset_vector)

SECTIONS
{
  . = 0x10010000;
  .text : { *(.text) }
#  .text 0xfffff00000 : AT(0xfffffff2048){ *(.text) }
  . = ALIGN(0x1000);
  .data : { *(.data) }
  . = ALIGN(0x1000);
  .bss	: { *(.bss) }
}
