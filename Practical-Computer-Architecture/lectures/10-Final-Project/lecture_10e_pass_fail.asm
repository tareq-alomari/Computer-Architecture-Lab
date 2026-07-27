# ============================================================
# 10e: عدد الناجحين والراسبين — Pass / Fail
# ============================================================
#
# ✨ النجاح = درجة ≥ 50
#    نعد كم طالب نجح وكم رسب
# ============================================================

.data
    grades: .word 85, 30, 78, 45, 92, 60, 20, 88
    n:      .word 8
    msg_p:  .asciiz "Passed: "
    msg_f:  .asciiz "Failed: "
    newline: .asciiz "\n"

.text
main:
    la $s0, grades
    lw $s1, n
    li $t0, 0                # i = 0
    li $t2, 0                # pass = 0
    li $t3, 0                # fail = 0

check:
    bge $t0, $s1, done_c

    sll $t1, $t0, 2
    add $t1, $s0, $t1
    lw $t4, 0($t1)           # t4 = grade

    li $t5, 50
    blt $t4, $t5, failed
    addi $t2, $t2, 1         # pass++
    b next

failed:
    addi $t3, $t3, 1         # fail++

next:
    addi $t0, $t0, 1
    b check

done_c:
    la $a0, msg_p
    li $v0, 4
    syscall
    move $a0, $t2
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    la $a0, msg_f
    li $v0, 4
    syscall
    move $a0, $t3
    li $v0, 1
    syscall

    li $v0, 10
    syscall
