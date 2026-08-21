.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

.data

	A:
		.word 1, 2, 3
		.word 2, 3, 4
		.word 5, 6, 7

	B:
		.word 2, 2, 2
		.word 3, 3, 3
		.word 4, 4, 5

mat_mul_asm:
	# Same as asm.S but in MIPS
