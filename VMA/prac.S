.section .text.first
.align 6
  .globl reset_vector
reset_vector:
  j do_reset

/*	
    la 	a1 , start_bss
    la  a2 , end_bss
clear_bss:
    sd zero , 0(a1)
    addi a1 , a1 ,8
    blt a1 , a2 ,clear_bss
*/
do_reset:
	li a1 , 0x680a
	csrr a2, mstatus
	or a2,a2 , a1
	csrw mstatus, a2
	la a3 , test
	csrw mepc ,a3
	mret
.align 4
test:	
    	la sp, bootstacktop
//   call init_pmm 
	/*ecall */
	la t0, boot_page
// set vma
	srli t0, t0, 12
    li t1, 8 <<60
    or      t0, t0, t1
    la a0 , boot_page
    call set_ppn2
    slli a4 , a4 ,28
	sfence.vma
	fence
    csrw    satp, t0
//	li a3, 0x80000008
//	ld a7, 0(a3) 
	ld a6 ,0(a5)
	fence.i
	jalr a5
.section .page
boot_page:
	.zero 8
//	.quad a4 |0xc1
	.zero 8*510
	.quad (0x2<<28)|0xcf 
ppn2_page:
    .zero 512 * 8
    .global ppn2_page	
ppn3_page:
    .zero 512 * 8
    .global ppn3_page	
ppn4_page:
    .zero 512 * 8
    .global ppn4_page	
.section .data
.align 6
bootstack:
    .space 4096 * 4
    .global bootstacktop
bootstacktop:
.align 12


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

