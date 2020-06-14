OUTPUT_ARCH( "riscv" )
ENTRY(reset_vector)

SECTIONS
{
  . = 0x40000000;
  .text :{ *(.text.first)
            *(.text) }
  . = ALIGN(0x1000);
  .data : { 
	*(.page)
	*(.data)
	}
  start_bss = .;
  .bss : {
        *(.bss)
    }
  end_bss = .;
  . = 0xFFFFFFFFC0000000;
  start_pa = .;
  .paddr :AT(0x80000000)  { *(.paddr) }
  end_pa = .;
}
