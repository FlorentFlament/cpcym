void wait_vsync_rising_edge(void) __z88dk_fastcall;
void update_psg(unsigned char *addr) __z88dk_fastcall;
void c_write_to_psg(unsigned char reg, unsigned char value) __z88dk_callee;

void cpcym_init(void) __z88dk_fastcall;
void cpcym_exit(void) __z88dk_fastcall;
