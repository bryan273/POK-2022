.data
 	W1: .asciiz "Selamat datang di Kantin Pokpok Tercinta :D\n"
 	W2: .asciiz "1. Nasi Ayam Goreng  (Rp 25)\n2. Nasi Udang Goreng (Rp 30)\n3. Nasi Ikan Goreng  (Rp 15)\n(Note: Harga dalam ribuan)\n"
 	W3: .asciiz "Anda memesan: "
 	W4: .asciiz "Masukkan jumlah pesanan: "
 	W5: .asciiz "Daftar pesanan (Tuliskan dengan angka menu):\n"
 	W6: .asciiz "Terdapat "
 	W7: .asciiz " pesanan tidak valid\n"
 	W8: .asciiz "Total harga pesanan Anda (Dalam ribuan): "
 	NotValid: .asciiz "Masukkan Anda tidak valid\n"
 	one: .asciiz "Nasi Ayam Goreng\n"
 	two: .asciiz "Nasi Udang Goreng\n"
 	three: .asciiz "Nasi Ikan Goreng\n"
 	
.text
.globl main
 
main:
	li $v0, 4
 	la $a0, W1 # output
 	syscall
 	
 	li $v0, 4
 	la $a0, W2 # output
 	syscall
 	
 	addi $s1, $zero, 0 # variabel untuk tidak valid
 	addi $s2, $zero, 0 # variabel untuk harga
 	
 	li $v0, 4
 	la $a0, W4 # output
 	syscall
 	
 	li $v0, 5 # read input value 
 	syscall
 	addi $t5, $v0, 0 # t5 = loop count
 	
 	li $v0, 4
 	la $a0, W5 # output
 	syscall
 	
 	j main2
 
 main2: # check condition for looping
 	addi $t6, $zero, 0 # t6 = stop case for loop
 	bne $t5, $t6, loop # loop if not equal t5 and t6
 	
 	j exit

 loop:	
 	addi $t5, $t5, -1 # reduce t5 per loop
 	
 	addi $t1, $zero, 1 # Perintah untuk menu ke 1 
 	addi $t2, $zero, 2 # Perintah untuk menu ke 2
 	addi $t3, $zero, 3 # Perintah untuk menu ke 3
 	
 	li $v0, 5 # read input value 
 	syscall
 	add $t0, $v0, $zero
	
	beq $t0, $t1, menu_1 # Validate menu 1
	beq $t0, $t2, menu_2 # Validate menu 2
	beq $t0, $t3, menu_3 # Validate menu 3
	
	li $v0, 4
 	la $a0, NotValid # Menu is not valid
 	syscall
 	
 	addi, $s1, $s1, 1 # for counting not valid
 	
 	j main2
 	
menu_1:	# Check if menu 1
	li $v0, 4
	la $a0, W3 # output
 	syscall
	
	li $v0, 4
	la $a0, one # output
 	syscall
 	
 	addi, $s2, $s2, 25 # increase base price
 	
 	j main2

menu_2:	 # Check if menu 2
	li $v0, 4
	la $a0, W3 # output
 	syscall
	
	li $v0, 4
	la $a0, two # output
 	syscall
 	
 	addi, $s2, $s2, 30 # increase bace price

 	j main2
	
menu_3:	 # Check if menu 3
	li $v0, 4
	la $a0, W3 # output
 	syscall
	
	li $v0, 4
	la $a0, three # output
 	syscall
 	
 	addi, $s2, $s2, 15 # increase bace price

 	j main2

exit:
	li $v0, 4
	la $a0, W6 # output
 	syscall
 	
 	move $a0, $s1 # output
 	li $v0, 1
 	syscall
 	
 	li $v0, 4
	la $a0, W7 # output
 	syscall
 	
 	li $v0, 4
	la $a0, W8 # output
 	syscall
 	
 	move $a0, $s2 # output
 	li $v0, 1
 	syscall
 	
	li $v0, 10 # exit
 	syscall
	
