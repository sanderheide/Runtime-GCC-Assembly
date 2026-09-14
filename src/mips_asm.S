.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

	
#Registre
#sp: stackpointer, nødvendig for håndtering av reg s0-s3
#a0: antall rader og kolonner, kun kvadratiske matriser, så r = k
#a1: peker til mat A
#a2: peker til mat B
#a3: peker til mat C
#t0: loop var k
#t1: loop var j
#t2: loop var i
#t3: peker til indeks i A (rad)
#t8: buffer til indeks/addresse og verdien fra B
#t9: sizeof rad i bytes, size * 4 -> integer tar 4 bytes
#s0: går gjennom kolonne i mat B
#s1: pointer til neste element i mat c
#s2:
#s3: buffer for produkt

#ra: return address

mat_mul_asm:	

	daddiu $sp, $sp, -32	#setter av 32 bytes på stacken
	sd $s0, 0($sp)			#stack pointer peker til starten av stacken
	sd $s1, 8($sp)			#reg s1 peker til de neste 8 bytes i minneblokka
	sd $s2, 16($sp)			#osv
	sd $s3, 24($sp)			#osv
	
	li $t0, 0 				#loop variabel k
	li $t1, 0 				#loop variabel j
	li $t2, 0 				#loop variabel i
	dsll $t9, $a0, 2 		#radstørrelse i bytrs (a0(size) * 4)
	
	
loop_i:						#ytre loop, rad
	mul $t8, $t2, $a0		
	dsll $t8, $t8, 2
	daddu $t3, $a1, $t8
	daddu $s1, $a3, $t8
	li $t1, 0				#

loop_j:						#middle loop, kolonne
	dsll $t8, $t1, 2
	daddu $s0, $a2, $t8
	li $t0, 0
	li $s2, 0

loop_k:						#innste loop, regner produkt for rad og kolonne
	lw $s3, 0($t3)
	lw $t8, 0($s0)
	mul $s3, $s3, $t8
	daddu $s2, $s2, $s3
	daddiu $t3, $t3, 4
	daddu $s0, $s0, $t9
	daddiu $t0, $t0, 1
	bne $t0, $a0, loop_k

	dsubu $t3, $t3, $t9		#tilbakestiller peker i A etter at k - loop har kjørt ferdig
	sw $s2, 0($s1)
	daddiu $s1, $s1, 4
	daddiu $t1, $t1, 1
	bne $t1, $a0, loop_j

	daddiu $t2, $t2, 1
	bne $t2, $a0, loop_i

	ld $s0, 0($sp)			#restorer registre s0-s3 fra stack frame
	ld $s1, 8($sp)
	ld $s2, 16($sp)
	ld $s3, 24($sp)
	daddiu $sp, $sp, 32		#nullstiller sp(stackpointer)

	jr $ra