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
	dsll $t9, $a0, 2 #radsize i bytes
	
loop_i:
	mul $t8, $t2, $a0
	dsll $t8, $t8, 2
	daddu $t3, $a1, $t8
	daddu $t5, $a3, $t8
	li $t1, 0				#j = 0

loop_j:
	dsll $t8, $t1, 2
	daddu $t4, $a2, $t8
	li $t0, 0
	li $t6, 0

loop_k:
	lw $t7, 0($t3)
	lw $t8, 0($t4)
	mul $t7, $t7, $t8
	daddu $t6, $t6, $t7
	daddiu $t3, $t3, 4
	daddu $t4, $t4, $t9
	daddiu $t0, $t0, 1
	bne $t0, $a0, loop_k

	dsubu $t3, $t3, $t9
	sw $t6, 0($t5)
	daddiu $t5, $t5, 4
	daddiu $t1, $t1, 1
	bne $t1, $a0, loop_j

	daddiu $t2, $t2, 1
	bne $t2, $a0, loop_i

	jr $ra
