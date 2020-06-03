all:
	riscv64-ls-elf-gcc -nostartfiles -nostdlib assem.S test.c -L../lib -lsbi -Tass.lds -o test
spike:
	spike -d -m0x10000000:0xFF0000 test

dump:
	riscv64-ls-elf-objdump -D test > test.dmp
