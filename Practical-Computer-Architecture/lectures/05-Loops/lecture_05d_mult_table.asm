# ============================================================
# 05d: جدول ضرب 5 — Multiplication Table
# ============================================================
#
# ✨ اطبع: 5 × 1 = 5, 5 × 2 = 10, ...
#    نستخدم حلقة مع MUL
# ============================================================

.data
    msg: .asciiz "5 x "
    eq:  .asciiz " = "
    newline: .asciiz "\n"

.text
main:
    li $t0, 5                # العدد الثابت
    li $t1, 1                # i = 1

table:
    bgt $t1, 10, done

    # اطبع "5 x "
    la $a0, msg
    li $v0, 4
    syscall

    # اطبع i
    move $a0, $t1
    li $v0, 1
    syscall

    # اطبع " = "
    la $a0, eq
    li $v0, 4
    syscall

    # اطبع 5 × i
    mul $t2, $t0, $t1
    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    addi $t1, $t1, 1
    b table

done:
    li $v0, 10
    syscall
