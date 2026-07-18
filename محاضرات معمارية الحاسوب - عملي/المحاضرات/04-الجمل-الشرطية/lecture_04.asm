# ============================================================
# المحاضرة الرابعة: الجمل الشرطية
# Lecture 4: Conditional Statements
# ============================================================
# يوضح هذا المثال التحقق من زوجية/فردية الأرقام وتقدير الدرجات
# Demonstrates even/odd check and grade calculator (A,B,C,D,F)
# ============================================================

.data
    # رسائل التحقق من الزوجية
    enter_num:  .asciiz "Enter a number: "
    even_msg:   .asciiz "\nThe number is EVEN.\n"
    odd_msg:    .asciiz "\nThe number is ODD.\n"
    
    # رسائل تقدير الدرجات
    enter_grade: .asciiz "\nEnter your score (0-100): "
    grade_a:    .asciiz "Grade: A - Excellent!\n"
    grade_b:    .asciiz "Grade: B - Very Good!\n"
    grade_c:    .asciiz "Grade: C - Good!\n"
    grade_d:    .asciiz "Grade: D - Pass!\n"
    grade_f:    .asciiz "Grade: F - Failed!\n"
    invalid_msg: .asciiz "Invalid score! Must be between 0 and 100.\n"
    
    # رسائل مقارنة رقمين
    enter_a:    .asciiz "\nEnter first number (a): "
    enter_b:    .asciiz "Enter second number (b): "
    a_greater:  .asciiz "a is greater than b\n"
    b_greater:  .asciiz "b is greater than a\n"
    equal_msg:  .asciiz "a equals b\n"
    
    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"

.text
.globl main

main:
    # ===== الجزء الأول: التحقق من زوجية الرقم =====
    
    la $a0, enter_num
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0          # $t0 = رقم الإدخال
    
    # التحقق من الزوجية: إذا كان (num & 1) == 0 فهو زوجي
    andi $t1, $t0, 1       # $t1 = أقل بت (LSB)
    beqz $t1, is_even      # إذا كان $t1 == 0 → زوجي
    bnez $t1, is_odd       # إذا كان $t1 != 0 → فردي
    
is_even:
    la $a0, even_msg
    li $v0, 4
    syscall
    b after_even_odd
    
is_odd:
    la $a0, odd_msg
    li $v0, 4
    syscall
    
after_even_odd:
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== الجزء الثاني: مقارنة رقمين =====
    
    la $a0, enter_a
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $t2, $v0          # $t2 = a
    
    la $a0, enter_b
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $t3, $v0          # $t3 = b
    
    # مقارنة a مع b
    bgt $t2, $t3, a_bigger     # if (a > b) → a_bigger
    blt $t2, $t3, b_bigger     # if (a < b) → b_bigger
    beq $t2, $t3, numbers_equal # if (a == b) → equal
    b after_compare
    
a_bigger:
    la $a0, a_greater
    li $v0, 4
    syscall
    b after_compare
    
b_bigger:
    la $a0, b_greater
    li $v0, 4
    syscall
    b after_compare
    
numbers_equal:
    la $a0, equal_msg
    li $v0, 4
    syscall
    
after_compare:
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== الجزء الثالث: تقدير الدرجات =====
    # A: 90-100, B: 80-89, C: 70-79, D: 60-69, F: 0-59
    
    la $a0, enter_grade
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $t4, $v0          # $t4 = الدرجة (score)
    
    # التحقق من صحة المدخلات (0-100)
    bltz $t4, invalid      # إذا كانت الدرجة < 0 → غير صالحة
    bgt $t4, 100, invalid  # إذا كانت الدرجة > 100 → غير صالحة
    
    # تقدير الدرجة باستخدام سلسلة if-else
    # if (score >= 90) → A
    bge $t4, 90, grade_A
    
    # else if (score >= 80) → B
    bge $t4, 80, grade_B
    
    # else if (score >= 70) → C
    bge $t4, 70, grade_C
    
    # else if (score >= 60) → D
    bge $t4, 60, grade_D
    
    # else → F
    b grade_F
    
grade_A:
    la $a0, grade_a
    li $v0, 4
    syscall
    b after_grade
    
grade_B:
    la $a0, grade_b
    li $v0, 4
    syscall
    b after_grade
    
grade_C:
    la $a0, grade_c
    li $v0, 4
    syscall
    b after_grade
    
grade_D:
    la $a0, grade_d
    li $v0, 4
    syscall
    b after_grade
    
grade_F:
    la $a0, grade_f
    li $v0, 4
    syscall
    b after_grade
    
invalid:
    la $a0, invalid_msg
    li $v0, 4
    syscall
    
after_grade:
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== إنهاء البرنامج =====
    li $v0, 10
    syscall

# ============================================================
# ملخص التعليمات المستخدمة:
# beqz  - فرع إذا كان صفر (Branch if EQual to Zero)
# bnez  - فرع إذا لم يكن صفر (Branch if Not Equal to Zero)
# beq   - فرع إذا كان متساوياً (Branch if EQual)
# bne   - فرع إذا لم يكن متساوياً (Branch if Not Equal)
# bgt   - فرع إذا كان أكبر (Branch if Greater Than)
# bge   - فرع إذا كان أكبر أو يساوي (Branch if Greater or Equal)
# blt   - فرع إذا كان أصغر (Branch if Less Than)
# b     - فرع غير مشروط (Unconditional Branch)
# ============================================================
