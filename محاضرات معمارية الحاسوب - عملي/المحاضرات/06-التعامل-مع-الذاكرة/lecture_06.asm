# ============================================================
# المحاضرة السادسة: التعامل مع الذاكرة
# Lecture 6: Memory Operations
# ============================================================
# يوضح هذا المثال تخزين وتحميل القيم من الذاكرة والتبديل بين قيمتين
# Demonstrates storing/loading values from memory and swapping
# ============================================================

.data
    # تعريف متغيرات في الذاكرة
    var1:       .word 42               # متغير بقيمة 42
    var2:       .word 100              # متغير بقيمة 100
    var3:       .word 0                # متغير للنتائج
    
    # مصفوفة لتوضيح تخزين قيم متعددة
    buffer:     .space 40              # 10 كلمات (40 بايت) كمساحة تخزين
    
    # رسائل البرنامج
    init_msg:   .asciiz "Initial values:\n"
    var1_msg:   .asciiz "var1 = "
    var2_msg:   .asciiz "var2 = "
    result_msg: .asciiz "var3 (result) = "
    
    enter_msg:  .asciiz "Enter a value to store: "
    stored_msg: .asciiz "Value stored at buffer[0]: "
    loaded_msg: .asciiz "Value loaded from buffer[0]: "
    
    swap_before: .asciiz "\nBefore swap:\n"
    swap_after:  .asciiz "\nAfter swap:\n"
    
    # رسائل لتوضيح عناوين الذاكرة
    addr_msg1:  .asciiz "Address of var1: 0x"
    addr_msg2:  .asciiz "Address of var2: 0x"
    
    newline:    .asciiz "\n"
    equal:      .asciiz " = "
    line:       .asciiz "------------------------\n"

.text
.globl main

main:
    # ===== 1. تحميل القيم من الذاكرة وعرضها =====
    
    la $a0, init_msg
    li $v0, 4
    syscall
    
    # تحميل var1 وعرضه
    la $a0, var1_msg
    li $v0, 4
    syscall
    
    lw $t0, var1           # $t0 = تحميل قيمة var1 من الذاكرة
    move $a0, $t0
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # تحميل var2 وعرضه
    la $a0, var2_msg
    li $v0, 4
    syscall
    
    lw $t1, var2           # $t1 = تحميل قيمة var2 من الذاكرة
    move $a0, $t1
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 2. عرض عناوين المتغيرات =====
    la $a0, line
    li $v0, 4
    syscall
    
    la $a0, addr_msg1
    li $v0, 4
    syscall
    
    la $t2, var1           # $t2 = عنوان var1
    move $a0, $t2
    li $v0, 34             # طباعة بالنظام الست عشري
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, addr_msg2
    li $v0, 4
    syscall
    
    la $t3, var2           # $t3 = عنوان var2
    move $a0, $t3
    li $v0, 34
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 3. تخزين قيمة جديدة في الذاكرة =====
    la $a0, line
    li $v0, 4
    syscall
    
    # إدخال قيمة جديدة
    la $a0, enter_msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $t4, $v0          # $t4 = قيمة الإدخال
    
    # تخزين القيمة في var3
    sw $t4, var3           # var3 = $t4 (تخزين في الذاكرة)
    
    # إظهار القيمة المخزنة
    la $a0, stored_msg
    li $v0, 4
    syscall
    
    lw $t5, var3           # تحميل var3 للتأكيد
    move $a0, $t5
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 4. تخزين وتحميل من مصفوفة (buffer) =====
    la $a0, line
    li $v0, 4
    syscall
    
    # تخزين القيمة التي أدخلها المستخدم في buffer[0]
    la $t6, buffer         # $t6 = العنوان الأساسي للمصفوفة
    sw $t4, 0($t6)         # buffer[0] = $t4
    
    # تحميل القيمة من buffer[0] وإظهارها
    lw $t7, 0($t6)         # $t7 = buffer[0]
    
    la $a0, loaded_msg
    li $v0, 4
    syscall
    
    move $a0, $t7
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # تخزين قيم متعددة في المصفوفة
    li $t8, 10
    sw $t8, 4($t6)         # buffer[1] = 10
    li $t8, 20
    sw $t8, 8($t6)         # buffer[2] = 20
    li $t8, 30
    sw $t8, 12($t6)        # buffer[3] = 30
    
    # ===== 5. التبديل بين قيمتين في الذاكرة (Swap) =====
    la $a0, line
    li $v0, 4
    syscall
    
    # عرض القيم قبل التبديل
    la $a0, swap_before
    li $v0, 4
    syscall
    
    la $a0, var1_msg
    li $v0, 4
    syscall
    
    lw $s0, var1
    move $a0, $s0
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, var2_msg
    li $v0, 4
    syscall
    
    lw $s1, var2
    move $a0, $s1
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # عملية التبديل (Swap) باستخدام تسجيل مؤقت
    la $t9, var1           # $t9 = عنوان var1
    lw $s2, 0($t9)         # $s2 = القيمة في var1
    lw $s3, 4($t9)         # $s3 = القيمة في var2 (تبعد 4 بايت)
    
    sw $s3, 0($t9)         # var1 = $s3 (القيمة القديمة لـ var2)
    sw $s2, 4($t9)         # var2 = $s2 (القيمة القديمة لـ var1)
    
    # عرض القيم بعد التبديل
    la $a0, swap_after
    li $v0, 4
    syscall
    
    la $a0, var1_msg
    li $v0, 4
    syscall
    
    lw $s4, var1
    move $a0, $s4
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, var2_msg
    li $v0, 4
    syscall
    
    lw $s5, var2
    move $a0, $s5
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 6. إضافة متغيرين من الذاكرة وتخزين النتيجة =====
    la $a0, line
    li $v0, 4
    syscall
    
    lw $s6, var1           # تحميل var1 (بعد التبديل)
    lw $s7, var2           # تحميل var2 (بعد التبديل)
    add $s6, $s6, $s7      # $s6 = var1 + var2
    
    sw $s6, var3           # تخزين النتيجة في var3
    
    la $a0, result_msg
    li $v0, 4
    syscall
    
    move $a0, $s6
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
# lw   - تحميل كلمة من الذاكرة (Load Word)
# sw   - تخزين كلمة في الذاكرة (Store Word)
# la   - تحميل عنوان (Load Address)
# .word - تعريف متغير بكلمة (4 بايت)
# .space - حجز مساحة في الذاكرة
# إزاحة (Offset): الوصول إلى عناوين مختلفة بإضافة قيمة للإزاحة
# مثل: sw $t0, 4($t6) يخزن في buffer[1]
# ============================================================
