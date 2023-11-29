.data
frameBuffer: .space 0x80000 
m: .word 80
n: .word 40
.text
main:
la $t0, frameBuffer 
li $t1, 0x20000 
li $t2, 0x00FF00FF 
l1:
sw $t2, 0($t0)
addi $t0, $t0, 4 
addi $t1, $t1, -1 
bnez $t1, l1 
li $a0, 0x00FFFFFF 
lw $a1, m 
lw $a2, n 
li $t0, 256 
li $t1, 128 
move $t2, $a1 
andi $t2, $t2, 1 
beqz $t2, skipm 
addi $a1, $a1, 1 
skipm:
move $t2, $a2 
andi $t2, $t2, 1 
beqz $t2, skipn 
addi $a2, $a2, 1 
skipn:
srl $t2, $a2, 1 
sub $t3, $t1, $t2 
sub $t3, $t3, $a1 
bltz $t3, exit 
sll $t3, $t3, 11 
sub $t4, $t0, $t2 
sll $t4, $t4, 2 
add $t3, $t3, $t4 
la $t4, frameBuffer 
add $t3, $t3, $t4 
move $t4, $a1 
top_row:
move $t5, $a2 
move $t6, $t3 
top_col:
sw $a0, 0($t3) 
addi $t3, $t3, 4 
addi $t5, $t5, -1 
bnez $t5, top_col 
move $t3, $t6 
add $t3, $t3, 2048 
addi $t4, $t4, -1
bnez $t4, top_row 
sub $t3, $t1, $t2 
sll $t3, $t3, 11 
sub $t4, $t0, $t2
sub $t4, $t4, $a1 
sll $t4, $t4, 2 
add $t3, $t3, $t4 
la $t4, frameBuffer
add $t3, $t3, $t4 
move $t4, $a2 
c_row:
sll $t5, $a1, 1
add $t5, $t5, $a2
move $t6, $t3 
c_col:
sw $a0, 0($t3) 
addi $t3, $t3, 4
addi $t5, $t5, -1 
bnez $t5, c_col 
move $t3, $t6 
add $t3, $t3, 2048
addi $t4, $t4, -1 
bnez $t4, c_row 
exit:
li $v0, 10
syscall