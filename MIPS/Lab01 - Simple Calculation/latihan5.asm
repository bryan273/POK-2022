.data
 	input1: .asciiz "Masukkan jumlah infantri: "
 	input2: .asciiz "Masukkan jumlah tank: "
 	input3: .asciiz "Masukkan jumlah pesawat tempur: "
	output1: .asciiz "\nTotal biaya yang dikeluarkan adalah $ "
	infantri: .word 100
	tank: .word 1500
	pesawat: .word 3000
 	
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
 	
 	# Load expenditure
 	lw $t0, infantri
 	lw $t1, tank
 	lw $t2, pesawat
 	
 	# Multiplication
 	mul $s0, $s0, $t0
 	mul $s1, $s1, $t1
 	mul $s2, $s2, $t2
 	
 	# result
 	add $s0, $s0, $s1
 	add $s0, $s0, $s2
 	
 	# Output result 
 	li $v0, 4
 	la $a0, output1
 	syscall
 	
 	# Output jumlah infantri per batalion
 	li $v0, 1
 	move $a0, $s0
 	syscall
 	
 	# exit
 	li $v0, 10 # exit
 	syscall

	
