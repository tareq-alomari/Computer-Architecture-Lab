# ============================================================
# 07c: عكس المصفوفة — Reverse Array
# ============================================================
#
# ✨ نعكس ترتيب المصفوفة
#    نبدل أول عنصر مع آخر عنصر ...
# ============================================================

.data
    arr:    .word 10, 20, 30, 40, 50
    msg:    .asciiz "Reversed: "
    space:  .asciiz " "
    newline: .asciiz "\n"

.text
main:
    la $s0, arr
    li $t0, 0                # i = 0 (يسار)
    li $t1, 4                # j = 4 (يمين) لأن 5-1=4

reverse:
    bge $t0, $t1, done_rev   # if i >= j → خلص

    sll $t2, $t0, 2
    add $t2, $s0, $t2
    lw $t4, 0($t2)           # t4 = arr[i]

    sll $t3, $t1, 2
    add $t3, $s0, $t3
    lw $t5, 0($t3)           # t5 = arr[j]

    sw $t5, 0($t2)           # arr[i] = t5
    sw $t4, 0($t3)           # arr[j] = t4

    addi $t0, $t0, 1         # i++
    addi $t1, $t1, -1        # j--
    b reverse

done_rev:
    la $a0, msg
    li $v0, 4
    syscall

    li $t0, 0
print_rev:
    bge $t0, 5, done

    sll $t1, $t0, 2
    add $t1, $s0, $t1
    lw $a0, 0($t1)
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall

    addi $t0, $t0, 1
    b print_rev

done:
    li $v0, 10
    syscall
