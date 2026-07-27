# ============================================================
# 04d: القيمة المطلقة — Absolute Value
# ============================================================
#
# ✨ |x| = x if x > 0, -x if x < 0
#    نستخدم BLT مع SUB
# ============================================================

.data
    msg1: .asciiz "|-10| = "
    msg2: .asciiz "|7| = "
    newline: .asciiz "\n"

.text
main:
    # ---- |-10| ----
    li $t0, -10
    jal abs_func
    move $t1, $v0

    la $a0, msg1
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---- |7| ----
    li $t0, 7
    jal abs_func
    move $t1, $v0

    la $a0, msg2
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall

    li $v0, 10
    syscall

abs_func:
    bge $t0, $zero, positive
    sub $v0, $zero, $t0       # v0 = 0 - t0 (يعكس الإشارة)
    jr $ra

positive:
    move $v0, $t0
    jr $ra
