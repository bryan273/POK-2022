.include "m8515def.inc"

// define variable
.def one = r1 // variable for immediate 1
.def n = r16
.def result = r17 // variable for saving result
.def branch1 = r18 // variable for showing first branch
.def branch2 = r19 // variable for showing second branch
.def temp = r20 // temporary variable
.def temp2 = r21
.def input = r22 // variable for recursive input


start:
	// initiate stack pointer to the most bottom
	ldi temp, low(RAMEND)
	out SPL, temp
	ldi temp, high(RAMEND)
	out SPH, temp

	// load immediate 1 for checking fib(1) basecase
	ldi temp, 1
	mov one, temp
	
	// input length sequence
	ldi n, 10
	ldi temp2, 0

	// load address
	ldi r26, $60
	ldi r27, $00

loop:
	// restart result
	ldi result, 0

	// input for fibbonanci , fib(n)
	mov input, temp2
	rcall fibonacci

	// increment temp2 for loop
	subi temp2, -1

	// result to temp and store to memory , then increase counter
	mov temp, result
	st X+, temp
	
	// if incrementer same as n , then stop
	// if not , loop again
	cp n, temp2
	brne loop
	breq forever

// loop forever (program end)
forever:
	rjmp forever

// fibonacci recursive method
fibonacci:
	// push data to stack for this branch, so the data isn't changed
	push input
	push branch1
	push branch2
	push temp
	
	// if input is zero , go to basecase zero
	tst input
	breq basecase_zero

	// if input is one , go to basecase one
	cp input, one
	brbs 1, basecase_one

	// decrease branch 1 by 1 and branch 2 by 2
	// fib(n) = fib(n-1) + fib(n-2)
	mov branch1, input
	dec branch1
	mov branch2, input
	subi branch2, 2
	
	// finish running branch1 first
	mov input, branch1
	rcall fibonacci

	// move result to temporary
	mov temp, result
	
	// finish running branch	
	mov input, branch2
	rcall fibonacci

	// add the result from temporary 
	add result, temp
	rjmp done

// fib(0)=0
basecase_zero:
	ldi result, 0
	rjmp done

// fib(1)=1
basecase_one:
	ldi result, 1

// if the branch is done, pop the previous branch
done:
	pop temp
	pop branch2
	pop branch1
	pop input
	ret
