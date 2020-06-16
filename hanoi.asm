.data
A:  .asciiz " A "
B:  .asciiz " B "
C:  .asciiz " C "
str_space: .asciiz " "
str_enter: .asciiz "\n" 
.text

 li $v0, 5
 syscall
 move $s0, $v0 #  $s0 = a
 move $a0, $s0
 la $a1, A
 la $a2, B
 la $a3, C
 jal hannuo
 li $v0, 10
 syscall
 
hannuo: 
 addi $sp, $sp, -20
 sw $a0, 0($sp)
 sw $a1, 4($sp)
 sw $a2, 8($sp)
 sw $a3, 12($sp)
 sw $ra, 16($sp)
 beq $a0, $0, move #if(n == 0) goto print
 
 lw $a0, 0($sp)
 move $t0, $a0 
 addi $a0, $a0, -1 #hannuo(n-1,one,two,three)
 lw $a1, 4($sp)
 lw $a2, 8($sp)
 lw $a3, 12($sp)
 jal hannuo
 
 addi $a0, $a0, 1 #move(n, one, two)
 li $v0, 1
 syscall
 li $v0, 4
 move $a0, $a1
 syscall
 move $a0, $a2
 syscall
 li $v0, 4
 la $a0, str_enter 
 syscall
 
 lw $a0, 0($sp)
 addi $a0, $a0, -1 #hannuo(n-1,three,two,one)
 lw $a1, 12($sp)
 lw $a2, 8($sp)
 lw $a3, 4($sp)
 jal hannuo
 
 addi $a0, $a0, 1 
 li $v0, 1  #move(n, two, three)
 syscall
 li $v0, 4
 move $a0, $a2
 syscall
 move $a0, $a1
 syscall
 li $v0, 4
 la $a0, str_enter 
 syscall
 
 lw $a0, 0($sp)
 addi $a0, $a0, -1 #hannuo(n-1,one,two,three)
 lw $a1, 4($sp)
 lw $a2, 8($sp)
 lw $a3, 12($sp)
 jal hannuo
 
 j return
 
 
 
move:
 move $t1, $a0  #move(n, one, two)
 li $v0, 1
 syscall
 li $v0, 4
 move $a0, $a1
 syscall
 move $a0, $a2
 syscall
 li $v0, 4
 la $a0, str_enter 
 syscall
 
 li $v0, 1  #move(n, two, three)
 move $a0, $t1
 syscall
 li $v0, 4
 move $a0, $a2
 syscall
 move $a0, $a3
 syscall
 li $v0, 4
 la $a0, str_enter 
 syscall
 
 j return
 
 
return:
 lw $a0, 0($sp)
 lw $a1, 4($sp)
 lw $a2, 8($sp)
 lw $a3, 12($sp)
 lw $ra, 16($sp)
 addi $sp, $sp, 20
 jr $ra