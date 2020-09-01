#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int main()
{
	FILE* fin = fopen("life.out", "rb");
	assert(fin);
	fseek(fin, 0, SEEK_END);
	long size = ftell(fin);
	fseek(fin, 0, SEEK_SET);
	char *bcode = calloc(size, sizeof(char));	
	fread(bcode, sizeof(char), size, fin);
	bcode[0x5112] = 0x74;
	bcode[0x1ce5] = 0x74;
	bcode[0x1d7b] = 0x74;
	//printf("%x", bcode[0x4cf]);  
	FILE* fout = fopen("lifecracked.out", "wb");
	assert(fout);
	fwrite(bcode, sizeof(char), size, fout);
	fclose(fout);
	fclose(fin);
	free(bcode);
	printf("File patched\n");	
	return 0;
}
