.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

	
mat_mul_asm:	
	# Same as asm.S but in MIPS
	daddiu $sp, $sp, -32 
	sd $s0, 0($sp)
	sd $s1, 8($sp)
	sd $s2, 16($sp)
	sd $s3, 24($sp)
	
	li $t0, 0 #loop variabel k
	li $t1, 0 #loop variabel j
	li $t2, 0 #loop variabel i
	dsll $t9, $a0, 2 #radsize i 4 bytes
	
	
loop_i:
	mul $t8, $t2, $a0
	dsll $t8, $t8, 2
	daddu $t3, $a1, $t8
	daddu $s1, $a3, $t8
	li $t1, 0				#j = 0

loop_j:
	dsll $t8, $t1, 2
	daddu $s0, $a2, $t8
	li $t0, 0
	li $s2, 0

loop_k:
	lw $s3, 0($t3)
	lw $t8, 0($s0)
	mul $s3, $s3, $t8
	daddu $s2, $s2, $s3
	daddiu $t3, $t3, 4
	daddu $s0, $s0, $t9
	daddiu $t0, $t0, 1
	bne $t0, $a0, loop_k

	dsubu $t3, $t3, $t9
	sw $s2, 0($s1)
	daddiu $s1, $s1, 4
	daddiu $t1, $t1, 1
	bne $t1, $a0, loop_j

	daddiu $t2, $t2, 1
	bne $t2, $a0, loop_i

	ld $s0, 0($sp)
	ld $s1, 8($sp)
	ld $s2, 16($sp)
	ld $s3, 24($sp)
	daddiu $sp, $sp, 32

	jr $ra