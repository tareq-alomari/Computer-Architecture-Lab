# ============================================================
# 06e: نسخ من RAM إلى RAM — Copy Word
# ============================================================
#
# ✨ ننسخ قيمة من x إلى y
#    lw من المصدر → sw إلى الهدف
# ============================================================

.data
    x: .word 42
    y: .word 0
    msg_x: .asciiz "x = "
    msg_y: .asciiz ", y = "
    newline: .asciiz "\n"

.text
main:
    lw $t0, x               # $t0 = x (42)
    sw $t0, y               # y = $t0 (الآن y = 42)

    la $a0, msg_x
    li $v0, 4
    syscall
    lw $a0, x
    li $v0, 1
    syscall
    la $a0, msg_y
    li $v0, 4
    syscall
    lw $a0, y
    li $v0, 1
    syscall

    li $v0, 10
    syscall
