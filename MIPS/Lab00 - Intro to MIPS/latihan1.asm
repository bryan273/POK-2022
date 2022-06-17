.data
 	W1: .asciiz "Selamat datang di Kantin Pokpok Tercinta :D\n"
 	W2: .asciiz "1. Nasi Ayam Goreng  (Rp 25)\n2. Nasi Udang Goreng (Rp 30)\n3. Nasi Ikan Goreng  (Rp 15)\n(Note: Harga dalam ribuan)\nMasukkan pesanan Anda (tulisan dengan angka menu): "
 	W3: .asciiz "Anda memesan: "
 	one: .asciiz "Nasi Ayam Goreng\n"
 	two: .asciiz "Nasi Udang Goreng\n"
 	three: .asciiz "Nasi Ikan Goreng\n"
 	
.text
.globl main
 
 main:
 	addi $t1, $zero, 1 # Perintah untuk menu ke 1 
 	addi $t2, $zero, 2 # Perintah untuk menu ke 2
 	addi $t3, $zero, 3 # Perintah untuk menu ke 3
 	
 	li $v0, 4
 	la $a0, W1 # output
 	syscall
 	
 	li $v0, 4
 	la $a0, W2 # output
 	syscall
 	
 	li $v0, 5 # read input value 
 	syscall
 	add $t0, $v0, $zero
	
	beq $t0, $t1, menu_1 # Validate menu 1
	beq $t0, $t2, menu_2 # Validate menu 2
	beq $t0, $t3, menu_3 # Validate menu 3
 	
menu_1:	 # Check if menu 1
	li $v0, 4
	la $a0, W3 # output
 	syscall
	
	li $v0, 4
	la $a0, one # output
 	syscall
 	
 	li $v0, 10 # exit
 	syscall

menu_2:	 # Check if menu 2
	li $v0, 4
	la $a0, W3 # output
 	syscall
	
	li $v0, 4
	la $a0, two # output
 	syscall
 	
 	li $v0, 10 # exit
 	syscall
	
menu_3:	 # Check if menu 3
	li $v0, 4
	la $a0, W3 # output
 	syscall
	
	li $v0, 4
	la $a0, three # output
 	syscall
 	
 	li $v0, 10 # exit
 	syscall
