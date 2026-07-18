# ============================================================
# المحاضرة العاشرة: المشروع النهائي - نظام إدارة درجات الطلاب
# Lecture 10: Final Project - Student Grades Management System
# ============================================================
# نظام متكامل لإدارة درجات الطلاب مع:
# - قائمة تفاعلية (Menu)
# - إدخال درجات الطلاب
# - حساب المتوسط الحسابي
# - إيجاد أعلى وأقل درجة
# - حساب عدد الناجحين والراسبين
# ============================================================

.data
    # ثوابت البرنامج
    MAX_STUDENTS:   .word 50           # الحد الأقصى لعدد الطلاب
    
    # مصفوفة لتخزين درجات الطلاب
    grades:         .space 200         # 50 طالب × 4 بايت = 200 بايت
    
    # متغيرات
    num_students:   .word 0            # عدد الطلاب الفعلي
    sum_grades:     .word 0            # مجموع الدرجات
    average:        .word 0            # المتوسط
    max_grade:      .word 0            # أعلى درجة
    min_grade:      .word 100          # أقل درجة (قيمة ابتدائية)
    pass_count:     .word 0            # عدد الناجحين
    fail_count:     .word 0            # عدد الراسبين
    
    # قائمة الخيارات (Menu)
    menu_title:     .asciiz "\n========== Student Grades Management System ==========\n"
    menu_option1:   .asciiz "1. Enter grades\n"
    menu_option2:   .asciiz "2. Display all grades\n"
    menu_option3:   .asciiz "3. Calculate average\n"
    menu_option4:   .asciiz "4. Find maximum and minimum grades\n"
    menu_option5:   .asciiz "5. Count pass and fail\n"
    menu_option6:   .asciiz "6. Display statistics summary\n"
    menu_option7:   .asciiz "7. Exit\n"
    menu_prompt:    .asciiz "\nEnter your choice (1-7): "
    menu_line:      .asciiz "======================================================\n"
    
    # رسائل إدخال البيانات
    enter_num_msg:  .asciiz "Enter number of students (1-50): "
    enter_grade_msg: .asciiz "Enter grade for student "
    colon_msg:      .asciiz ": "
    invalid_msg:    .asciiz "Invalid input! Please try again.\n"
    invalid_range:  .asciiz "Grade must be between 0 and 100.\n"
    
    # رسائل عرض البيانات
    display_title:  .asciiz "\n--- Student Grades ---\n"
    student_label:  .asciiz "Student "
    grade_label:    .asciiz ": Grade = "
    no_data_msg:    .asciiz "\nNo data available. Please enter grades first.\n"
    
    # رسائل الإحصائيات
    avg_msg:        .asciiz "\n--- Average ---\n"
    avg_result:     .asciiz "Average grade: "
    avg_remainder:  .asciiz " remainder "
    
    min_max_msg:    .asciiz "\n--- Min & Max ---\n"
    max_result:     .asciiz "Maximum grade: "
    min_result:     .asciiz "Minimum grade: "
    
    pass_fail_msg:  .asciiz "\n--- Pass & Fail ---\n"
    pass_result:    .asciiz "Number of passed students: "
    fail_result:    .asciiz "Number of failed students: "
    pass_rate_msg:  .asciiz "Pass rate: "
    percent_msg:    .asciiz "%\n"
    passed_label:   .asciiz " PASSED"
    failed_label:   .asciiz " FAILED"
    
    stats_title:    .asciiz "\n========== Full Statistics Summary ==========\n"
    total_students: .asciiz "Total students: "
    stats_line:     .asciiz "----------------------------------------------\n"
    
    # رسالة الخروج
    exit_msg:       .asciiz "\nThank you! Program terminated.\n"
    
    # رسالة نجاح الإدخال
    success_msg:    .asciiz "Grades entered successfully!\n"
    
    # ثابت درجة النجاح
    pass_threshold: .word 50            # درجة النجاح = 50

.text
.globl main

main:
    # تهيئة المتغيرات
    sw $zero, num_students
    sw $zero, sum_grades
    sw $zero, average
    sw $zero, max_grade
    li $t0, 100
    sw $t0, min_grade
    sw $zero, pass_count
    sw $zero, fail_count

menu_loop:
    # عرض القائمة
    la $a0, menu_title
    li $v0, 4
    syscall
    
    la $a0, menu_option1
    li $v0, 4
    syscall
    
    la $a0, menu_option2
    li $v0, 4
    syscall
    
    la $a0, menu_option3
    li $v0, 4
    syscall
    
    la $a0, menu_option4
    li $v0, 4
    syscall
    
    la $a0, menu_option5
    li $v0, 4
    syscall
    
    la $a0, menu_option6
    li $v0, 4
    syscall
    
    la $a0, menu_option7
    li $v0, 4
    syscall
    
    la $a0, menu_line
    li $v0, 4
    syscall
    
    # إدخال اختيار المستخدم
    la $a0, menu_prompt
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0          # $t0 = choice
    
    # تنفيذ الخيار المختار
    li $t1, 1
    beq $t0, $t1, option_enter_grades
    
    li $t1, 2
    beq $t0, $t1, option_display
    
    li $t1, 3
    beq $t0, $t1, option_average
    
    li $t1, 4
    beq $t0, $t1, option_min_max
    
    li $t1, 5
    beq $t0, $t1, option_pass_fail
    
    li $t1, 6
    beq $t0, $t1, option_statistics
    
    li $t1, 7
    beq $t0, $t1, exit_program
    
    # خيار غير صالح
    la $a0, invalid_msg
    li $v0, 4
    syscall
    b menu_loop

# ============================================================
# الخيار 1: إدخال درجات الطلاب
# ============================================================
option_enter_grades:
    # إدخال عدد الطلاب
    la $a0, enter_num_msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0          # $s0 = عدد الطلاب
    
    # التحقق من صحة العدد
    li $t0, 1
    li $t1, 50
    blt $s0, $t0, invalid_num
    bgt $s0, $t1, invalid_num
    
    sw $s0, num_students   # حفظ عدد الطلاب
    
    # تهيئة المتغيرات
    sw $zero, sum_grades
    sw $zero, pass_count
    sw $zero, fail_count
    li $t2, 0
    sw $t2, max_grade
    li $t2, 100
    sw $t2, min_grade
    
    # إدخال درجات الطلاب
    la $s1, grades         # $s1 = عنوان مصفوفة الدرجات
    li $t2, 0              # $t2 = عداد (index = 0)
    
input_grades_loop:
    bge $t2, $s0, input_grades_done
    
    # طباعة "Enter grade for student i: "
    la $a0, enter_grade_msg
    li $v0, 4
    syscall
    
    addi $t3, $t2, 1       # رقم الطالب (1-based)
    move $a0, $t3
    li $v0, 1
    syscall
    
    la $a0, colon_msg
    li $v0, 4
    syscall
    
    # قراءة الدرجة
    li $v0, 5
    syscall
    move $t4, $v0          # $t4 = الدرجة
    
    # التحقق من صحة الدرجة (0-100)
    bltz $t4, invalid_grade
    li $t5, 100
    bgt $t4, $t5, invalid_grade
    
    # تخزين الدرجة في المصفوفة
    sll $t5, $t2, 2        # $t5 = index * 4
    add $t5, $s1, $t5      # $t5 = عنوان grades[index]
    sw $t4, 0($t5)         # grades[index] = grade
    
    # تحديث المجموع
    lw $t6, sum_grades
    add $t6, $t6, $t4
    sw $t6, sum_grades
    
    # تحديث أعلى درجة
    lw $t7, max_grade
    ble $t4, $t7, not_new_max
    sw $t4, max_grade
not_new_max:
    
    # تحديث أقل درجة
    lw $t8, min_grade
    bge $t4, $t8, not_new_min
    sw $t4, min_grade
not_new_min:
    
    # حساب الناجحين والراسبين
    lw $t9, pass_threshold
    blt $t4, $t9, count_fail
    
    # ناجح
    lw $t9, pass_count
    addi $t9, $t9, 1
    sw $t9, pass_count
    b after_pass_fail_count
    
count_fail:
    # راسب
    lw $t9, fail_count
    addi $t9, $t9, 1
    sw $t9, fail_count
    
after_pass_fail_count:
    addi $t2, $t2, 1       # index++
    b input_grades_loop
    
invalid_num:
    la $a0, invalid_msg
    li $v0, 4
    syscall
    b option_enter_grades  # إعادة المحاولة
    
invalid_grade:
    la $a0, invalid_range
    li $v0, 4
    syscall
    # نطلب إدخال الدرجة مرة أخرى (نكرر نفس index)
    b input_grades_loop
    
input_grades_done:
    la $a0, success_msg
    li $v0, 4
    syscall
    b menu_loop

# ============================================================
# الخيار 2: عرض جميع الدرجات
# ============================================================
option_display:
    lw $t0, num_students
    blez $t0, no_data
    
    la $a0, display_title
    li $v0, 4
    syscall
    
    la $s1, grades
    li $t1, 0              # index
    
display_loop:
    bge $t1, $t0, display_done
    
    # طباعة "Student X: Grade = Y"
    la $a0, student_label
    li $v0, 4
    syscall
    
    addi $t2, $t1, 1
    move $a0, $t2
    li $v0, 1
    syscall
    
    la $a0, grade_label
    li $v0, 4
    syscall
    
    sll $t2, $t1, 2
    add $t2, $s1, $t2
    lw $t3, 0($t2)
    move $a0, $t3
    li $v0, 1
    syscall
    
    # طباعة حالة النجاح/الرسوب
    lw $t4, pass_threshold
    bge $t3, $t4, show_pass
    la $a0, failed_label
    li $v0, 4
    syscall
    b after_show_status
    
show_pass:
    la $a0, passed_label
    li $v0, 4
    syscall
    
after_show_status:
    la $a0, newline
    li $v0, 4
    syscall
    
    addi $t1, $t1, 1
    b display_loop
    
display_done:
    b menu_loop

# ============================================================
# الخيار 3: حساب المتوسط
# ============================================================
option_average:
    lw $t0, num_students
    blez $t0, no_data
    
    la $a0, avg_msg
    li $v0, 4
    syscall
    
    la $a0, avg_result
    li $v0, 4
    syscall
    
    lw $t1, sum_grades
    lw $t2, num_students
    
    div $t1, $t2
    mflo $t3              # $t3 = quotient (المتوسط)
    mfhi $t4              # $t4 = remainder (الباقي)
    
    sw $t3, average
    
    move $a0, $t3
    li $v0, 1
    syscall
    
    # طباعة الباقي إذا كان موجوداً
    beqz $t4, avg_no_remainder
    
    la $a0, avg_remainder
    li $v0, 4
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
avg_no_remainder:
    la $a0, newline
    li $v0, 4
    syscall
    b menu_loop

# ============================================================
# الخيار 4: إيجاد أعلى وأقل درجة
# ============================================================
option_min_max:
    lw $t0, num_students
    blez $t0, no_data
    
    la $a0, min_max_msg
    li $v0, 4
    syscall
    
    la $a0, max_result
    li $v0, 4
    syscall
    
    lw $t1, max_grade
    move $a0, $t1
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, min_result
    li $v0, 4
    syscall
    
    lw $t2, min_grade
    move $a0, $t2
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    b menu_loop

# ============================================================
# الخيار 5: حساب عدد الناجحين والراسبين
# ============================================================
option_pass_fail:
    lw $t0, num_students
    blez $t0, no_data
    
    la $a0, pass_fail_msg
    li $v0, 4
    syscall
    
    la $a0, pass_result
    li $v0, 4
    syscall
    
    lw $t1, pass_count
    move $a0, $t1
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, fail_result
    li $v0, 4
    syscall
    
    lw $t2, fail_count
    move $a0, $t2
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # حساب نسبة النجاح
    la $a0, pass_rate_msg
    li $v0, 4
    syscall
    
    lw $t3, pass_count
    li $t4, 100
    mul $t3, $t3, $t4      # pass_count * 100
    lw $t4, num_students
    div $t3, $t4
    mflo $t5               # $t5 = pass rate %
    
    move $a0, $t5
    li $v0, 1
    syscall
    
    la $a0, percent_msg
    li $v0, 4
    syscall
    b menu_loop

# ============================================================
# الخيار 6: عرض إحصائيات كاملة
# ============================================================
option_statistics:
    lw $t0, num_students
    blez $t0, no_data
    
    la $a0, stats_title
    li $v0, 4
    syscall
    
    la $a0, stats_line
    li $v0, 4
    syscall
    
    # عدد الطلاب
    la $a0, total_students
    li $v0, 4
    syscall
    
    lw $t1, num_students
    move $a0, $t1
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # المتوسط
    la $a0, avg_result
    li $v0, 4
    syscall
    
    lw $t2, sum_grades
    lw $t3, num_students
    div $t2, $t3
    mflo $t4
    sw $t4, average
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # أعلى درجة
    la $a0, max_result
    li $v0, 4
    syscall
    
    lw $t5, max_grade
    move $a0, $t5
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # أقل درجة
    la $a0, min_result
    li $v0, 4
    syscall
    
    lw $t6, min_grade
    move $a0, $t6
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # الناجحين
    la $a0, pass_result
    li $v0, 4
    syscall
    
    lw $t7, pass_count
    move $a0, $t7
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # الراسبين
    la $a0, fail_result
    li $v0, 4
    syscall
    
    lw $t8, fail_count
    move $a0, $t8
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, stats_line
    li $v0, 4
    syscall
    b menu_loop

# ============================================================
# حالة عدم وجود بيانات
# ============================================================
no_data:
    la $a0, no_data_msg
    li $v0, 4
    syscall
    b menu_loop

# ============================================================
# الخيار 7: الخروج من البرنامج
# ============================================================
exit_program:
    la $a0, exit_msg
    li $v0, 4
    syscall
    
    li $v0, 10
    syscall

# بيانات إضافية
newline: .asciiz "\n"

# ============================================================
# ملخص التعليمات المستخدمة:
# .word  - تعريف متغير بكلمة (4 بايت)
# .space - حجز مساحة في الذاكرة
# lw/sw  - تحميل/تخزين كلمة من/في الذاكرة
# sll    - إزاحة يسار (للوصول لعناصر المصفوفة)
# beq/bne/bgt/bge/blt/ble - فروع شرطية
# div/mflo/mfhi - قسمة والحصول على الناتج والباقي
# ============================================================
# هذا المشروع النهائي يجمع كل المفاهيم السابقة:
# - المتغيرات والذاكرة
# - المصفوفات
# - الحلقات التكرارية
# - الجمل الشرطية
# - القوائم التفاعلية
# - العمليات الحسابية
# ============================================================
