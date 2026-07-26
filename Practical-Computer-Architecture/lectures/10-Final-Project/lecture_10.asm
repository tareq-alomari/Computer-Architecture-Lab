# ============================================================
# المحاضرة العاشرة: المشروع النهائي — نظام درجات الطلاب
# ============================================================
#
# هذا المشروع يجمع كل المفاهيم:
#   .space, lw, sw     →  الذاكرة والمصفوفة
#   sll, add           →  الوصول إلى arr[i]
#   beq, bgt           →  الشروط
#   addi, b            →  الحلقات
#   div, mflo          →  القسمة (المتوسط)
# ----------------------------------

.data
    grades: .space 200            # مصفوفة 50 درجة  (50 × 4 بايت)
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
    # القائمة (Menu) — اختر من 1 إلى 4
    # ========================================
menu:
    la $a0, menu                 # اطبع القائمة
    li $v0, 4
    syscall
    li $v0, 5                    # اقرأ choice
    syscall
    move $t0, $v0                # $t0 = choice

    beq $t0, 1, option1          # إذا choice == 1 → إدخال درجات
    beq $t0, 2, option2          # إذا choice == 2 → عرض درجات
    beq $t0, 3, option3          # إذا choice == 3 → المتوسط
    beq $t0, 4, exit             # إذا choice == 4 → خروج
    la $a0, inv                  # وإلا → "Invalid!"
    li $v0, 4
    syscall
    b menu                       # ارجع إلى القائمة

    # ========================================
    # Option 1: Enter grades — إدخال الدرجات
    # ========================================
option1:
    la $a0, msg_n                # اسأل عن عدد الطلاب
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    sw $v0, n                    # n = عدد الطلاب

    sw $zero, sum                # sum = 0

    la $s0, grades               # $s0 = عنوان المصفوفة
    lw $s1, n                    # $s1 = n
    li $t0, 0                    # $t0 = i

input:
    bge $t0, $s1, done_input     # إذا i >= n → خلصنا

    la $a0, msg_g                # اطبع "Grade: "
    li $v0, 4
    syscall
    li $v0, 5                    # اقرأ درجة
    syscall

    sll $t1, $t0, 2              # $t1 = i × 4
    add $t1, $s0, $t1            # $t1 = عنوان grades[i]
    sw $v0, 0($t1)               # grades[i] = v0

    lw $t2, sum                  # sum += v0
    add $t2, $t2, $v0
    sw $t2, sum

    addi $t0, $t0, 1             # i++
    b input
done_input:
    b menu

    # ========================================
    # Option 2: Display grades — عرض الدرجات
    # ========================================
option2:
    la $a0, msg_d
    li $v0, 4
    syscall

    la $s0, grades
    lw $s1, n
    li $t0, 0                    # $t0 = i

disp:
    bge $t0, $s1, done_disp

    la $a0, msg_s                # اطبع "Student "
    li $v0, 4
    syscall
    addi $a0, $t0, 1             # اطبع رقم الطالب (i+1)
    li $v0, 1
    syscall
    la $a0, msg_c                # اطبع ": "
    li $v0, 4
    syscall

    sll $t1, $t0, 2              # grades[i]
    add $t1, $s0, $t1
    lw $a0, 0($t1)
    li $v0, 1
    syscall                      # اطبع الدرجة

    la $a0, newline
    li $v0, 4
    syscall

    addi $t0, $t0, 1
    b disp
done_disp:
    b menu

    # ========================================
    # Option 3: Average — حساب المتوسط
    # المتوسط = sum / n (قسمة صحيحة)
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
    # Option 4: Exit — خروج
    # ========================================
exit:
    la $a0, msg_e
    li $v0, 4
    syscall
    li $v0, 10
    syscall
