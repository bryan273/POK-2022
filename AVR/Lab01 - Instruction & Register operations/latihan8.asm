.include "m8515def.inc"
// define a and b 
.def a = r2
.def b = r3

// point z to SOMETHING memory
main:
	ldi ZH, HIGH(2*SOMETHING)
	ldi ZL, LOW(2*SOMETHING)

// load a and b
load:
	// load a
	lpm
	mov a, r0
	adiw ZL, 1

	// load b
	lpm
	mov b, r0

// gcd function if the calculation a will be mod by b 
gcd_a_first:
	// check if a or b = 0
	tst a
	breq done_a
	tst b
	breq done_b
		
	// compare a with b
	cp a,b
	// if still greater than substract a with b
	brge mod_a_first

// gcd function if the calculation b will be mod by a 
gcd_b_first:
	// check if a or b = 0
	tst a
	breq done_a
	tst b
	breq done_b

	// compare b with a
	cp b,a
	// if still greater than substract b with a
	brge mod_b_first

// a mod b function
mod_a_first:
	// a = a - b
	sub a,b
	// compare a with b
	cp a,b
	// if still greater than substract a with b
	brge mod_a_first
	// go to gcd b first
	rjmp gcd_b_first

mod_b_first:
	// b = b - a
	sub b,a
	// compare b with a
	cp b,a
	// if still greater than substract b with a
	brge mod_b_first
	// go to gcd a first
	rjmp gcd_a_first

// if a zero, mov b to r1
done_a:
	mov r1, b
	rjmp forever

// if b zero, mov a to r1
done_b:
	mov r1, a
	rjmp forever

// program finished
forever:
	rjmp forever

// input user on a and b
SOMETHING:
	.db 5,13
	.db 0,0
