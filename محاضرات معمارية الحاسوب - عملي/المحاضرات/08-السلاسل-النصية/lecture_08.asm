# ============================================================
# المحاضرة الثامنة: السلاسل النصية
# Lecture 8: String Operations
# ============================================================
# يوضح هذا المثال حساب طول السلسلة والتحويل من حرف صغير لكبير
# والتحقق من تماثل السلسلة (Palindrome)
# Demonstrates string length, lowercase to uppercase, palindrome check
# ============================================================

.data
    # سلاسل نصية للاختبار
    str1:       .asciiz "hello world"
    str2:       .asciiz "Racecar"
    str3:       .asciiz "A man a plan a canal panama"
    str4:       .asciiz "MIPS"
    
    # مخزن لإدخال المستخدم
    user_input: .space 100              # مساحة لإدخال سلسلة (max 99 حرف)
    buffer:     .space 100              # مساحة للنسخ
    
    # رسائل البرنامج
    len_msg:    .asciiz "String length of \""
    is_msg:     .asciiz "\" is: "
    chars_msg:  .asciiz " characters\n"
    
    input_str_msg:  .asciiz "\nEnter a string: "
    original_msg:   .asciiz "Original: "
    uppercase_msg:  .asciiz "Uppercase: "
    
    check_msg:  .asciiz "\nChecking palindrome:\n"
    str_msg:    .asciiz "String: "
    yes_msg:    .asciiz " -> YES, it is a palindrome!\n"
    no_msg:     .asciiz " -> NO, it is not a palindrome.\n"
    
    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"

.text
.globl main

main:
    # ===== 1. حساب طول السلسلة النصية =====
    
    la $a0, len_msg
    li $v0, 4
    syscall
    
    la $a0, str1
    li $v0, 4
    syscall
    
    la $a0, is_msg
    li $v0, 4
    syscall
    
    # حساب طول str1
    la $a0, str1           # تحميل عنوان السلسلة
    jal string_length      # استدعاء دالة حساب الطول
    move $t0, $v0          # $t0 = الطول
    
    move $a0, $t0
    li $v0, 1
    syscall
    
    la $a0, chars_msg
    li $v0, 4
    syscall
    
    # حساب طول str4
    la $a0, len_msg
    li $v0, 4
    syscall
    
    la $a0, str4
    li $v0, 4
    syscall
    
    la $a0, is_msg
    li $v0, 4
    syscall
    
    la $a0, str4
    jal string_length
    move $t1, $v0
    
    move $a0, $t1
    li $v0, 1
    syscall
    
    la $a0, chars_msg
    li $v0, 4
    syscall
    
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== 2. إدخال سلسلة من المستخدم والتحويل إلى uppercase =====
    
    la $a0, input_str_msg
    li $v0, 4
    syscall
    
    la $a0, user_input
    li $a1, 99             # الحد الأقصى لعدد الأحرف
    li $v0, 8              # syscall قراءة سلسلة
    syscall
    
    # طباعة السلسلة الأصلية
    la $a0, original_msg
    li $v0, 4
    syscall
    
    la $a0, user_input
    li $v0, 4
    syscall
    
    # تحويل إلى uppercase وطباعة النتيجة
    la $a0, uppercase_msg
    li $v0, 4
    syscall
    
    la $a0, user_input     # معامل الإدخال
    la $a1, buffer         # معامل الإخراج (المخزن)
    jal to_uppercase
    
    la $a0, buffer
    li $v0, 4
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== 3. التحقق من تماثل السلسلة (Palindrome) =====
    
    la $a0, check_msg
    li $v0, 4
    syscall
    
    # التحقق من str1
    la $a0, str_msg
    li $v0, 4
    syscall
    
    la $a0, str1
    li $v0, 4
    syscall
    
    la $a0, str1
    jal is_palindrome
    move $t2, $v0
    
    beqz $t2, not_pal1
    la $a0, yes_msg
    li $v0, 4
    syscall
    b after_pal1
    
not_pal1:
    la $a0, no_msg
    li $v0, 4
    syscall
    
after_pal1:
    # التحقق من str2 (Racecar - palindrome)
    la $a0, str_msg
    li $v0, 4
    syscall
    
    la $a0, str2
    li $v0, 4
    syscall
    
    la $a0, str2
    jal is_palindrome
    move $t3, $v0
    
    beqz $t3, not_pal2
    la $a0, yes_msg
    li $v0, 4
    syscall
    b after_pal2
    
not_pal2:
    la $a0, no_msg
    li $v0, 4
    syscall
    
after_pal2:
    # التحقق من str4 ("MIPS" - not palindrome)
    la $a0, str_msg
    li $v0, 4
    syscall
    
    la $a0, str4
    li $v0, 4
    syscall
    
    la $a0, str4
    jal is_palindrome
    move $t4, $v0
    
    beqz $t4, not_pal4
    la $a0, yes_msg
    li $v0, 4
    syscall
    b after_pal4
    
not_pal4:
    la $a0, no_msg
    li $v0, 4
    syscall
    
after_pal4:
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== إنهاء البرنامج =====
    li $v0, 10
    syscall

# ============================================================
# دالة حساب طول السلسلة النصية
# المعاملات: $a0 = عنوان السلسلة
# الناتج: $v0 = طول السلسلة
# ============================================================
string_length:
    li $v0, 0              # length = 0
    move $t0, $a0          # $t0 = مؤشر للسلسلة
    
length_loop:
    lb $t1, 0($t0)         # تحميل حرف من السلسلة
    beqz $t1, length_done  # إذا وصلنا إلى null → انتهى
    addi $v0, $v0, 1       # length++
    addi $t0, $t0, 1       # مؤشر++
    b length_loop
    
length_done:
    jr $ra                 # العودة للمتصل

# ============================================================
# دالة التحويل من أحرف صغيرة إلى كبيرة
# المعاملات: $a0 = عنوان السلسلة المصدر
#            $a1 = عنوان السلسلة الهدف (buffer)
# ============================================================
to_uppercase:
    move $t0, $a0          # $t0 = مؤشر المصدر
    move $t1, $a1          # $t1 = مؤشر الهدف
    
upper_loop:
    lb $t2, 0($t0)         # تحميل حرف
    beqz $t2, upper_done   # إذا وصلنا إلى null → انتهى
    
    # التحقق إذا كان الحرف صغيراً (a-z: 97-122)
    li $t3, 97             # 'a'
    blt $t2, $t3, not_lower
    li $t3, 122            # 'z'
    bgt $t2, $t3, not_lower
    
    # تحويل الحرف من صغير إلى كبير: الفرق = 32
    addi $t2, $t2, -32     # تحويل إلى uppercase
    
not_lower:
    sb $t2, 0($t1)         # تخزين الحرف في الهدف
    addi $t0, $t0, 1       # مؤشر المصدر++
    addi $t1, $t1, 1       # مؤشر الهدف++
    b upper_loop
    
upper_done:
    sb $zero, 0($t1)       # إضافة null terminator
    jr $ra

# ============================================================
# دالة التحقق من تماثل السلسلة (Palindrome)
# المعاملات: $a0 = عنوان السلسلة
# الناتج: $v0 = 1 إذا كانت palindrome، 0 إذا لم تكن
# ============================================================
is_palindrome:
    move $t0, $a0          # $t0 = مؤشر البداية (left)
    
    # حساب الطول أولاً
    move $t1, $a0          # $t1 = مؤقت للبحث عن النهاية
    li $t2, 0              # length = 0
    
pal_len_loop:
    lb $t3, 0($t1)
    beqz $t3, pal_len_done
    addi $t2, $t2, 1
    addi $t1, $t1, 1
    b pal_len_loop
    
pal_len_done:
    # $t2 = الطول، $t1 = مؤشر النهاية (بعد null)
    addi $t1, $t1, -1      # $t1 = مؤشر النهاية (right) - آخر حرف
    
    # مقارنة الحروف من البداية والنهاية
pal_check_loop:
    bge $t0, $t1, pal_true  # إذا التقى المؤشران → palindrome
    
    lb $t3, 0($t0)         # $t3 = حرف البداية
    lb $t4, 0($t1)         # $t4 = حرف النهاية
    
    bne $t3, $t4, pal_false  # إذا اختلف الحرفان → ليس palindrome
    
    addi $t0, $t0, 1       # left++
    addi $t1, $t1, -1      # right--
    b pal_check_loop
    
pal_true:
    li $v0, 1              # return 1 (true)
    jr $ra
    
pal_false:
    li $v0, 0              # return 0 (false)
    jr $ra

# ============================================================
# ملخص التعليمات المستخدمة:
# .asciiz - تعريف سلسلة نصية منتهية بـ null
# lb      - تحميل بايت (حرف) من الذاكرة (Load Byte)
# sb      - تخزين بايت (حرف) في الذاكرة (Store Byte)
# jal     - القفز إلى دالة (Jump And Link)
# jr      - القفز إلى عنوان التسجيل (Jump Register)
# $ra     - تسجيل عنوان العودة (Return Address)
# السلسلة النصية: مصفوفة من البايتات تنتهي بـ null (0)
# ============================================================
