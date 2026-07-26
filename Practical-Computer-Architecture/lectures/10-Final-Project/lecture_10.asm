# ============================================================
# 10: المشروع النهائي — نظام درجات الطلاب
# ============================================================
#
# ✨ هذا المشروع يجمع كل ما تعلمناه:
#   .space, lw, sw     → الذاكرة والمصفوفة
#   sll, add           → الوصول إلى arr[i]
#   beq, bgt           → الشروط
#   addi, b            → الحلقات
#   div, mflo          → القسمة (المتوسط)
#
# للنسخ المبسّطة، راجع:
#   lecture_10a_input.asm    ← إدخال درجات فقط
#   lecture_10b_display.asm  ← عرض درجات فقط
#   lecture_10c_average.asm  ← حساب المتوسط فقط
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    grades: .space 200            # مصفوفة 50 درجة (50 × 4 بايت)
    n:      .word 0               # عدد الطلاب
    sum:    .word 0               # مجموع الدرجات

    menu:   .asciiz "\n1. Enter grades\n2. Display grades\n3. Show average\n4. Exit\nChoice: "
    msg_n:  .asciiz "Number of students: "
    msg_g:  .asciiz "Grade: "
    msg_d:  .asciiz "\n--- Grades ---\n"
    msg_s:  .asciiz "Student "
    msg_c:  .asciiz ": "
    msg_a:  .asciiz "Average = "
    msg_e:  .asciiz "Goodbye!\n"
    inv:    .asciiz "Invalid!\n"
    newline: .asciiz "\n"

.text
main:

    # ========================================
    # القائمة — اختر من 1 إلى 4
    # ========================================
menu:
    la $a0, menu                 # اطبع القائمة
    li $v0, 4
    syscall

    li $v0, 5                    # اقرأ choice
    syscall
    move $t0, $v0                # $t0 = choice

    beq $t0, 1, option1          # if choice == 1 → إدخال
    beq $t0, 2, option2          # if choice == 2 → عرض
    beq $t0, 3, option3          # if choice == 3 → متوسط
    beq $t0, 4, exit             # if choice == 4 → خروج

    la $a0, inv                  # غير صحيح → "Invalid!"
    li $v0, 4
    syscall
    b menu

    # ========================================
    # Option 1: إدخال الدرجات
    # ========================================
option1:
    la $a0, msg_n
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    sw $v0, n                    # n = عدد الطلاب

    sw $zero, sum                # sum = 0

    la $s0, grades
    lw $s1, n
    li $t0, 0                    # i = 0

input:
    bge $t0, $s1, done_input     # if i >= n → خلصنا

    la $a0, msg_g
    li $v0, 4
    syscall
    li $v0, 5
    syscall                      # $v0 = الدرجة

    sll $t1, $t0, 2
    add $t1, $s0, $t1
    sw $v0, 0($t1)               # grades[i] = درجة

    lw $t2, sum
    add $t2, $t2, $v0
    sw $t2, sum                  # sum += درجة

    addi $t0, $t0, 1
    b input
done_input:
    b menu

    # ========================================
    # Option 2: عرض الدرجات
    # ========================================
option2:
    la $a0, msg_d
    li $v0, 4
    syscall

    la $s0, grades
    lw $s1, n
    li $t0, 0

disp:
    bge $t0, $s1, done_disp

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
    b disp
done_disp:
    b menu

    # ========================================
    # Option 3: حساب المتوسط
    # ========================================
option3:
    la $a0, msg_a
    li $v0, 4
    syscall

    lw $t0, sum
    lw $t1, n
    div $t0, $t1                 # sum ÷ n
    mflo $a0                     # $a0 = ناتج القسمة
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall
    b menu

    # ========================================
    # Option 4: خروج
    # ========================================
exit:
    la $a0, msg_e
    li $v0, 4
    syscall
    li $v0, 10
    syscall
