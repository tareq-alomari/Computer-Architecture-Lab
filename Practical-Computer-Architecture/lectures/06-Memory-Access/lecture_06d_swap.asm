# ============================================================
# 06d: مبادلة قيمتين في RAM — Swap
# ============================================================
#
# ✨ نبدل قيم متغيرين في الذاكرة:
#    temp = a; a = b; b = temp;
# ============================================================

.data
    a: .word 5
    b: .word 9
    msg_a: .asciiz "a = "
    msg_b: .asciiz ", b = "
    newline: .asciiz "\n"

.text
main:
    # ---- اطبع قبل المبادلة ----
    la $a0, msg_a
    li $v0, 4
    syscall
    lw $a0, a
    li $v0, 1
    syscall
    la $a0, msg_b
    li $v0, 4
    syscall
    lw $a0, b
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---- المبادلة ----
    lw $t0, a               # $t0 = a
    lw $t1, b               # $t1 = b
    sw $t1, a               # a = $t1 (قيمة b)
    sw $t0, b               # b = $t0 (قيمة a)

    # ---- اطبع بعد المبادلة ----
    la $a0, msg_a
    li $v0, 4
    syscall
    lw $a0, a
    li $v0, 1
    syscall
    la $a0, msg_b
    li $v0, 4
    syscall
    lw $a0, b
    li $v0, 1
    syscall

    li $v0, 10
    syscall
