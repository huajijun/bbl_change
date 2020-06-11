OUTPUT_ARCH( "riscv" )
ENTRY(reset_vector)

SECTIONS
{
  . = 0x40000000;
  .text : { *(.text) }
  . = ALIGN(0x1000);
  .data : { 
	*(.page)
	*(.data)
	}
}
