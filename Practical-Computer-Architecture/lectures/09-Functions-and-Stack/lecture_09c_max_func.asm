# ============================================================
# 09c: دالة إيجاد الأكبر — Max Function
# ============================================================
#
# ✨ دالة تأخذ رقمين وترجع الأكبر
#    مثل: int max(int a, int b) { if (a>b) return a; return b; }
# ============================================================

.data
    msg: .asciiz "Max(15, 9) = "
    newline: .asciiz "\n"

.text
main:
    li $a0, 15
    li $a1, 9
    jal max_func

    move $t0, $v0

    la $a0, msg
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

max_func:
    bgt $a0, $a1, a_bigger
    move $v0, $a1
    jr $ra

a_bigger:
    move $v0, $a0
    jr $ra
