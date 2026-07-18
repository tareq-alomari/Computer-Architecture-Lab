# ============================================================
# المحاضرة الثالثة: العمليات المنطقية وإزاحة البتات
# Lecture 3: Logical Operations and Bit Shifting
# ============================================================
# يوضح هذا المثال استخراج بايت من كلمة والضرب بـ 8 باستخدام الإزاحة
# Demonstrates extracting byte from word and multiply by 8 using shift
# ============================================================

.data
    # القيمة المستخدمة في الأمثلة
    word_val:   .word 0x12345678      # كلمة من 4 بايتات
    
    # رسائل البرنامج
    orig_msg:   .asciiz "Original word: 0x12345678\n"
    byte0_msg:  .asciiz "Byte 0 (LSB): 0x"
    byte1_msg:  .asciiz "Byte 1: 0x"
    byte2_msg:  .asciiz "Byte 2: 0x"
    byte3_msg:  .asciiz "Byte 3 (MSB): 0x"
    
    enter_msg:  .asciiz "\nEnter a number: "
    shift_msg:  .asciiz "Number * 8 (using shift left by 3): "
    mul_msg:    .asciiz "Number * 8 (using multiply): "
    and_msg:    .asciiz "\nAND operation (0x12345678 & 0x0000FF00): 0x"
    or_msg:     .asciiz "OR operation (0x12345678 | 0x000000FF): 0x"
    xor_msg:    .asciiz "XOR operation (0x12345678 ^ 0xFFFFFFFF): 0x"
    
    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"

.text
.globl main

main:
    # ===== 1. استخراج البايتات من كلمة =====
    
    la $a0, orig_msg
    li $v0, 4
    syscall
    
    la $a0, line
    li $v0, 4
    syscall
    
    lw $s0, word_val       # تحميل القيمة الأصلية
    
    # استخراج Byte 0 (البتات 0-7) - أقل بايت
    # الطريقة: استخدم القناع 0xFF مع AND
    la $a0, byte0_msg
    li $v0, 4
    syscall
    
    andi $t0, $s0, 0xFF    # $t0 = $s0 & 0x000000FF
    move $a0, $t0
    li $v0, 34            # طباعة بالنظام الست عشري (hex)
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # استخراج Byte 1 (البتات 8-15)
    la $a0, byte1_msg
    li $v0, 4
    syscall
    
    srl $t1, $s0, 8        # إزاحة لليمين بـ 8 بتات
    andi $t1, $t1, 0xFF    # تطبيق القناع
    move $a0, $t1
    li $v0, 34
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # استخراج Byte 2 (البتات 16-23)
    la $a0, byte2_msg
    li $v0, 4
    syscall
    
    srl $t2, $s0, 16
    andi $t2, $t2, 0xFF
    move $a0, $t2
    li $v0, 34
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # استخراج Byte 3 (البتات 24-31) - أعلى بايت
    la $a0, byte3_msg
    li $v0, 4
    syscall
    
    srl $t3, $s0, 24
    andi $t3, $t3, 0xFF
    move $a0, $t3
    li $v0, 34
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 2. الضرب باستخدام الإزاحة: رقم * 8 = رقم << 3 =====
    la $a0, line
    li $v0, 4
    syscall
    
    la $a0, enter_msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s1, $v0          # $s1 = رقم الإدخال
    
    # الضرب باستخدام sll (Shift Left Logical)
    sll $t4, $s1, 3        # $t4 = $s1 << 3 = $s1 * 8
    
    la $a0, shift_msg
    li $v0, 4
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # التأكيد باستخدام mul
    mul $t5, $s1, 8        # $t5 = $s1 * 8
    
    la $a0, mul_msg
    li $v0, 4
    syscall
    
    move $a0, $t5
    li $v0, 1
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== 3. العمليات المنطقية: AND, OR, XOR =====
    la $a0, line
    li $v0, 4
    syscall
    
    # عملية AND
    la $a0, and_msg
    li $v0, 4
    syscall
    
    andi $t6, $s0, 0x0000FF00
    move $a0, $t6
    li $v0, 34
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # عملية OR
    la $a0, or_msg
    li $v0, 4
    syscall
    
    ori $t7, $s0, 0x000000FF
    move $a0, $t7
    li $v0, 34
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # عملية XOR
    la $a0, xor_msg
    li $v0, 4
    syscall
    
    xori $t8, $s0, 0xFFFFFFFF
    move $a0, $t8
    li $v0, 34
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    # ===== إنهاء البرنامج =====
    li $v0, 10
    syscall

# ============================================================
# ملخص التعليمات المستخدمة:
# andi - AND مع قيمة فورية (AND Immediate)
# ori  - OR مع قيمة فورية (OR Immediate)
# xori - XOR مع قيمة فورية (XOR Immediate)
# sll  - إزاحة يسار منطقية (Shift Left Logical)
# srl  - إزاحة يمين منطقية (Shift Right Logical)
# lw   - تحميل كلمة من الذاكرة (Load Word)
# syscall 34 - طباعة بالنظام الست عشري
# ============================================================
