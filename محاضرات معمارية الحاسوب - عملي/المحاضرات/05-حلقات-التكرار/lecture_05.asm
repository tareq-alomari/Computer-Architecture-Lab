# ============================================================
# المحاضرة الخامسة: حلقات التكرار
# Lecture 5: Loops
# ============================================================
# يوضح هذا المثال حساب المضروب (Factorial) وطباعة الأرقام من 1 إلى 10
# Demonstrates factorial calculation and printing 1 to 10
# ============================================================

.data
    # رسائل البرنامج
    prompt:     .asciiz "Enter a positive integer for factorial: "
    result_msg: .asciiz "Factorial = "
    error_msg:  .asciiz "Error: Please enter a non-negative number.\n"
    factorial_of: .asciiz "! = "
    
    count_msg:  .asciiz "\nNumbers from 1 to 10: "
    space:      .asciiz " "
    newline:    .asciiz "\n"
    line:       .asciiz "\n------------------------\n"
    
    # رسالة للعرض الرأسي
    vertical_msg: .asciiz "\nNumbers from 1 to N (vertical):\n"
    enter_n:    .asciiz "Enter N: "

.text
.globl main

main:
    # ===== الجزء الأول: حساب المضروب (Factorial) =====
    
    la $a0, prompt
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0          # $s0 = n
    
    # التحقق من أن n >= 0
    bltz $s0, factorial_error
    
    # حساب المضروب باستخدام حلقة for
    li $t0, 1              # $t0 = result (factorial) البدء بـ 1
    li $t1, 1              # $t1 = counter (i) البدء بـ 1
    
factorial_loop:
    bgt $t1, $s0, factorial_done   # if (i > n) → خروج من الحلقة
    mul $t0, $t0, $t1              # result = result * i
    addi $t1, $t1, 1               # i++
    b factorial_loop
    
factorial_done:
    # طباعة النتيجة
    move $a0, $s0
    li $v0, 1
    syscall
    
    la $a0, factorial_of
    li $v0, 4
    syscall
    
    move $a0, $t0
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    b after_factorial
    
factorial_error:
    la $a0, error_msg
    li $v0, 4
    syscall
    
after_factorial:
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== الجزء الثاني: طباعة الأرقام من 1 إلى 10 =====
    
    la $a0, count_msg
    li $v0, 4
    syscall
    
    li $t2, 1              # $t2 = counter = 1
    
print_1_to_10:
    bgt $t2, 10, done_printing   # if (counter > 10) → خروج
    
    move $a0, $t2
    li $v0, 1
    syscall
    
    la $a0, space
    li $v0, 4
    syscall
    
    addi $t2, $t2, 1             # counter++
    b print_1_to_10
    
done_printing:
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== الجزء الثالث: طباعة من 1 إلى N (حلقة while) =====
    
    la $a0, vertical_msg
    li $v0, 4
    syscall
    
    la $a0, enter_n
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s1, $v0          # $s1 = N
    
    li $t3, 1              # $t3 = counter = 1
    
print_vertical_loop:
    bgt $t3, $s1, done_vertical   # while (counter <= N)
    
    move $a0, $t3
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    addi $t3, $t3, 1
    b print_vertical_loop
    
done_vertical:
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== الجزء الرابع: حساب مجموع الأرقام من 1 إلى N =====
    # استخدام حلقة لحساب المجموع
    
    li $t4, 1              # counter
    li $t5, 0              # sum = 0
    
sum_loop:
    bgt $t4, $s1, done_sum
    add $t5, $t5, $t4     # sum = sum + counter
    addi $t4, $t4, 1
    b sum_loop
    
done_sum:
    # طباعة المجموع (بالفعل تم الحساب في $t5)
    # يمكن إضافة طباعة هنا
    
    # ===== إنهاء البرنامج =====
    li $v0, 10
    syscall

# ============================================================
# ملخص التعليمات المستخدمة:
# addi - جمع مع قيمة فورية (Add Immediate)
# mul  - ضرب (Multiply)
# bgt  - فرع إذا كان أكبر (Branch if Greater Than)
# li   - تحميل قيمة فورية (Load Immediate)
# bltz - فرع إذا كان أقل من صفر (Branch if Less Than Zero)
# حلقة for: عداد + شرط خروج + تحديث العداد
# ============================================================
