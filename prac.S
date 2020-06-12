.section .text
.align 6
  .globl reset_vector
reset_vector:
  j do_reset

do_reset:
	
	li a1 , 0x6800
	csrr a2, mstatus
	or a2,a2 , a1
	csrw mstatus, a2
	la a3 , test
	csrw mepc ,a3
	mret
.align 4
test:	
    	li t3 ,0
    	la sp, bootstacktop
	/*ecall */
#	call load_paddr
	la t0, boot_page
	srli t0, t0, 12
    	li t1, 8 <<60
    	or      t0, t0, t1
	sfence.vma
	fence
    	csrw    satp, t0
	li a5 ,0x3ffffffff
	slli a5 , a5 , 30
	sfence.vma
	fence
//	li a3, 0x80000008
//	ld a7, 0(a3) 
	ld a6 ,0(a5)
	fence.i
	jalr a5
.section .page
boot_page:
	.zero 8
	.quad (0x1<<28)|0xcf
	.zero 8*509
	.quad (0x2<<28)|0xcf
	
.section .data
.align 6
bootstack:
    .space 4096 * 4
    .global bootstacktop
bootstacktop:

.section ".paddr","ax"
patable:
	li x3 ,0
	li x4 ,0
	li x5 ,0
	li x6 ,0
	li x7 ,0
	li x8 ,0
	li x9 ,0
	li x10 ,0
	li x11 ,0
	li x12 ,0
	li x13 ,0
	 
