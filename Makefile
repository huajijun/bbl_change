all:
	riscv64-ls-elf-gcc -nostartfiles -nostdlib assem.S test.c   -Tass.lds -o test
spike: test
	spike -d -m0x40000000:0x80000000 test

dump: test
	riscv64-ls-elf-objdump -x -d test > test.dmp
	riscv64-ls-elf-objdump -j .data -s test >> test.dmp
other:
	#riscv64-ls-elf-gcc -nostartfiles -nostdlib assem.S test.c -L../lib -lsbi -Tass.lds -o test
	dtc -I dts -O dtb -o output.dts  ./platform/kendryte/k210/k210.dts
	fdtdump -sd output.dts
test: prac.S vma.lds
	riscv64-ls-elf-gcc -nostartfiles -nostdlib   -Tvma.lds paddr.c physical_alloc.c prac.S -o test
clean:
	rm test -rf
