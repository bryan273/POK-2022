// type of processor used
.include "m8515def.inc"
// defined name for register r2 with hasil
.def hasil = r2

// main function
main:
	// load imeddiate on Z register to point
	// on the beggining of flash memory in something
	// ZH to load the immediate in 8 bit higher address
	// ZL to load the immediate in 8 bit lower address
	// shift 1 time because of word addressing
	ldi ZH, HIGH(2*SOMETHING)
	ldi ZL, LOW(2*SOMETHING)

// loop function
loop:
	
	lpm // load constant byte pointed by Z into r0 
	tst r0 // test if r0 zero or minus, if yes Z will be set
	breq stop // if Z is set, go to stop
	mov r16, r0// move register r0 to r16

// funct1 function
funct1:
	cpi r16, 7 // compare r16 with immediate 7 (r16-7)
	brlt funct2// if r16 less than 7 (N xor V = 1 from cpi), go to funct 2
	subi r16, 7// substract r16 with 7
	rjmp funct1// jump to funct1

// funct2 function
funct2:
	add r1, r16 // r1 = r1 + r16
	adiw Zl, 1 // add immidate 1 to ZL 
	rjmp loop // jump to loop

// stop function
stop:
	mov hasil, R1 ; move R1 to hasil variable

// forever function
forever:
	// loop forever
	// final result of hasil is 12
	rjmp forever

// defined value that will be saved in program memory
SOMETHING:
.db 1, 3, 6, 9
.db 0, 0
