CC= gcc
ASM= nasm
LD= gcc
CFLAGS=-c -g -O0 -Wall
AFLAGS= -f elf64
LDFLAGS= -g -no-pie
SOURCESC= crack.c
SOURCESASM= 
OBJECTSC= $(SOURCESC:.c=.o)
OBJECTSASM= $(SOURCESASM:.S=.o) 
EXECUTABLE=runcrack

all: $(SOURCESC) $(SOURCESASM) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTSC) $(OBJECTSASM)
	$(LD) $(LDFLAGS) $(OBJECTSC) $(OBJECTSASM) -o $@

.c.o: 	
	$(CC) $(CFLAGS) $< -o $@

.S.o:
	$(ASM) $(AFLAGS) $< -o $@