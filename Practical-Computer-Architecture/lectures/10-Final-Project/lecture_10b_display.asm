# ============================================================
# 10b: عرض درجات الطلاب — Display Grades
# ============================================================
#
# ✨ نطبق:
#   .word      ← بيانات جاهزة
#   lw         ← قراءة من RAM
#   sll + add  ← الوصول إلى arr[i]
#   bge, addi, b ← حلقات
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    # مصفوفة جاهزة (5 درجات)
    grades: .word 85, 90, 78, 92, 88
    n:      .word 5

    msg_d:  .asciiz "\n--- Grades ---\n"
    msg_s:  .asciiz "Student "
    msg_c:  .asciiz ": "
    newline: .asciiz "\n"

.text
main:
    la $a0, msg_d
    li $v0, 4
    syscall

    la $s0, grades
    lw $s1, n
    li $t0, 0

disp_loop:
    bge $t0, $s1, done

    la $a0, msg_s
    li $v0, 4
    syscall

    addi $a0, $t0, 1
    li $v0, 1
    syscall

    la $a0, msg_c
    li $v0, 4
    syscall

    sll $t1, $t0, 2
    add $t1, $s0, $t1
    lw $a0, 0($t1)
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    addi $t0, $t0, 1
    b disp_loop

done:
    li $v0, 10
    syscall
