
 .data
 	print: .asciiz "Masukkan Input 10 digit:"
 	array: .word 0,0,0,0,0,0,0,0,0,0
 
 .text
 .globl main
 
 main:	
 	# Load array 
 	la $s0, array
 	
 	# Read input
 	li $v0, 4
 	la $a0, print 
 	syscall
 	
 	li $v0, 5
 	syscall
 	
 	# Make temporary variable
 	addi $t0, $zero, 0 # counter variable
 	add $t1, $v0, $zero
 	
input_loop:
	# Divide and the remain will be value in array
 	div $t1, $t1, 10
 	mflo $t1
 	mfhi $t2
 	
 	# Add addres and counter , and loop it
 	# Until every value is in array (reversed)
 	sw $t2, 0($s0)
 	addi $s0, $s0, 4
 	addi $t0, $t0, 1
 	bne $t0, 10, input_loop
 	
 	# Make variable for first value for the next comparison
	lw $s1, -40($s0)
			
output:
	# Variable for the second value to compare with 1
	addi $s0, $s0, 4
	lw $s2, -40($s0)
	
	# If counter reach zero then exit
	subi $t0, $t0, 1
	beq $t0, 0, exit
	
	# Compare for substraction	
	slt $t3, $s1, $s2
	beq $t3, 1, lower
	beq $t3, 0, bigger

#For case s1 < s2	
lower:
	# Give output s2-s1
	li $v0, 1
	sub $a0, $s2, $s1
	syscall
	
	#Loop
	move $s1, $s2
	j output
	
#For case s1 > s2
bigger:
	# Give output s1-s2
	li $v0, 1
	sub $a0, $s1, $s2
	syscall
	
	#Loop
	move $s1, $s2
	j output

# Exit when finished
exit:
	li $v0, 10
	syscall


	
	
	
	
	
	
