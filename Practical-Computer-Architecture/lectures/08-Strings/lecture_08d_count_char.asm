# ============================================================
# 08d: عد حرف معين في النص — Count Character
# ============================================================
#
# ✨ نعد كم مرة تكرر حرف 'l' في "hello"
# ============================================================

.data
    str: .asciiz "hello"
    msg: .asciiz "Count of 'l' = "
    newline: .asciiz "\n"

.text
main:
    la $t0, str
    li $t2, 0                # counter = 0
    li $t3, 108              # 'l' = 108

count_loop:
    lb $t1, 0($t0)
    beqz $t1, done_count

    bne $t1, $t3, skip
    addi $t2, $t2, 1         # وجدنا 'l' → زد العداد

skip:
    addi $t0, $t0, 1
    b count_loop

done_count:
    la $a0, msg
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall

    li $v0, 10
    syscall
