extern char physical_root;
extern char physical_end;
typedef unsigned int  uint;
int PhysicalPageCount = 0;
int stacktop = 0;
uint Alloc_Pmm(void);
static unsigned int  pmm_stack[1025];
void init_pmm(void)
{
    char *pmm_start = &physical_root;
    char *pmm_end = &physical_end;
    uint zzy;
    while(pmm_start < pmm_end)
    {
        Free_Pmm(pmm_start);
        pmm_start += 4096;
        PhysicalPageCount++;
    }
    zzy = Alloc_Pmm();


}
void Free_Pmm(uint p)
{
    pmm_stack[++stacktop] = p;
}

uint Alloc_Pmm(void)
{
    uint p = pmm_stack[stacktop--];
    return p;
}


