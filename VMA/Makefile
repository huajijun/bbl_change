all:
	riscv64-ls-elf-gcc -nostartfiles -nostdlib   -Tvma.lds prac.S set_ppn2.c  -o test
	riscv64-ls-elf-objdump -x -d test > test.dmp
	riscv64-ls-elf-objdump -j .data -s test >> test.dmp
spike:
	spike -d -m0x40000000:0x80000000 test
