.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

# Funksjonsargumenter:
# $a0 = size
# $a1 = adressen til matrise a
# $a2 = adressen til matrise b
# $a3 = adressen til matrise c
#
# Registre:
# $t0 = i
# $t1 = j
# $t2 = k
# $t3 = midlertidig beregning / adresse
# $t4 = verdi fra a
# $t5 = verdi fra b / produkt
# $t6 = verdi fra c
#
# li     = legg inn en konstant verdi i et register
# beq    = hopp hvis to registre er like
# b      = hopp til en label
# daddiu = legg til en konstant
# daddu  = legg sammen to registre
# dmultu = multipliser unsigned verdier
# mflo   = hent resultatet fra multiplikasjonen
# dsll   = shift left, brukes her for å gange indeks med 4
# lwu    = last inn en unsigned 32-bit verdi fra minnet
# sw     = lagre en 32-bit verdi i minnet
# jr     = returner til adressen i $ra
# nop    = gjør ingenting, brukes i branch delay slot


mat_mul_asm:
    li      $t0, 0                  # i = 0

i_loop:
    beq     $t0, $a0, finished
    nop

    li      $t1, 0                  # j = 0

j_loop:
    beq     $t1, $a0, i_done
    nop

    li      $t2, 0                  # k = 0

k_loop:
    beq     $t2, $a0, j_done
    nop


    # a[size*i + k]

    dmultu  $a0, $t0
    mflo    $t3
    daddu   $t3, $t3, $t2
    dsll    $t3, $t3, 2
    daddu   $t3, $a1, $t3
    lwu     $t4, 0($t3)


    # b[size*k + j]

    dmultu  $a0, $t2
    mflo    $t3
    daddu   $t3, $t3, $t1
    dsll    $t3, $t3, 2
    daddu   $t3, $a2, $t3
    lwu     $t5, 0($t3)


    # a[...] * b[...]

    dmultu  $t4, $t5
    mflo    $t5


    # c[size*i + j]

    dmultu  $a0, $t0
    mflo    $t3
    daddu   $t3, $t3, $t1
    dsll    $t3, $t3, 2
    daddu   $t3, $a3, $t3
    lwu     $t6, 0($t3)


    # c[...] += a[...] * b[...]

    daddu   $t6, $t6, $t5
    sw      $t6, 0($t3)


    daddiu  $t2, $t2, 1             # k++
    b       k_loop
    nop


j_done:
    daddiu  $t1, $t1, 1             # j++
    b       j_loop
    nop


i_done:
    daddiu  $t0, $t0, 1             # i++
    b       i_loop
    nop


finished:
    jr      $ra
    nop
