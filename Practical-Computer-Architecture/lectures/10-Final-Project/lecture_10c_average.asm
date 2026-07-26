# ============================================================
# 10c: حساب متوسط الدرجات — Calculate Average
# ============================================================
#
# ✨ نطبق:
#   .word      ← بيانات جاهزة
#   lw         ← قراءة من RAM
#   div, mflo  ← قسمة
#   sll, add   ← الوصول إلى arr[i]
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    grades: .word 85, 90, 78, 92, 88
    n:      .word 5

    msg_a:  .asciiz "Average = "
    newline: .asciiz "\n"

.text
main:
    la $s0, grades
    lw $s1, n
    li $t2, 0                # sum = 0
    li $t0, 0                # i = 0

sum_loop:
    bge $t0, $s1, calc_avg

    sll $t1, $t0, 2
    add $t1, $s0, $t1
    lw $t3, 0($t1)
    add $t2, $t2, $t3

    addi $t0, $t0, 1
    b sum_loop

calc_avg:
    div $t2, $s1             # sum ÷ n
    mflo $t4                 # $t4 = ناتج القسمة

    la $a0, msg_a
    li $v0, 4
    syscall

    move $a0, $t4
    li $v0, 1
    syscall

    li $v0, 10
    syscall
