all:
	riscv64-ls-elf-gcc -nostartfiles -nostdlib assem.S test.c -Tass.lds -o test
spike:
	spike -d -m0x10000000:0x20000 test

dump:
	riscv64-ls-elf-objdump -d test > test.dmp
