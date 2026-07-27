# ============================================================
# 10d: ترتيب الدرجات تصاعدياً — Bubble Sort
# ============================================================
#
# ✨ نرتب الدرجات من الأصغر إلى الأكبر
#    Bubble Sort: loop + swap
# ============================================================

.data
    grades: .word 88, 78, 92, 85, 90
    n:      .word 5
    msg:    .asciiz "Sorted: "
    space:  .asciiz " "
    newline: .asciiz "\n"

.text
main:
    la $s0, grades
    lw $s1, n

    # ---- Bubble Sort ----
    li $t0, 0                # i = 0

outer:
    bge $t0, $s1, print
    li $t1, 0                # j = 0
    sub $t2, $s1, $t0
    addi $t2, $t2, -1

inner:
    bge $t1, $t2, next_i

    sll $t3, $t1, 2
    add $t3, $s0, $t3
    lw $t4, 0($t3)           # t4 = grades[j]

    addi $t5, $t1, 1
    sll $t5, $t5, 2
    add $t5, $s0, $t5
    lw $t6, 0($t5)           # t6 = grades[j+1]

    ble $t4, $t6, no_swap
    sw $t6, 0($t3)           # swap
    sw $t4, 0($t5)

no_swap:
    addi $t1, $t1, 1
    b inner

next_i:
    addi $t0, $t0, 1
    b outer

    # ---- طباعة النتيجة ----
print:
    la $a0, msg
    li $v0, 4
    syscall

    li $t0, 0
p_loop:
    bge $t0, $s1, done

    sll $t1, $t0, 2
    add $t1, $s0, $t1
    lw $a0, 0($t1)
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall

    addi $t0, $t0, 1
    b p_loop

done:
    li $v0, 10
    syscall
