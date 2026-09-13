.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

##############################
# name: mat_mul_asm
#
# input:
#       First arg:  uint size : rdi
#       Second arg: uint* a   : rsi
#       Third arg:  uint* b   : rdx
#       Fourth arg: uint* c   : rcx
#
# output:
#       Resultatet lagres i matrise c
#
# return:
#       void
#
# modifies:
#       rax, r8, r9, r10, r11
#
# notes:
#       Direkte implementasjon av matrise-multiplikasjonen fra C-koden
#
##############################
mat_mul_asm:

    mov     $0, %r8d              # i = 0

i_loop:
    cmp     %edi, %r8d
    je      finished

    mov     $0, %r9d              # j = 0

j_loop:
    cmp     %edi, %r9d
    je      i_done

    mov     $0, %r10d             # k = 0

k_loop:
    cmp     %edi, %r10d
    je      j_done


    # a[size*i + k]

    mov     %r8d, %r11d
    imul    %edi, %r11d
    add     %r10d, %r11d
    shl     $2, %r11d

    mov     (%rsi,%r11), %eax


    # b[size*k + j]

    mov     %r10d, %r11d
    imul    %edi, %r11d
    add     %r9d, %r11d
    shl     $2, %r11d

    # a[size*i + k] * b[size*k + j]

    imul    (%rdx,%r11), %eax


    # c[size*i + j]

    mov     %r8d, %r11d
    imul    %edi, %r11d
    add     %r9d, %r11d
    shl     $2, %r11d


    # c[size*i + j] += a[size*i + k] * b[size*k + j]

    add     %eax, (%rcx,%r11)


    add     $1, %r10d             # k++
    jmp     k_loop


j_done:
    add     $1, %r9d              # j++
    jmp     j_loop


i_done:
    add     $1, %r8d              # i++
    jmp     i_loop


finished:
    ret

