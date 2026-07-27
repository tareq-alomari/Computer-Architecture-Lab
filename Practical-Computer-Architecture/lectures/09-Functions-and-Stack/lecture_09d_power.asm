# ============================================================
# 09d: دالة رفع — Power (a^b)
# ============================================================
#
# ✨ دالة تحسب a مرفوع للقوة b
#    مثل: int power(int a, int b) { ... }
#    تستخدم المكدس لأنها recursion
# ============================================================

.data
    msg: .asciiz "2^5 = "
    newline: .asciiz "\n"

.text
main:
    li $a0, 2
    li $a1, 5
    jal power

    move $t0, $v0

    la $a0, msg
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

power:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    li $t0, 1
    ble $a1, $t0, base

    addi $a1, $a1, -1
    jal power
    lw $a0, 4($sp)
    mul $v0, $a0, $v0
    b return_p

base:
    li $v0, 1

return_p:
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
