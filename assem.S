#include "variable.h"
.section .text
.align 6
  .globl reset_vector
reset_vector:
  j do_reset

#  reset reg and  keep a0 , a1
 do_reset:
 	li x1, 0
	li x2, 0
	li x3, 0
	li x4, 0
	li x5, 0
	li x6, 0
	li x7, 0
	li x8, 0
	li x9, 0
	// save a0 and a1; arguments from previous boot loader stage:
	//  li x10, 0
	//  li x11, 0
	li x12, 0
	li x13, 0
	li x14, 0
	li x15, 0
	li x16, 0
	li x17, 0
	li x18, 0
	li x19, 0
	li x20, 0
	li x21, 0
	li x22, 0
	li x23, 0
	li x24, 0
	li x25, 0
	li x26, 0
	li x27, 0
	li x28, 0
	li x29, 0
	li x30, 0
	li x31, 0
	li a1 , 0x6800
	csrr a2, mstatus
	or a2,a2 , a1
	csrw mstatus, a2
	la a3 , test
	csrw mepc ,a3
	mret
.align 12
test:	
    li t3 ,0
    la sp, bootstacktop
    lui t0, %hi(boot_page)
    li t1 , 0xffffffffc00F0000 - 0x100F0000
    sub t0,t0,t1
    srli t0,t0,12
    li t1, 8 <<60
    or      t0, t0, t1
    csrw    satp, t0
    auipc t3 , 0
    la t0 , change
    jalr t0 

    li x1,0
	csrw mscratch, x0
	
	# write mtvec and make sure it sticks

# write acception handle
	la t0, error
	csrw mtvec, t0   #mtvec = t0;
	csrr t1 , mtvec
1:	bne t0, t1 , 1b



# set sp point
	la sp, stacks + RISCV_PGSIZE - MENTRY_FRAME_SIZE 

    
#	csrr a3, mhartid
#	slli a2, a3, RISCV_PGSHIFT  #left move 
	add sp, sp, a2
# time setting
#	li a1 , 0x63
#	li a0 , 0x2004000
#	sd  a1 , 0(a0)
	
#	li a0 , 0x200bff8
#	li a1 , 0
	
#	sd a1 , 0(a0)
#	li a1 , 0
#	li a0, 0xb0
	#csrw mip, a0
#	csrw mie, a0
 #   	csrr a0 , mstatus
  #  	or a0 , a0, 0x8
    	csrw mstatus, a0
	jal zzy
	ecall
#	j _payload_start
1:
	j 1b
.align 4
error:
    	csrrw sp, mscratch, sp
	beqz sp, .Ltrap_from_machine_mode
	STORE a0, 10*REGBYTES(sp)
  	STORE a1, 11*REGBYTES(sp)

  	csrr a1, mcause
  	bgez a1, .Lhandle_trap_in_machine_mode
    
	sll a1 , a1 ,1
	
.Ltrap_from_machine_mode:
	csrr sp, mscratch
  	addi sp, sp, -INTEGER_CONTEXT_SIZE

  	STORE a1,11*REGBYTES(sp)
  	li a1, TRAP_FROM_MACHINE_MODE_VECTOR
  	j .Lhandle_trap_in_machine_mode
	
.Lhandle_trap_in_machine_mode:
  	STORE ra, 1*REGBYTES(sp)
  	STORE gp, 3*REGBYTES(sp)
  	STORE tp, 4*REGBYTES(sp)
  	STORE t0, 5*REGBYTES(sp)
#1:	auipc t0, %pcrel_hi(trap_table)  # t0 <- %hi(trap_table)
1:	la t0 , trap_table
  	STORE t1, 6*REGBYTES(sp)
  	sll t1, a1, LOG_REGBYTES         # t1 <- mcause * ptr size
  	STORE t2, 7*REGBYTES(sp)
  	add t1, t0, t1                   # t1 <- %hi(trap_table)[mcause]
  	STORE s0, 8*REGBYTES(sp)
#  	LOAD t1, %pcrel_lo(1b)(t1)       # t1 <- trap_table[mcause]
  	STORE s1, 9*REGBYTES(sp)
  	mv a0, sp                        # a0 <- regs
  	STORE a2,12*REGBYTES(sp)
  	csrr a2, mepc                    # a2 <- mepc
  	STORE a3,13*REGBYTES(sp)
  	csrrw t0, mscratch, x0           # t0 <- user sp
  	STORE a4,14*REGBYTES(sp)
  	STORE a5,15*REGBYTES(sp)
  	STORE a6,16*REGBYTES(sp)
  	STORE a7,17*REGBYTES(sp)
  	STORE s2,18*REGBYTES(sp)
  	STORE s3,19*REGBYTES(sp)
  	STORE s4,20*REGBYTES(sp)
  	STORE s5,21*REGBYTES(sp)
  	STORE s6,22*REGBYTES(sp)
  	STORE s7,23*REGBYTES(sp)
  	STORE s8,24*REGBYTES(sp)
  	STORE s9,25*REGBYTES(sp)
  	STORE s10,26*REGBYTES(sp)
  	STORE s11,27*REGBYTES(sp)
  	STORE t3,28*REGBYTES(sp)
  	STORE t4,29*REGBYTES(sp)
  	STORE t5,30*REGBYTES(sp)
  	STORE t6,31*REGBYTES(sp)
  	STORE t0, 2*REGBYTES(sp) 
	STORE x0, (sp)	
	ld t0 ,0(t1)
	jalr t0
	csrw mscratch, sp
restore_reg:
	LOAD ra, 1*REGBYTES(sp)
 	LOAD gp, 3*REGBYTES(sp)
  	LOAD tp, 4*REGBYTES(sp)
  	LOAD t0, 5*REGBYTES(sp)
  	LOAD t1, 6*REGBYTES(sp)
  	LOAD t2, 7*REGBYTES(sp)
  	LOAD s0, 8*REGBYTES(sp)
  	LOAD s1, 9*REGBYTES(sp)
  	LOAD a0,10*REGBYTES(sp)
  	LOAD a1,11*REGBYTES(sp)
  	LOAD a2,12*REGBYTES(sp)
  	LOAD a3,13*REGBYTES(sp)
  	LOAD a4,14*REGBYTES(sp)
  	LOAD a5,15*REGBYTES(sp)
  	LOAD a6,16*REGBYTES(sp)
  	LOAD a7,17*REGBYTES(sp)
  	LOAD s2,18*REGBYTES(sp)
  	LOAD s3,19*REGBYTES(sp)
  	LOAD s4,20*REGBYTES(sp)
  	LOAD s5,21*REGBYTES(sp)
  	LOAD s6,22*REGBYTES(sp)
  	LOAD s7,23*REGBYTES(sp)
  	LOAD s8,24*REGBYTES(sp)
  	LOAD s9,25*REGBYTES(sp)
  	LOAD s10,26*REGBYTES(sp)
  	LOAD s11,27*REGBYTES(sp)
 	LOAD t3,28*REGBYTES(sp)
  	LOAD t4,29*REGBYTES(sp)
  	LOAD t5,30*REGBYTES(sp)
  	LOAD t6,31*REGBYTES(sp)
  	LOAD sp, 2*REGBYTES(sp)
  	mret
.align 6
__time_clock:
    jal time_clock 
    j restore_reg   

.section .bss
.align 6
stacks:
	.skip RISCV_PGSIZE * MAX_HARTS
.section .vma
.align 6
.global change
change:	
	li x1, 0
	li x2, 0
	li x3, 0
	li x4, 0
	li x5, 0
	li x6, 0
    

.section .data
.align 6
trap_table:
	.dc.a bad_trap
  	.dc.a pmp_trap
  	.dc.a bad_trap
  	.dc.a pmp_trap
	.dc.a __time_clock
  	.dc.a bad_trap
  	.dc.a bad_trap
	.dc.a bad_trap
	.dc.a bad_trap
	.dc.a bad_trap
	.dc.a bad_trap
	.dc.a bad_trap
	.dc.a __time_clock
 
.section .bootdata
.align 12    
bootstack:
    .space 4096 * 4
    .global bootstacktop
bootstacktop:
boot_page:
	.zero 8*511
	.quad (0x100F0<< 10)| 0xcf

#.globl _payload_start, _payload_end
#_payload_start:
#	.incbin "/home/zhangzy/bbl_change/testCopy"
#_payload_end:
    
    
