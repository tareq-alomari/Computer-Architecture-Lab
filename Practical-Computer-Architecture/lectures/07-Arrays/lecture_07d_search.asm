# ============================================================
# 07d: البحث عن رقم في المصفوفة — Linear Search
# ============================================================
#
# ✨ نبحث عن رقم في المصفوفة
#    إذا وجدناه → نطبع مكانه
# ============================================================

.data
    arr:    .word 10, 20, 30, 40, 50
    msg_f:  .asciiz "Found at index "
    msg_nf: .asciiz "Not found\n"
    newline: .asciiz "\n"

.text
main:
    li $s1, 30               # الرقم المطلوب
    la $s0, arr
    li $t0, 0                # i = 0

search:
    bge $t0, 5, not_found

    sll $t1, $t0, 2
    add $t1, $s0, $t1
    lw $t2, 0($t1)           # t2 = arr[i]

    beq $t2, $s1, found
    addi $t0, $t0, 1
    b search

found:
    la $a0, msg_f
    li $v0, 4
    syscall
    move $a0, $t0
    li $v0, 1
    syscall
    b done

not_found:
    la $a0, msg_nf
    li $v0, 4
    syscall

done:
    li $v0, 10
    syscall
