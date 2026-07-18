# ============================================================
# المحاضرة السابعة: المصفوفات
# Lecture 7: Arrays
# ============================================================
# يوضح هذا المثال قراءة وتخزين وطباعة مصفوفة وحساب مجموع عناصرها
# Demonstrates reading, storing, printing array and sum calculation
# ============================================================

.data
    # تعريف المصفوفات
    array:      .space 40              # مصفوفة تتسع لـ 10 أعداد (10 × 4 = 40 بايت)
    array_size: .word 10               # حجم المصفوفة
    
    # رسائل البرنامج
    enter_size: .asciiz "Enter array size (max 10): "
    enter_elem: .asciiz "Enter element ["
    close_brac: .asciiz "]: "
    
    print_msg:  .asciiz "\nArray elements:\n"
    sum_msg:    .asciiz "\nSum of array elements = "
    avg_msg:    .asciiz "Average = "
    max_msg:    .asciiz "Maximum element = "
    min_msg:    .asciiz "Minimum element = "
    
    arrow:      .asciiz " -> "
    newline:    .asciiz "\n"
    space:      .asciiz "  "
    line:       .asciiz "\n------------------------\n"
    
    # قيم افتراضية للمصفوفة (لتوضيح التهيئة)
    init_array: .word 5, 12, 8, 3, 15, 7, 10, 2, 9, 6

.text
.globl main

main:
    # ===== 1. إدخال حجم المصفوفة =====
    
    la $a0, enter_size
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0          # $s0 = حجم المصفوفة (n)
    
    # التحقق من أن الحجم بين 1 و 10
    li $t0, 1
    li $t1, 10
    blt $s0, $t0, fix_size
    bgt $s0, $t1, fix_size
    b after_size_check
    
fix_size:
    li $s0, 5              # تصحيح الحجم إلى 5 إذا كان غير صالح
    li $s0, 5              # استخدام قيمة افتراضية
    
after_size_check:
    # ===== 2. إدخال عناصر المصفوفة =====
    
    la $s1, array          # $s1 = العنوان الأساسي للمصفوفة
    li $t2, 0              # $t2 = عداد الحلقة (index = 0)
    
input_loop:
    bge $t2, $s0, input_done   # if (index >= n) → خروج
    
    # طباعة "Enter element [i]: "
    la $a0, enter_elem
    li $v0, 4
    syscall
    
    move $a0, $t2
    li $v0, 1
    syscall
    
    la $a0, close_brac
    li $v0, 4
    syscall
    
    # قراءة العنصر
    li $v0, 5
    syscall
    
    # تخزين العنصر في المصفوفة: array[index] = value
    sll $t3, $t2, 2        # $t3 = index * 4 (حجم الكلمة)
    add $t3, $s1, $t3      # $t3 = عنوان array[index]
    sw $v0, 0($t3)         # تخزين القيمة
    
    addi $t2, $t2, 1       # index++
    b input_loop
    
input_done:
    # ===== 3. طباعة عناصر المصفوفة =====
    
    la $a0, print_msg
    li $v0, 4
    syscall
    
    li $t2, 0              # إعادة ضبط العداد
    
print_loop:
    bge $t2, $s0, print_done
    
    # حساب عنوان العنصر
    sll $t3, $t2, 2
    add $t3, $s1, $t3
    lw $t4, 0($t3)         # $t4 = array[index]
    
    # طباعة العنصر
    move $a0, $t4
    li $v0, 1
    syscall
    
    la $a0, space
    li $v0, 4
    syscall
    
    addi $t2, $t2, 1
    b print_loop
    
print_done:
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 4. حساب مجموع عناصر المصفوفة =====
    
    li $t2, 0              # عداد
    li $s2, 0              # $s2 = المجموع (sum = 0)
    
sum_loop:
    bge $t2, $s0, sum_done
    
    sll $t3, $t2, 2
    add $t3, $s1, $t3
    lw $t4, 0($t3)
    
    add $s2, $s2, $t4     # sum += array[index]
    
    addi $t2, $t2, 1
    b sum_loop
    
sum_done:
    la $a0, sum_msg
    li $v0, 4
    syscall
    
    move $a0, $s2
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 5. حساب المتوسط =====
    
    la $a0, avg_msg
    li $v0, 4
    syscall
    
    div $s2, $s0           # sum / n
    mflo $t5               # $t5 = المتوسط (quotient)
    mfhi $t6               # $t6 = باقي القسمة
    
    move $a0, $t5
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 6. إيجاد أكبر عنصر (Maximum) =====
    
    lw $s3, 0($s1)         # $s3 = max = array[0] (القيمة الأولى)
    li $t2, 1              # نبدأ من العنصر الثاني
    
max_loop:
    bge $t2, $s0, max_done
    
    sll $t3, $t2, 2
    add $t3, $s1, $t3
    lw $t4, 0($t3)
    
    ble $t4, $s3, not_max  # if (array[i] <= max) → تخطي
    
    move $s3, $t4          # max = array[i]
    
not_max:
    addi $t2, $t2, 1
    b max_loop
    
max_done:
    la $a0, max_msg
    li $v0, 4
    syscall
    
    move $a0, $s3
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 7. إيجاد أصغر عنصر (Minimum) =====
    
    lw $s4, 0($s1)         # $s4 = min = array[0]
    li $t2, 1
    
min_loop:
    bge $t2, $s0, min_done
    
    sll $t3, $t2, 2
    add $t3, $s1, $t3
    lw $t4, 0($t3)
    
    bge $t4, $s4, not_min  # if (array[i] >= min) → تخطي
    
    move $s4, $t4          # min = array[i]
    
not_min:
    addi $t2, $t2, 1
    b min_loop
    
min_done:
    la $a0, min_msg
    li $v0, 4
    syscall
    
    move $a0, $s4
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== إنهاء البرنامج =====
    li $v0, 10
    syscall

# ============================================================
# ملخص التعليمات المستخدمة:
# مصفوفة (Array): مجموعة متتالية من الكلمات في الذاكرة
# الوصول لعنصر: address = base + (index * 4)
# sll  - إزاحة يسار للضرب بـ 4 (حجم الكلمة)
# .space - حجز مساحة للمصفوفة
# حلقة تكرار على المصفوفة: عداد + شرط + تحديث
# ============================================================
