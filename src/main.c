#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

typedef unsigned int uint;

// Implement this function in x86_asm.S and mips_asm.S
extern void mat_mul_asm(uint size, uint* a, uint* b , uint* c);

// This is the C equivalent to the assembly implementation
void mat_mul_c(uint size, uint* a, uint* b , uint* c) {
    for(int i = 0; i < size; i++) {
        for(int j = 0; j < size; j++) {
            for(int k = 0; k < size; k++) {
                c[size*i + j] += a[size*i + k] * b[size*k + j];
            }
        }
    }
}

struct timespec timer_start(void)
{
    struct timespec start;
    clock_gettime(CLOCK_MONOTONIC, &start);
    return start;
}

double timer_stop(struct timespec start)
{
    struct timespec end;
    clock_gettime(CLOCK_MONOTONIC, &end);

    return (end.tv_sec - start.tv_sec)
         + (end.tv_nsec - start.tv_nsec) / 1000000000.0;
}

int main(int argc, char **argv) {
    // Initialisation
    uint size = 10;
    uint* a = malloc(size*size * sizeof(uint));
    uint* b = malloc(size*size * sizeof(uint));
    uint* c = malloc(size*size * sizeof(uint));
    for(int i = 0; i < size; i++) {
        for(int j = 0; j < size; j++) {
                a[size*i + j] = i+1;
                b[size*i + j] = j+1;
                c[size*i + j] = 0;
        }
    }
    
    struct timespec start = timer_start();

    //mat_mul_c(size, a, b, c);
    /* Or: mat_mul_asm(size, a, b, c); */
    mat_mul_asm(size, a, b, c); // Call this when the function is implemented

    double elapsed = timer_stop(start);

    printf("Execution time: %.9f seconds\n", elapsed);
    
    // Print result
    for (uint i = 0; i < size; i++) {
        for (uint j = 0; j < size; j++) {
            printf("%d ", c[size*i + j]);
        }
        printf("\n");
    }
}