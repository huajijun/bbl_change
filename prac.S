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
.align 2
change:
	li x1 ,0
	li x2 ,0
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
.align 4
test:	
    	li t3 ,0
    	la sp, bootstacktop
	/*ecall */
	la t0, boot_page
	srli t0, t0, 12
    	li t1, 8 <<60
    	or      t0, t0, t1
	//sfence.vma
    	csrw    satp, t0
	jal change
.section .page
boot_page:
	.zero 8
	.quad (0x1<<28)|0xcf
	.zero 8*510
	
.section .data
.align 6
bootstack:
    .space 4096 * 4
    .global bootstacktop
bootstacktop:

