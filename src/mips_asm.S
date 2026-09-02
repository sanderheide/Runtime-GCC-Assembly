.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

# li = load immediate, $st0 = i, $a0 = size, beq = branch if equal, nop = no operation, daddiu $t0, $t0, 1 = take current value in $t0, add 1 and put the result back into $t0
# Function arguments:
# $a0 = size
# $a1 = address of matrix a
# $a2 = address of matrix b
# $a3 = address of matrix c
#
# Current register plan:
# $t0 = i
# $t1 = temporary byte offset
# $t2 = temporary address
# $t3 = temporary value
# DADDU rd, rs, rt. rd = resultatregister, rs = førsteverdi, rt = andre verdi

mat_mul_asm:
    li      $t0, 0       # i = 0

i_loop:
    beq     $t0, $a0, finished      # if i == size, finish
    nop

   
    dsll $t1, $t0, 2        # $t1 = i * 4
    daddu   $t2, $t1, $a3   # $st2 = address of c[i] 
    daddiu  $t3, $t0, 1     # $t3 = i + 1
    sw      $t3, 0($t2)     # c[i] = i + 1


    daddiu  $t0, $t0, 1      # i++
    b       i_loop
    nop

finished:
   

    jr      $ra 
    nop
