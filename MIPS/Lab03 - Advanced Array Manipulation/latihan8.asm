 .data
 	sorted: .asciiz "Data yang sudah diurutkan: "
 	med: .asciiz "\nMediannya adalah: "
 	mod: .asciiz "\nModusnya adalah: "
 	comma: .asciiz ", "
 	array: .byte 12, 13, 41, 15, 90
 
 .text
 .globl main
 
 main:	
 	# call array and temporary incrementer
 	la $s0, array
 	li $t5, 0
 	li $t4, 0
 	li $t3, 1
 	li $t2, 1
 	
 sort:
 	#load first value
 	lb $s1, 0($s0) 
 	
 	#load second value
 	lb $s2, 1($s0)
 	
 	# if already reach max length array
 	beq $s2, $zero, checkLoop
 	
 	# if second value is higher , than swap
 	slt $t0, $s1, $s2
 	beq $t0, 1, swap
 
 # incrementer
 increment:
 	# increment then sort again
 	addi $t5, $t5, 1
 	addi $s0, $s0, 1
 	j sort
 
 # swap first and second and then increment offset
 swap: 
 	# swap value in array
 	move $t1, $s1
 	sb $s2, 0($s0)
 	sb $t1, 1($s0)
 	j increment
 
 # check if we have to do inside loop again
 checkLoop:
 	# if already no loop inside loop
 	beq $t5, $zero, pointerToZero
 	
 	# sort next $s0
 	sub $s0, $s0, $t5
 	addi $s0, $s0, 1
 	addi $t5, $zero, 0
 	j sort
 
 # Set pointer to zero
 pointerToZero:
	
 	lb $t6, 0($s0)
 	beq $t6, 0, temp
 	subi $s0, $s0, 1
 	addi $t4, $t4, 1
 	j pointerToZero
 
 # temporary to set pointer zero
 temp:
 	addi $s0, $s0, 1
 	
 	# Output message sort
 	li $v0, 4
 	la $a0, sorted
 	syscall
 
 # set pointer to last
 pointerToLast:
 	lb $t6, 0($s0)
 	beq $t6, 0, tempy
 	addi $s0, $s0, 1
 	j pointerToLast
 
 # set pointer to last (temp)
 tempy:
 	subi $s0, $s0, 1
 	
 # print array that has been sorted	
 printSort:
 	
 	# print array if hasn't reach max length
 	li $v0, 1
	lb $a0, 0($s0)
	beq $a0, 0, median
	syscall
	
	# Output message comma
 	li $v0, 4
 	la $a0, comma
 	syscall
	
	# print sort
	subi $s0, $s0, 1
	j printSort

# calculate median of data
 median:
 	# pointer to first index
	addi $s0, $s0, 1
	
	# calculate index of median
	div $s6, $t4, 2
	add $s0, $s0, $s6
	
	# output message median
	li $v0, 4
 	la $a0, med
 	syscall
 	
 	# output median
 	li $v0, 1
	lb $a0, 0($s0)
	syscall
	
	# output message modus
	li $v0, 4
 	la  $a0, mod
 	syscall
	
	# pointer to last
	add $s0, $s0, $s6
	
# find modus
 modus:
 	lb $s3, 0($s0)
 	subi $s0, $s0, 1
 	lb $s2, 0($s0)
 	
 	# check condition
 	beq $s2, $zero, temp3
 	bne $s3, $s2, compare
 	addi $t3, $t3, 1
 	j modus
 
 # condition new candidate modus lower or higher
 compare:
 	slt $t5, $t2, $t3
 	beq $t5, 0, modus

# condition swap if higher modus
 switch:
 	move $t2, $t3
 	li $t3, 1
 	j modus
 
 # temporary to set pointer last
 temp3:
 	addi $s0, $s0, 1
 	add $s0, $s0, $s6
 	add $s0, $s0, $s6
 	li $t3, 1
 	
 valueModus:
 	# load first second value
 	lb $s3, 0($s0)
 	subi $s0, $s0, 1
 	lb $s2, 0($s0)
 	
 	# check condition
 	beq $s2, $zero, exit
 	bne $s3, $s2, reset
 	addi $t3, $t3, 1
 	
 	# print modus if equal to modus
 	beq $t3,$t2, printModus
 	j valueModus
 	
 # if not equal reset the counter
 reset:
 	li $t3, 1
 	j valueModus
 
 printModus:
 	# output modus
 	li $v0, 1
	lb $a0, 0($s0)
	syscall
	
	# output comma
 	li $v0, 4
	la $a0, comma
	syscall
	
	j valueModus
 
 		
# exit program
 exit: 	
	li $v0, 10
	syscall
