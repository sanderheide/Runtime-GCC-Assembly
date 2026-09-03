.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

main:
	lw $a0, size
	la $a1, a
	la $a2, b
	la $a3, c
	
	jal mat_mul_asm
	
	li $v0, 10
	syscall
	
mat_mul_asm:
	# Same as asm.S but in MIPS
	li $t0, 0 #loop variabel k
	li $t1, 0 #loop variabel j
	li $t2, 0 #loop variabel i
	
loop_k:
	addi $t0, $t0, 1  # k = k + 1
	bne $t0, $a0, loop_k
	
loop_j:
	xor $t0, $t0, $t0 #xor den samme bitstrengen med seg selv, 0101 -> 0000, resets alle bits til 0 
	addi $t1, $t1, 1 # j = j + 1, inkrementerer j
	bne $t1, $a0, loop_k
	
loop_i:
	xor $t1, $t1, $t1
	addi $t2, $t2, 1 # i = 1 + 1
	bne $t2, $a0, loop_k
	
	jr $ra
