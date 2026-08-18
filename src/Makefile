# Makefile for compiling and linking .C files with asm files
# 26.08.2022 (Fredrik Mørstad & Fredrik Fasteraune): 
# Added docker sub-command
# 21.08.2023 Øyvind Nohr:
# + updated course to x64


CC = gcc
# Optimization levels GCC https://gcc.gnu.org/onlinedocs/gnat_ugn/Optimization-Levels.html
# To change optimization levels on .C file change -O0 to either -O1, -O2, -O3, -Os, -Ofast
# -masm=att Compiles .C with at&t assembly systax
# -g adds debug information to the executable file
# Remove -g before any testing
CFLAGS = -masm=att -O0 -g
ASM_FILE = x86_asm.S
MIPS_EMU = qemu-mips64-static
X86_EMU = qemu-x86_64-static

all: program
mips64: CC = mips64-linux-gnuabi64-gcc # Change this according to your cross-compiler binary
mips64: CFLAGS = -static -O0 -g
mips64: ASM_FILE = mips_asm.S
mips64: program
x86: CC = x86_64-linux-gnu-gcc         # Change this according to your cross-compiler binary
x86: CFLAGS = -static -O0 -g
x86: ASM_FILE = x86_asm.S
x86: program

main: main.c Makefile
	$(CC) $(CFLAGS) -S -o $@.s $<  

# asm.S, mips.S and main has to exist before executing compilation targets
program: x86_asm.S mips_asm.S main
	$(CC) $(CFLAGS) -E $(ASM_FILE) > $@_pp.s
	$(CC) $(CFLAGS) main.s $@_pp.s -o $@

run:
	./program

run_mips64:
	$(MIPS_EMU) ./program
	
run_x86:
	$(X86_EMU) ./program

docker:
	docker build -t inf2200-a1 .
	docker run -u 1000:1000 -it -v ./:/src inf2200-a1:latest

.PHONY: clean
clean:
	rm -rf *.o *program *program_pp.s main.s
