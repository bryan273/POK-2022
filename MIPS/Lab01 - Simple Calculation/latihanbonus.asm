.data
 	input1: .asciiz "Masukkan jumlah infantri: "
 	input2: .asciiz "Masukkan jumlah tank: "
 	input3: .asciiz "Masukkan jumlah pesawat tempur: "
 	input4: .asciiz "Masukkan jumlah batalion yang ingin dibentuk: "
	output1: .asciiz "\nMasing-masing batalion berisikan "
	infantri: .asciiz " infantri, "
	tank: .asciiz " tank, dan  "
	pesawat: .asciiz " pesawat tempur."
	except: .asciiz "\nInput tidak valid\n\n"
	no_remain: .asciiz "\nTidak ada pasukan yang tersisa di markas."
	remain: .asciiz "\nJumlah pasukan di markas tersisa "
 	
.text
.globl main
 
# Main condition
main:
	# Read input infantri
	li $v0, 4
 	la $a0, input1
 	syscall
 	
 	li $v0, 5 
 	syscall
 	add $s0, $v0, $zero
 	
 	# Read input tank
 	li $v0, 4
 	la $a0, input2 
 	syscall
 	
 	li $v0, 5 
 	syscall
 	add $s1, $v0, $zero
 	
 	# Read input pesawat tempur
 	li $v0, 4
 	la $a0, input3
 	syscall
 	
 	li $v0, 5 
 	syscall
 	add $s2, $v0, $zero
 	
 	# Read input batalion
 	li $v0, 4
 	la $a0, input4
 	syscall
 	
 	li $v0, 5 
 	syscall
 	add $s3, $v0, $zero
 	
 	# Division
 	div $s0, $s3
 	mflo $s0
 	mfhi $t0
 	
 	div $s1, $s3
 	mflo $s1
 	mfhi $t1
 	
 	div $s2, $s3
 	mflo $s2
 	mfhi $t2
 	
 	# Not valid input
 	beq $s0, 0, exception
 	beq $s1, 0, exception
 	beq $s2, 0, exception
 	beq $s3, 0, exception
 	
 	# Output result 
 	li $v0, 4
 	la $a0, output1
 	syscall
 	
 	# Output jumlah infantri per batalion
 	li $v0, 1
 	move $a0, $s0
 	syscall
 	
 	li $v0, 4
 	la $a0, infantri
 	syscall
 	
 	# Output jumlah tank per batalion
 	li $v0, 1
 	move $a0, $s1
 	syscall
 	
 	li $v0, 4
 	la $a0, tank
 	syscall
 	
 	# Output jumlah pesawat per batalion
 	li $v0, 1
 	move $a0, $s2
 	syscall
 	
 	li $v0, 4
 	la $a0, pesawat
 	syscall
 	
 	#Check remainder
	add $t3, $t0, $t1 
	add $t3, $t3, $t2
	
	beq $t3, 0, no_remainder
	j remainder
	 
	
# Input not valid condition
exception:
	li $v0, 4
 	la $a0, except
 	syscall
 	
 	j main

# If there is no remainder
no_remainder:
	li $v0, 4
 	la $a0, no_remain
 	syscall
 	
 	# exit
 	li $v0, 10 # exit
 	syscall

# If there is remainder 	
remainder:
	li $v0, 4
 	la $a0, remain
 	syscall
	
	# Output sisa infantri
 	li $v0, 1
 	move $a0, $t0
 	syscall
 	
 	li $v0, 4
 	la $a0, infantri
 	syscall
 	
 	# Output sisa tank
 	li $v0, 1
 	move $a0, $t1
 	syscall
 	
 	li $v0, 4
 	la $a0, tank
 	syscall
 	
 	# Output sisa pesawat
 	li $v0, 1
 	move $a0, $t2
 	syscall
 	
 	li $v0, 4
 	la $a0, pesawat
 	syscall
 	
	# exit
 	li $v0, 10 # exit
 	syscall