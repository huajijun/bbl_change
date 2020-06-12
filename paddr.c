extern char  start_pa;
extern char end_pa;
void load_paddr(void)
{
	char* start_page = &start_pa;
	char* end_page = &end_pa;
	char *pa = 0x80000000;
	while(start_page <= end_page)
	{
		*pa++ = *start_page++;
	}
}
