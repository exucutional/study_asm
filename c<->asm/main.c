#include <stdio.h>

extern void _mprintf(const char*, ...);
	
int main(void)
{
	_mprintf("HELLO WORLD %d\n", 112311);
	return 0;
}
