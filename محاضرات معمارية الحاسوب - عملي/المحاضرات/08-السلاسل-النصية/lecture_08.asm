# ============================================================
# ## المحاضرة الثامنة: السلاسل النصية
# ## Lecture 8: String Operations
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. حساب طول سلسلة نصية (string_length function):
#      Calculate string length:
#      a. المرور على كل بايت حتى الوصول إلى null (0)
#         Traverse each byte until reaching null (0)
#      b. عدّ الأحرف / Count characters
#      c. إرجاع الطول في $v0 / Return length in $v0
#   2. إدخال سلسلة من المستخدم والتحويل إلى uppercase:
#      Input string and convert to uppercase:
#      a. قراءة سلسلة باستخدام syscall 8 / Read string with syscall 8
#      b. لكل حرف: إذا كان بين 'a' (97) و 'z' (122) → اطرح 32
#         For each char: if between 'a'(97) and 'z'(122) → subtract 32
#      c. تخزين النتيجة في buffer / Store result in buffer
#   3. التحقق من تماثل السلسلة (Palindrome check):
#      Check palindrome:
#      a. حساب طول السلسلة / Calculate string length
#      b. مقارنة الحرف الأول مع الأخير، الثاني مع قبل الأخير...
#         Compare first char with last, second with second-last...
#      c. إذا تطابقت كل الأزواج → palindrome
#         If all pairs match → palindrome
#   4. إنهاء البرنامج / Exit program
#
# ## المفاهيم الأساسية / Key Concepts:
#   - السلسلة النصية: مصفوفة من البايتات تنتهي بـ null (\0 = 0)
#     String: array of bytes terminated by null (\0 = 0)
#   - lb : تحميل بايت (حرف واحد) من الذاكرة / Load Byte
#   - sb : تخزين بايت (حرف واحد) في الذاكرة / Store Byte
#   - الفرق بين الحرف الصغير والكبير = 32 في ASCII
#     Difference between lowercase and uppercase = 32 in ASCII
#   - 'a' = 97, 'A' = 65, الفرق = 32 / Difference = 32
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## سلاسل نصية للاختبار / Test Strings
    str1:       .asciiz "hello world"
    str2:       .asciiz "Racecar"
    str3:       .asciiz "A man a plan a canal panama"
    str4:       .asciiz "MIPS"

    ## مخازن / Buffers
    # user_input: مساحة 100 بايت لإدخال المستخدم (99 حرف + null)
    # user_input: 100-byte space for user input (99 chars + null)
    user_input: .space 100
    buffer:     .space 100              # مساحة للنسخ والتحويل

    ## رسائل البرنامج / Program Messages
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

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: حساب طول السلسلة النصية / Section 1: String Length
    ## ===================================================================
    ## السلسلة النصية في MIPS تنتهي بالحرف null (\0 = قيمة صفر)
    ## نحسب الطول بالمرور على كل حرف حتى نجد null

    ## --- 1.1: حساب طول str1 / Calculate Length of str1 ---
    la $a0, len_msg
    li $v0, 4
    syscall

    la $a0, str1
    li $v0, 4
    syscall                    # طباعة السلسلة نفسها

    la $a0, is_msg
    li $v0, 4
    syscall

    la $a0, str1               # $a0 = عنوان السلسلة (معامل الدالة)
    jal string_length          # استدعاء دالة حساب الطول
                               # jal = Jump And Link: يقفز للدالة ويحفظ عنوان العودة في $ra
    move $t0, $v0              # $t0 = الطول (القيمة المرجعة في $v0)

    move $a0, $t0
    li $v0, 1
    syscall                    # طباعة الطول

    la $a0, chars_msg
    li $v0, 4
    syscall

    ## --- 1.2: حساب طول str4 ("MIPS") / Calculate Length of str4 ---
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

    ## ===================================================================
    ## ## القسم 2: إدخال سلسلة والتحويل إلى Uppercase / Section 2: Uppercase
    ## ===================================================================
    ## syscall 8: قراءة سلسلة من المستخدم
    ## المعاملات: $a0 = عنوان المخزن، $a1 = الحد الأقصى للحروف

    ## --- 2.1: إدخال سلسلة من المستخدم / Input String from User ---
    la $a0, input_str_msg
    li $v0, 4
    syscall

    la $a0, user_input         # $a0 = عنوان المخزن
    li $a1, 99                 # $a1 = 99 (الحد الأقصى: 99 حرف + null)
    li $v0, 8                  # $v0 = 8 ← كود syscall لقراءة سلسلة
    syscall                    # يقرأ السلسلة ويخزنها في user_input

    ## --- 2.2: طباعة السلسلة الأصلية / Print Original String ---
    la $a0, original_msg
    li $v0, 4
    syscall

    la $a0, user_input
    li $v0, 4
    syscall

    ## --- 2.3: تحويل إلى uppercase / Convert to Uppercase ---
    la $a0, uppercase_msg
    li $v0, 4
    syscall

    la $a0, user_input         # $a0 = معامل الإدخال (المصدر)
    la $a1, buffer             # $a1 = معامل الإخراج (الهدف)
    jal to_uppercase           # استدعاء دالة التحويل

    ## --- 2.4: طباعة النتيجة / Print Result ---
    la $a0, buffer
    li $v0, 4
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 3: التحقق من تماثل السلسلة (Palindrome) / Section 3: Palindrome
    ## ===================================================================
    ## Palindrome: سلسلة تُقرأ من اليسار لليمين ومن اليمين لليسار بنفس الشكل
    ## Palindrome: string reads the same forwards and backwards
    ## مثال: "Racecar" (بدون حساسية حالة الأحرف)
    ## ملاحظة: هذه الدالة تتحقق من التطابق التام (case-sensitive)

    la $a0, check_msg
    li $v0, 4
    syscall

    ## --- 3.1: التحقق من str1 ("hello world") / Check str1 ---
    la $a0, str_msg
    li $v0, 4
    syscall

    la $a0, str1
    li $v0, 4
    syscall

    la $a0, str1
    jal is_palindrome          # استدعاء دالة التحقق
    move $t2, $v0              # $t2 = 1 إذا palindrome، 0 إذا لا

    beqz $t2, not_pal1         # if ($t2 == 0) → ليس palindrome
    la $a0, yes_msg
    li $v0, 4
    syscall
    b after_pal1

not_pal1:
    la $a0, no_msg
    li $v0, 4
    syscall

after_pal1:

    ## --- 3.2: التحقق من str2 ("Racecar") - هي palindrome / Check str2 ---
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

    ## --- 3.3: التحقق من str4 ("MIPS") - ليست palindrome / Check str4 ---
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

    ## ===================================================================
    ## ## القسم 4: إنهاء البرنامج / Section 4: Exit Program
    ## ===================================================================
    li $v0, 10
    syscall

# ====================================================================
# ## دالة حساب طول السلسلة النصية / Function: String Length
# -------------------------------------------------------------------
# ## المعاملات (Parameters):
#   $a0 = عنوان السلسلة (string address)
# ## المخرجات (Return):
#   $v0 = طول السلسلة (string length)
# ## المنطق (Logic):
#   نمر على كل بايت ونزيد العداد حتى نجد 0 (null terminator)
#   Traverse each byte, increment counter until finding 0 (null)
# ====================================================================
string_length:
    li $v0, 0                  # $v0 = 0 ← الطول يبدأ من 0
    move $t0, $a0              # $t0 = عنوان السلسلة (مؤشر متحرك)

length_loop:
    lb $t1, 0($t0)             # $t1 = تحميل حرف واحد (بايت) من السلسلة
                               # lb = Load Byte: يقرأ بايت واحد من الذاكرة
    beqz $t1, length_done      # if ($t1 == 0) → وصلنا إلى null → انتهى
                               # null terminator (\0) هو القيمة 0
    addi $v0, $v0, 1           # $v0++ ← length++ (زد العداد)
    addi $t0, $t0, 1           # $t0++ ← انتقل إلى الحرف التالي
    b length_loop              # كرر

length_done:
    jr $ra                     # $ra = عنوان العودة (سجله jal عند الاستدعاء)
                               # jr $ra = Jump to Return Address → عد للمتصل

# ====================================================================
# ## دالة التحويل من أحرف صغيرة إلى كبيرة / Function: To Uppercase
# -------------------------------------------------------------------
# ## المعاملات (Parameters):
#   $a0 = عنوان السلسلة المصدر (source string address)
#   $a1 = عنوان السلسلة الهدف (destination buffer address)
# ## المنطق (Logic):
#   إذا كان الحرف بين 'a' (97) و 'z' (122) → اطرح 32 للتحويل لكبير
#   If char is between 'a'(97) and 'z'(122) → subtract 32 to make uppercase
# ====================================================================
to_uppercase:
    move $t0, $a0              # $t0 = مؤشر المصدر (نقرأ منه)
    move $t1, $a1              # $t1 = مؤشر الهدف (نكتب إليه)

upper_loop:
    lb $t2, 0($t0)             # $t2 = تحميل حرف من المصدر

    beqz $t2, upper_done       # if ($t2 == 0) → وصلنا null → انتهى

    ## التحقق إذا كان الحرف صغيراً (a-z: 97-122)
    li $t3, 97                 # $t3 = 97 = 'a' (أول حرف صغير في ASCII)
    blt $t2, $t3, not_lower    # if ($t2 < 'a') → ليس حرفاً صغيراً → احتفظ به
    li $t3, 122                # $t3 = 122 = 'z' (آخر حرف صغير)
    bgt $t2, $t3, not_lower    # if ($t2 > 'z') → ليس حرفاً صغيراً → احتفظ به

    ## تحويل الحرف من صغير إلى كبير / Convert Lowercase to Uppercase
    ## في ASCII: 'A' = 65, 'a' = 97, الفرق = 32
    ## لذا: حرف كبير = حرف صغير - 32
    addi $t2, $t2, -32         # $t2 = $t2 - 32 ← تحويل إلى uppercase
                               ## مثلاً 'a'(97) - 32 = 65 = 'A'

not_lower:
    sb $t2, 0($t1)             # تخزين الحرف (معدلاً أو كما هو) في الهدف
                               # sb = Store Byte: يخزن بايت واحد في الذاكرة
    addi $t0, $t0, 1           # مؤشر المصدر++ (للحرف التالي)
    addi $t1, $t1, 1           # مؤشر الهدف++
    b upper_loop

upper_done:
    sb $zero, 0($t1)           # إضافة null terminator (\0) في نهاية سلسلة الهدف
                               # مهم: كل سلسلة نصية يجب أن تنتهي بـ null
    jr $ra

# ====================================================================
# ## دالة التحقق من تماثل السلسلة (Palindrome) / Function: Is Palindrome
# -------------------------------------------------------------------
# ## المعاملات (Parameters):
#   $a0 = عنوان السلسلة (string address)
# ## المخرجات (Return):
#   $v0 = 1 إذا palindrome، 0 إذا لا
# ## المنطق (Logic):
#   1. حساب طول السلسلة / Calculate string length
#   2. مؤشر البداية (left) = أول حرف / Start pointer = first char
#   3. مؤشر النهاية (right) = آخر حرف / End pointer = last char
#   4. قارن الحروف من الطرفين نحو المنتصف
#      Compare chars from both ends toward the middle
#   5. إذا اختلف أي زوج → return 0 (ليست palindrome)
#      If any pair differs → return 0 (not palindrome)
# ====================================================================
is_palindrome:
    move $t0, $a0              # $t0 = مؤشر البداية (left)

    ## --- حساب طول السلسلة / Calculate String Length ---
    move $t1, $a0              # $t1 = مؤقت للبحث عن النهاية
    li $t2, 0                  # $t2 = length = 0

pal_len_loop:
    lb $t3, 0($t1)             # $t3 = الحرف الحالي
    beqz $t3, pal_len_done     # إذا null → انتهى الحساب
    addi $t2, $t2, 1           # length++
    addi $t1, $t1, 1           # مؤشر++
    b pal_len_loop

pal_len_done:
    ## $t2 = الطول، $t1 = بعد الحرف الأخير (عند null)
    addi $t1, $t1, -1          # $t1 = مؤشر النهاية (right) ← آخر حرف فعلي
                               # نتراجع بمقدار 1 من null لنصل لآخر حرف

    ## --- مقارنة الحروف من الطرفين / Compare Chars from Both Ends ---
pal_check_loop:
    bge $t0, $t1, pal_true     # if (left >= right) → التقى المؤشران → palindrome
                               # إذا تجاوز المؤشر الأيسر الأيمن أو تساويا،
                               ## فهذا يعني أننا قارنا كل الأزواج

    lb $t3, 0($t0)             # $t3 = الحرف من البداية (left)
    lb $t4, 0($t1)             # $t4 = الحرف من النهاية (right)

    bne $t3, $t4, pal_false    # if ($t3 != $t4) → اختلف الحرفان → ليست palindrome
                               # bne = Branch if Not Equal

    addi $t0, $t0, 1           # left++ (تحرك للداخل من اليسار)
    addi $t1, $t1, -1          # right-- (تحرك للداخل من اليمين)
    b pal_check_loop           # كرر المقارنة

pal_true:
    li $v0, 1                  # return 1 (true - هي palindrome)
    jr $ra

pal_false:
    li $v0, 0                  # return 0 (false - ليست palindrome)
    jr $ra

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية         | English Meaning            |
# |-----------|-------------------------|----------------------------|
# | .asciiz   | تعريف سلسلة نصية        | Define null-terminated str |
# | lb        | تحميل بايت (حرف)        | Load Byte                  |
# | sb        | تخزين بايت (حرف)        | Store Byte                 |
# | jal       | القفز إلى دالة         | Jump And Link              |
# | jr        | القفز إلى عنوان تسجيل  | Jump Register               |
# | $ra       | تسجيل عنوان العودة     | Return Address              |
# -----------------------------------------------------------
# ## ASCII Key Values:
#   'A' = 65,  'a' = 97   → a - 32 = A
#   'Z' = 90,  'z' = 122  → z - 32 = Z
#   الفرق بين الصغير والكبير = 32
# ============================================================
