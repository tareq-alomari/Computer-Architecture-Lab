# ============================================================
# ## المحاضرة الثالثة: العمليات المنطقية وإزاحة البتات
# ## Lecture 3: Logical Operations and Bit Shifting
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. استخراج البايتات الأربعة من كلمة (0x12345678) باستخدام:
#      Extract four bytes from a word using:
#      a. Byte 0 (LSB): القناع 0xFF مع AND مباشرة
#         Byte 0 (LSB): mask 0xFF with direct AND
#      b. Byte 1: إزاحة لليمين 8 بتات ثم AND مع 0xFF
#         Byte 1: shift right 8 bits then AND with 0xFF
#      c. Byte 2: إزاحة لليمين 16 بت ثم AND مع 0xFF
#         Byte 2: shift right 16 bits then AND with 0xFF
#      d. Byte 3 (MSB): إزاحة لليمين 24 بت ثم AND مع 0xFF
#         Byte 3 (MSB): shift right 24 bits then AND with 0xFF
#   2. الضرب بـ 8 باستخدام الإزاحة (sll) والمقارنة مع mul
#      Multiply by 8 using shift (sll) and compare with mul
#   3. العمليات المنطقية: AND, OR, XOR مع أمثلة
#      Logical operations: AND, OR, XOR with examples
#   4. إنهاء البرنامج
#      Exit program
#
# ## مفاهيم مهمة / Important Concepts:
#   - القناع (Mask): قيمة تستخدم لعزل بتات معينة
#     Mask: a value used to isolate specific bits
#   - 0xFF = 255 = 11111111 في النظام الثنائي (8 بتات كلها 1)
#     0xFF = 255 = 11111111 in binary (all 8 bits are 1)
#   - قيمة 0x12345678: كلمة من 4 بايتات (78, 56, 34, 12)
#     Value 0x12345678: a word of 4 bytes (78, 56, 34, 12)
#   - الإزاحة لليسار بمقدار n تعادل الضرب بـ 2^n
#     Left shift by n is equivalent to multiplying by 2^n
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## القيمة المستخدمة في الأمثلة / Value Used in Examples
    # 0x12345678 كلمة نموذجية من 4 بايتات لتوضيح استخراج البايتات
    # 0x12345678 a typical 4-byte word to demonstrate byte extraction
    # التمثيل الست عشري: كل حرفين يمثلان بايت واحد
    # Hexadecimal: each pair represents one byte
    word_val:   .word 0x12345678

    ## رسائل البرنامج / Program Messages
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

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: استخراج البايتات من كلمة / Section 1: Extract Bytes from Word
    ## ===================================================================
    ## الكلمة 0x12345678 تتكون من 4 بايتات (كل بايت = 8 بتات):
    ## The word 0x12345678 consists of 4 bytes (each byte = 8 bits):
    ##
    ##   MSB (Byte 3) | Byte 2 | Byte 1 | LSB (Byte 0)
    ##   0x12         | 0x34   | 0x56   | 0x78
    ##
    ## LSB = Least Significant Byte (أقل بايت دلالة)
    ## MSB = Most Significant Byte (أكثر بايت دلالة)
    ##
    ## طريقة الاستخراج: نستخدم AND مع قناع 0xFF لعزل 8 بتات فقط
    ## Extraction method: use AND with mask 0xFF to isolate only 8 bits

    ## --- 1.0: طباعة القيمة الأصلية / Print Original Value ---
    la $a0, orig_msg           # $a0 = عنوان "Original word: 0x12345678"
    li $v0, 4
    syscall

    la $a0, line
    li $v0, 4
    syscall

    lw $s0, word_val           # $s0 = تحميل قيمة 0x12345678 من الذاكرة
                               # lw = Load Word: تحميل كلمة (4 بايت) من الذاكرة
                               # نستخدم $s0 (تسجيل محفوظ) لأنه سيبقى طوال البرنامج

    ## --- 1.1: استخراج Byte 0 (LSB) - البتات 0 إلى 7 / Extract Byte 0 ---
    ## أقل بايت دلالة: يوجد في أقصى اليمين
    ## Lowest byte: located at the far right
    ## لا نحتاج إزاحة لأن Byte 0 في الموضع 0
    ## No shift needed because Byte 0 is at position 0
    la $a0, byte0_msg
    li $v0, 4
    syscall

    andi $t0, $s0, 0xFF        # $t0 = $s0 & 0x000000FF
                               # andi = AND Immediate: تطبق AND بين القيمة والقناع
                               # لماذا 0xFF؟ لأن 0xFF = 255 = 11111111 ثنائياً
                               # AND مع 0xFF يبقي أقل 8 بتات ويصفّر الباقي
    move $a0, $t0
    li $v0, 34                 # $v0 = 34 ← كود طباعة بالنظام الست عشري (hex)
    syscall                    # طباعة Byte 0 بالنظام الست عشري

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 1.2: استخراج Byte 1 - البتات 8 إلى 15 / Extract Byte 1 ---
    ## Byte 1 موجود في الموضع 1 (البتات 8-15)
    ## نحتاج إزاحة لليمين بمقدار 8 بتات أولاً ثم تطبيق القناع
    ## Byte 1 is at position 1 (bits 8-15)
    ## Need to shift right 8 bits first then apply mask
    la $a0, byte1_msg
    li $v0, 4
    syscall

    srl $t1, $s0, 8            # $t1 = $s0 >> 8 ← إزاحة لليمين 8 بتات
                               # srl = Shift Right Logical: ينقل البتات لليمين
                               # الإزاحة بـ 8 تجعل Byte 1 يصبح في أقل 8 بتات
    andi $t1, $t1, 0xFF        # $t1 = $t1 & 0xFF ← تطبيق القناع لعزل أقل 8 بتات
    move $a0, $t1
    li $v0, 34
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 1.3: استخراج Byte 2 - البتات 16 إلى 23 / Extract Byte 2 ---
    ## Byte 2 في الموضع 2: إزاحة 16 بت إلى اليمين
    la $a0, byte2_msg
    li $v0, 4
    syscall

    srl $t2, $s0, 16           # $t2 = $s0 >> 16 ← إزاحة 16 بت (2 بايت)
    andi $t2, $t2, 0xFF
    move $a0, $t2
    li $v0, 34
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 1.4: استخراج Byte 3 (MSB) - البتات 24 إلى 31 / Extract Byte 3 ---
    ## أعلى بايت دلالة: إزاحة 24 بت إلى اليمين
    ## Most significant byte: shift 24 bits to the right
    la $a0, byte3_msg
    li $v0, 4
    syscall

    srl $t3, $s0, 24           # $t3 = $s0 >> 24 ← إزاحة 24 بت (3 بايت)
    andi $t3, $t3, 0xFF
    move $a0, $t3
    li $v0, 34
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 2: الضرب باستخدام الإزاحة / Section 2: Multiplication via Shift
    ## ===================================================================
    ## الإزاحة إلى اليسار بمقدار n تعادل الضرب بـ 2^n
    ## Shift left by n is equivalent to multiplication by 2^n
    ##
    ## مثال: sll $t, $s, 3 يعني $t = $s * 2^3 = $s * 8
    ## Example: sll $t, $s, 3 means $t = $s * 2^3 = $s * 8
    ##
    ## لماذا نستخدم الإزاحة بدل الضرب؟
    ## الإزاحة أسرع ولا تحتاج إلى وحدة ضرب منفصلة
    ## Why use shift instead of multiply?
    ## Shift is faster and doesn't need a separate multiplier unit

    la $a0, line
    li $v0, 4
    syscall

    la $a0, enter_msg          # "Enter a number: "
    li $v0, 4
    syscall

    li $v0, 5                  # قراءة رقم من المستخدم
    syscall
    move $s1, $v0              # $s1 = رقم الإدخال

    ## --- 2.1: الضرب باستخدام sll (إزاحة يسار منطقية) ---
    sll $t4, $s1, 3            # $t4 = $s1 << 3 = $s1 * 8
                               # sll = Shift Left Logical
                               # كل إزاحة لليسار بمقدار 1 = ضرب بـ 2
                               # الإزاحة بـ 3 = ضرب بـ 2^3 = 8

    la $a0, shift_msg
    li $v0, 4
    syscall

    move $a0, $t4
    li $v0, 1
    syscall                    # طباعة نتيجة الضرب بالإزاحة

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 2.2: التأكيد باستخدام mul (للمقارنة) ---
    ## نستخدم mul للتأكيد على أن النتيجة نفسها
    ## Use mul to confirm the result is the same
    mul $t5, $s1, 8            # $t5 = $s1 * 8 (ضرب عادي للمقارنة)

    la $a0, mul_msg
    li $v0, 4
    syscall

    move $a0, $t5
    li $v0, 1
    syscall                    # طباعة نتيجة الضرب العادي

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 3: العمليات المنطقية / Section 3: Logical Operations
    ## ===================================================================
    ## AND, OR, XOR هي عمليات بت (bitwise) تنفذ على كل بت على حدة
    ## AND, OR, XOR are bitwise operations executed on each bit independently
    ##
    ## | x | y | AND | OR | XOR |
    ## |---|---|---|----|-----|
    ## | 0 | 0 |  0  | 0  |  0  |
    ## | 0 | 1 |  0  | 1  |  1  |
    ## | 1 | 0 |  0  | 1  |  1  |
    ## | 1 | 1 |  1  | 1  |  0  |

    la $a0, line
    li $v0, 4
    syscall

    ## --- 3.1: عملية AND / AND Operation ---
    ## AND: 1 فقط إذا كان كلا البتّين 1
    ## AND: 1 only if both bits are 1
    ## استخدام AND مع قناع (mask) لعزل بتات معينة
    ## AND with a mask to isolate specific bits
    ##
    ## مثال: 0x12345678 & 0x0000FF00 = 0x00005600
    ## Explanation: AND with 0x0000FF00 يبقي فقط Byte 1 ويصفّر الباقي
    la $a0, and_msg
    li $v0, 4
    syscall

    andi $t6, $s0, 0x0000FF00  # $t6 = $s0 & 0x0000FF00
                               # القناع 0x0000FF00 يحتفظ ببتات Byte 1 فقط
    move $a0, $t6
    li $v0, 34
    syscall                    # طباعة النتيجة بالنظام الست عشري

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 3.2: عملية OR / OR Operation ---
    ## OR: 1 إذا كان أحدهما على الأقل 1
    ## OR: 1 if at least one bit is 1
    ## استخدام OR لتعيين بتات معينة (set bits)
    ## OR to set specific bits
    ##
    ## مثال: 0x12345678 | 0x000000FF = 0x123456FF
    ## Explanation: OR with 0xFF يضبط أقل 8 بتات إلى 1
    la $a0, or_msg
    li $v0, 4
    syscall

    ori $t7, $s0, 0x000000FF   # $t7 = $s0 | 0x000000FF
                               # OR مع 0xFF يضبط أقل 8 بتات إلى 1
    move $a0, $t7
    li $v0, 34
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 3.3: عملية XOR / XOR Operation ---
    ## XOR: 1 إذا اختلف البتّان (أحدهما 1 والآخر 0)
    ## XOR: 1 if bits are different
    ## استخدام XOR مع 0xFFFFFFFF لعكس كل البتات (متممة أحادية)
    ## XOR with 0xFFFFFFFF flips all bits (one's complement)
    ##
    ## مثال: 0x12345678 ^ 0xFFFFFFFF = 0xEDCBA987
    ## Explanation: XOR مع كلها 1 يعكس كل بت
    la $a0, xor_msg
    li $v0, 4
    syscall

    xori $t8, $s0, 0xFFFFFFFF  # $t8 = $s0 ^ 0xFFFFFFFF
                               # XOR مع 0xFFFFFFFF يعكس كل بت (NOT)
    move $a0, $t8
    li $v0, 34
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 4: إنهاء البرنامج / Section 4: Exit Program
    ## ===================================================================
    li $v0, 10
    syscall

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية              | English Meaning               |
# |-----------|------------------------------|-------------------------------|
# | andi      | AND مع قيمة فورية            | AND Immediate                 |
# | ori       | OR مع قيمة فورية             | OR Immediate                  |
# | xori      | XOR مع قيمة فورية            | XOR Immediate                 |
# | sll       | إزاحة يسار منطقية            | Shift Left Logical            |
# | srl       | إزاحة يمين منطقية            | Shift Right Logical           |
# | lw        | تحميل كلمة من الذاكرة        | Load Word                     |
# | syscall34 | طباعة بالنظام الست عشري      | Print in hexadecimal          |
# -----------------------------------------------------------
# ## تطبيقات عملية:
# - استخراج البايتات: يستخدم في فك تشفير البروتوكولات
# - الإزاحة: الضرب/القسمة السريعة بدون مضاعف
# - AND: عزل بتات معينة (masking)
# - OR: تعيين بتات معينة (setting)
# - XOR: عكس بتات / تشفير بسيط
# ============================================================
