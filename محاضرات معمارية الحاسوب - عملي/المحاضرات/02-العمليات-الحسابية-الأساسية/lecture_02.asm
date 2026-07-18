# ============================================================
# المحاضرة الثانية: العمليات الحسابية الأساسية
# Lecture 2: Basic Arithmetic Operations - Simple Calculator
# ============================================================
# يوضح هذا المثال عمليات الجمع والطرح وحساب متوسط 3 أرقام
# Demonstrates addition, subtraction, and average of 3 numbers
# ============================================================

.data
    # رسائل الإدخال والإخراج
    prompt1:    .asciiz "Enter first number: "
    prompt2:    .asciiz "Enter second number: "
    prompt3:    .asciiz "Enter third number: "
    
    sum_msg:    .asciiz "\nSum = "
    sub_msg:    .asciiz "Subtraction (a - b - c) = "
    avg_msg:    .asciiz "Average = "
    remainder_msg: .asciiz " with remainder "
    
    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"

.text
.globl main

main:
    # ===== إدخال الأرقام الثلاثة =====
    
    # طباعة رسالة إدخال الرقم الأول
    la $a0, prompt1
    li $v0, 4
    syscall
    
    # قراءة الرقم الأول
    li $v0, 5
    syscall
    move $t0, $v0       # $t0 = الرقم الأول (a)
    
    # طباعة رسالة إدخال الرقم الثاني
    la $a0, prompt2
    li $v0, 4
    syscall
    
    # قراءة الرقم الثاني
    li $v0, 5
    syscall
    move $t1, $v0       # $t1 = الرقم الثاني (b)
    
    # طباعة رسالة إدخال الرقم الثالث
    la $a0, prompt3
    li $v0, 4
    syscall
    
    # قراءة الرقم الثالث
    li $v0, 5
    syscall
    move $t2, $v0       # $t2 = الرقم الثالث (c)
    
    # ===== عملية الجمع: a + b + c =====
    la $a0, sum_msg
    li $v0, 4
    syscall
    
    add $t3, $t0, $t1   # $t3 = a + b
    add $t3, $t3, $t2   # $t3 = (a + b) + c
    
    move $a0, $t3
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== عملية الطرح: a - b - c =====
    la $a0, sub_msg
    li $v0, 4
    syscall
    
    sub $t4, $t0, $t1   # $t4 = a - b
    sub $t4, $t4, $t2   # $t4 = (a - b) - c
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== حساب المتوسط: (a + b + c) / 3 =====
    la $a0, avg_msg
    li $v0, 4
    syscall
    
    add $t5, $t0, $t1   # $t5 = a + b
    add $t5, $t5, $t2   # $t5 = a + b + c
    
    li $t6, 3
    div $t5, $t6        # قسمة $t5 على 3
    
    mflo $t7            # $t7 = ناتج القسمة (quotient)
    mfhi $t8            # $t8 = باقي القسمة (remainder)
    
    move $a0, $t7
    li $v0, 1
    syscall
    
    # طباعة الباقي إذا كان موجوداً
    la $a0, remainder_msg
    li $v0, 4
    syscall
    
    move $a0, $t8
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== العمليات الإضافية: الضرب والقسمة =====
    la $a0, line
    li $v0, 4
    syscall
    
    # حساب a * b (الضرب)
    mul $t9, $t0, $t1   # $t9 = a * b
    
    # طباعة a * b
    li $v0, 4
    la $a0, line
    syscall
    
    # ===== إنهاء البرنامج =====
    li $v0, 10
    syscall

# ============================================================
# ملخص التعليمات المستخدمة:
# add  - جمع (Addition)
# sub  - طرح (Subtraction)
# div  - قسمة (Division)
# mul  - ضرب (Multiplication)
# mflo - نقل ناتج القسمة من LO (Move From LO)
# mfhi - نقل باقي القسمة من HI (Move From HI)
# move - نقل قيمة بين التسجيلات
# ============================================================
