# ============================================================
# 05c: عد تنازلي — Countdown 10 to 1
# ============================================================
#
# ✨ نعد من 10 نازل إلى 1
#    عكس for loop (i-- بدل i++)
# ============================================================

.data
    space: .asciiz " "
    newline: .asciiz "\n"

.text
main:
    li $t0, 10               # i = 10

countdown:
    blt $t0, 1, done          # if i < 1 → اخرج

    move $a0, $t0
    li $v0, 1
    syscall                   # اطبع i

    la $a0, space
    li $v0, 4
    syscall

    addi $t0, $t0, -1         # i-- (ينقص 1)
    b countdown

done:
    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10
    syscall
