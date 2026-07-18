# ============================================================
# المحاضرة التاسعة: الدوال والمكدس
# Lecture 9: Functions and Stack
# ============================================================
# يوضح هذا المثال دالة الأس (Power) ودالة المضروب مع الاستدعاء الذاتي
# Demonstrates power function and recursive factorial function
# ============================================================

.data
    # رسائل دالة الأس
    base_msg:   .asciiz "Enter base (x): "
    exp_msg:    .asciiz "Enter exponent (n): "
    power_msg:  .asciiz "\nPower: "
    
    # رسائل دالة المضروب
    fact_msg:   .asciiz "\nEnter a number for factorial: "
    fact_result: .asciiz "Factorial (recursive) = "
    fact_of:    .asciiz "! = "
    fact_iter_msg: .asciiz "Factorial (iterative) = "
    
    # رسائل أخرى
    error_msg:  .asciiz "Error: Factorial is not defined for negative numbers.\n"
    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"
    call_msg:   .asciiz "\n--- Testing functions with stack ---\n"

.text
.globl main

main:
    # ===== الجزء الأول: دالة الأس (Power) باستخدام المكدس =====
    
    # إدخال الأساس
    la $a0, base_msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0          # $s0 = base (x)
    
    # إدخال الأس
    la $a0, exp_msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s1, $v0          # $s1 = exponent (n)
    
    # استدعاء دالة power(base, exponent)
    move $a0, $s0          # المعامل الأول: base
    move $a1, $s1          # المعامل الثاني: exponent
    jal power_function     # استدعاء الدالة
    
    move $s2, $v0          # $s2 = النتيجة
    
    # طباعة النتيجة
    la $a0, power_msg
    li $v0, 4
    syscall
    
    move $a0, $s2
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== الجزء الثاني: دالة المضروب بالاستدعاء الذاتي (Recursive Factorial) =====
    
    la $a0, fact_msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s3, $v0          # $s3 = n
    
    # التحقق من الإدخال
    bltz $s3, fact_error
    
    # حساب المضروب باستخدام الاستدعاء الذاتي (recursive)
    move $a0, $s3
    jal factorial_recursive
    move $s4, $v0          # $s4 = النتيجة (recursive)
    
    # طباعة النتيجة
    move $a0, $s3
    li $v0, 1
    syscall
    
    la $a0, fact_of
    li $v0, 4
    syscall
    
    move $a0, $s4
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # حساب المضروب باستخدام التكرار (iterative) للمقارنة
    move $a0, $s3
    jal factorial_iterative
    move $s5, $v0
    
    la $a0, fact_iter_msg
    li $v0, 4
    syscall
    
    move $a0, $s5
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    b after_factorial
    
fact_error:
    la $a0, error_msg
    li $v0, 4
    syscall
    
after_factorial:
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== الجزء الثالث: استدعاء دالة من دالة أخرى =====
    
    la $a0, call_msg
    li $v0, 4
    syscall
    
    # حساب 2^3 + 4! باستخدام المكدس
    li $a0, 2
    li $a1, 3
    jal power_function
    move $t0, $v0          # $t0 = 2^3 = 8
    
    li $a0, 4
    jal factorial_recursive
    move $t1, $v0          # $t1 = 4! = 24
    
    add $t2, $t0, $t1      # $t2 = 8 + 24 = 32
    
    # طباعة 2^3 + 4! = 32
    li $v0, 4
    la $a0, power_msg
    syscall
    # (استخدام رسالة قديمة للتوضيح فقط)
    
    li $v0, 10
    syscall

# ============================================================
# دالة الأس (Power): حساب x^n
# المعاملات: $a0 = base (x), $a1 = exponent (n)
# الناتج: $v0 = x^n
# تستخدم المكدس لحفظ القيم
# ============================================================
power_function:
    # حفظ قيم التسجيلات على المكدس
    addi $sp, $sp, -12     # تخصيص مساحة في المكدس (3 كلمات)
    sw $ra, 0($sp)         # حفظ عنوان العودة
    sw $s0, 4($sp)         # حفظ $s0
    sw $s1, 8($sp)         # حفظ $s1
    
    move $s0, $a0          # $s0 = base
    move $s1, $a1          # $s1 = exponent
    
    li $t0, 1              # $t0 = result = 1
    li $t1, 0              # $t1 = counter = 0
    
power_loop:
    bge $t1, $s1, power_done   # if (counter >= exponent) → انتهى
    mul $t0, $t0, $s0          # result *= base
    addi $t1, $t1, 1           # counter++
    b power_loop
    
power_done:
    move $v0, $t0          # $v0 = النتيجة
    
    # استعادة القيم من المكدس
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12      # تحرير المساحة
    
    jr $ra                 # العودة للمتصل

# ============================================================
# دالة المضروب بالاستدعاء الذاتي (Recursive Factorial)
# المعاملات: $a0 = n
# الناتج: $v0 = n!
# مثال: factorial(5) = 5 * factorial(4)
# ============================================================
factorial_recursive:
    # حفظ قيم التسجيلات على المكدس
    addi $sp, $sp, -8      # تخصيص مساحة لكلمتين
    sw $ra, 0($sp)         # حفظ عنوان العودة
    sw $a0, 4($sp)         # حفظ المعامل n
    
    # حالة الأساس: إذا كان n <= 1, return 1
    li $t0, 1
    ble $a0, $t0, base_case
    
    # استدعاء factorial(n - 1)
    addi $a0, $a0, -1      # n - 1
    jal factorial_recursive # استدعاء ذاتي
    
    # $v0 = factorial(n - 1)
    lw $a0, 4($sp)         # استعادة n
    mul $v0, $a0, $v0      # $v0 = n * factorial(n - 1)
    
    b return_from_fact
    
base_case:
    li $v0, 1              # return 1
    
return_from_fact:
    lw $ra, 0($sp)         # استعادة عنوان العودة
    addi $sp, $sp, 8       # تحرير المساحة
    jr $ra

# ============================================================
# دالة المضروب بالتكرار (Iterative Factorial) للمقارنة
# المعاملات: $a0 = n
# الناتج: $v0 = n!
# ============================================================
factorial_iterative:
    li $v0, 1              # result = 1
    li $t0, 1              # counter = 1
    
fact_iter_loop:
    bgt $t0, $a0, fact_iter_done
    mul $v0, $v0, $t0      # result *= counter
    addi $t0, $t0, 1       # counter++
    b fact_iter_loop
    
fact_iter_done:
    jr $ra

# ============================================================
# ملخص التعليمات المستخدمة:
# المكدس (Stack): منطقة ذاكرة تستخدم لتخزين القيم مؤقتاً
# $sp - مؤشر المكدس (Stack Pointer)
# addi $sp, $sp, -N - تخصيص مساحة في المكدس
# sw  - حفظ قيمة في المكدس
# lw  - تحميل قيمة من المكدس
# jal - استدعاء دالة (Jump And Link)
# jr  - العودة من دالة (Jump Register)
# $ra - تسجيل عنوان العودة
# الاستدعاء الذاتي (Recursion): دالة تستدعي نفسها
# ============================================================
