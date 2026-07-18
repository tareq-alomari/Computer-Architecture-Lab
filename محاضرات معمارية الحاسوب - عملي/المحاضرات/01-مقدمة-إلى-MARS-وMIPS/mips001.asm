# ============================================================
# mips001.asm - مثال برنامج لجمع الأعداد حتى إدخال الصفر
# Example: Sum numbers until 0 is entered
# ============================================================
# مستوحى من دليل: شرح العمل على برنامج MARS
# ============================================================
# المنطق (Pseudocode):
#   count = 0
#   sum = 0
#   print "Enter a number: "
#   read x
#   while (x != 0):
#       count++
#       sum = sum + x
#       print "Enter a number: "
#       read x
#   print "You entered 0; finishing input."
#   print "Count = ", count
#   print "Sum = ", sum
# ============================================================

.data
    prompt:     .asciiz "Enter a number: "
    sum_msg:    .asciiz "\nSum of entered numbers: "
    count_msg:  .asciiz "\nNumber count: "
    zero_msg:   .asciiz "\nYou entered 0; input finished.\n"
    newline:    .asciiz "\n"

.text
.globl main

main:
    li $t0, 0                  # count = 0
    li $t1, 0                  # sum = 0

prompt_loop:
    la $a0, prompt
    li $v0, 4                  # print_string
    syscall

    li $v0, 5                  # read_int
    syscall
    move $t2, $v0              # t2 = x (input value)

    beq $t2, $zero, done_input # if x == 0, exit loop

    addi $t0, $t0, 1           # count++
    add $t1, $t1, $t2          # sum += x

    j prompt_loop              # repeat

done_input:
    la $a0, zero_msg
    li $v0, 4
    syscall

    la $a0, count_msg
    li $v0, 4
    syscall
    move $a0, $t0
    li $v0, 1                  # print_int
    syscall

    la $a0, sum_msg
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1                  # print_int
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10                 # exit
    syscall
