#define RISCV_PGSHIFT 12
#define RISCV_PGSIZE (1 << RISCV_PGSHIFT)  // 4K
#define MENTRY_FRAME_SIZE 0
#define MAX_HARTS 8
#define TRAP_FROM_MACHINE_MODE_VECTOR 12
#define REGBYTES 4
#define STORE sw
#define INTEGER_CONTEXT_SIZE 128
#define LOAD lw
#define LOG_REGBYTES 3
