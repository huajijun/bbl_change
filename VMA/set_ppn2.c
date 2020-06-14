extern char ppn2_page;
extern char ppn3_page;
extern char ppn4_page;
void set_ppn3(void);
void set_ppn4(void);
void set_ppn2(char *p)
{
    long *root_addr = p;
    long  a = (&ppn2_page);
    a = a >> 12;
    a = a << 10 | 0xc1;
    root_addr[1] = a;
    set_ppn3();
    set_ppn4();
}
void set_ppn3(void)
{
    
    long *ppn2_addr = &ppn2_page;
    long a= &ppn3_page;
    a = a >> 12;
    a = a << 10 | 0xc1;
    *ppn2_addr = a;
}
void set_ppn4(void)
{
    long *ppn3_addr = &ppn3_page;
    for (int i = 0; i< 512 ; i++)
    {
        ppn3_addr[i] = (0x40000000 >> 2) + (i <<10  | 0xcf);
    }
}


