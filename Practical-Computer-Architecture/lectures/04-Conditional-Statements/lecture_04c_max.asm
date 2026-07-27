# ============================================================
# 04c: إيجاد أكبر رقم — Maximum of Two
# ============================================================
#
# ✨ قارن رقمين واطبع الأكبر
#    BGT = Branch if Greater Than
# ============================================================

.data
    msg: .asciiz "Max = "

.text
main:
    li $t0, 15
    li $t1, 9

    bgt $t0, $t1, t0_bigger   # if t0 > t1 → t0 هو الأكبر

    move $t2, $t1              # t1 هو الأكبر
    b print

t0_bigger:
    move $t2, $t0              # t0 هو الأكبر

print:
    la $a0, msg
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall                    # يظهر: 15

    li $v0, 10
    syscall
