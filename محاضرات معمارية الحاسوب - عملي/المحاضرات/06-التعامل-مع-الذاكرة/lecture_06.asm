# ============================================================
# ## المحاضرة السادسة: التعامل مع الذاكرة
# ## Lecture 6: Memory Operations
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. تحميل قيم من الذاكرة وعرضها (lw)
#      Load values from memory and display (lw)
#   2. عرض عناوين المتغيرات في الذاكرة (la)
#      Display variable addresses in memory (la)
#   3. تخزين قيمة جديدة في الذاكرة (sw)
#      Store a new value to memory (sw)
#   4. تخزين وتحميل من مصفوفة (buffer) مع إزاحة
#      Store and load from array (buffer) with offset
#   5. التبديل بين قيمتين في الذاكرة (Swap)
#      Swap two values in memory
#   6. جمع متغيرين من الذاكرة وتخزين النتيجة
#      Add two variables from memory and store result
#   7. إنهاء البرنامج / Exit program
#
# ## المفاهيم الأساسية / Key Concepts:
#   - الذاكرة في MIPS: مساحة خطية من البايتات، كل كلمة 4 بايت
#     Memory in MIPS: linear byte space, each word = 4 bytes
#   - lw (Load Word): تحميل 4 بايت من الذاكرة إلى تسجيل
#   - sw (Store Word): تخزين 4 بايت من تسجيل إلى الذاكرة
#   - la (Load Address): تحميل عنوان تسمية (label) إلى تسجيل
#   - الإزاحة (Offset): رقم يضاف للعنوان الأساسي للوصول لموقع محدد
#     Offset: a number added to base address to access a specific location
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## تعريف متغيرات في الذاكرة / Define Variables in Memory
    # .word تحجز 4 بايت (32 بت) في الذاكرة وتعطيها قيمة ابتدائية
    # .word reserves 4 bytes (32 bits) in memory with initial value
    var1:       .word 42               # متغير بقيمة 42
    var2:       .word 100              # متغير بقيمة 100
    var3:       .word 0                # متغير للنتائج (يبدأ بـ 0)

    ## مصفوفة لتوضيح تخزين قيم متعددة / Buffer for Multiple Values
    # .space تحجز مساحة في الذاكرة بدون تهيئة
    # .space reserves memory space without initialization
    buffer:     .space 40              # 10 كلمات (10 × 4 = 40 بايت)

    ## رسائل البرنامج / Program Messages
    init_msg:   .asciiz "Initial values:\n"
    var1_msg:   .asciiz "var1 = "
    var2_msg:   .asciiz "var2 = "
    result_msg: .asciiz "var3 (result) = "

    enter_msg:  .asciiz "Enter a value to store: "
    stored_msg: .asciiz "Value stored at buffer[0]: "
    loaded_msg: .asciiz "Value loaded from buffer[0]: "

    swap_before: .asciiz "\nBefore swap:\n"
    swap_after:  .asciiz "\nAfter swap:\n"

    addr_msg1:  .asciiz "Address of var1: 0x"
    addr_msg2:  .asciiz "Address of var2: 0x"

    newline:    .asciiz "\n"
    equal:      .asciiz " = "
    line:       .asciiz "------------------------\n"

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: تحميل القيم من الذاكرة وعرضها / Section 1: Load & Display
    ## ===================================================================
    ## lw (Load Word): تنقل 4 بايت من الذاكرة إلى تسجيل
    ## الصيغة: lw $register, label (أو lw $register, offset($base))

    la $a0, init_msg
    li $v0, 4
    syscall

    ## --- 1.1: تحميل var1 وعرضه / Load and Display var1 ---
    la $a0, var1_msg
    li $v0, 4
    syscall

    lw $t0, var1               # $t0 = القيمة المخزنة في var1 (42)
                               # lw تبحث عن التسمية var1 في .data وتقرأ 4 بايت
    move $a0, $t0
    li $v0, 1
    syscall                    # طباعة قيمة var1

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 1.2: تحميل var2 وعرضه / Load and Display var2 ---
    la $a0, var2_msg
    li $v0, 4
    syscall

    lw $t1, var2               # $t1 = قيمة var2 (100)
    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 2: عرض عناوين المتغيرات / Section 2: Display Variable Addresses
    ## ===================================================================
    ## la (Load Address) تحمل عنوان التسمية نفسه، وليس قيمتها
    ## la loads the address of the label, not its value
    ## الفرق بين la و lw:
    ##   la $t, var  ← $t = عنوان var (مثلاً 0x10010000)
    ##   lw $t, var  ← $t = القيمة المخزنة في var (مثلاً 42)

    la $a0, line
    li $v0, 4
    syscall

    ## --- 2.1: عنوان var1 ---
    la $a0, addr_msg1
    li $v0, 4
    syscall

    la $t2, var1               # $t2 = عنوان var1 (وليس قيمته!)
    move $a0, $t2
    li $v0, 34                 # syscall 34 = طباعة بالنظام الست عشري
    syscall                    # طباعة عنوان var1

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 2.2: عنوان var2 ---
    la $a0, addr_msg2
    li $v0, 4
    syscall

    la $t3, var2               # $t3 = عنوان var2
    move $a0, $t3
    li $v0, 34
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 3: تخزين قيمة جديدة في الذاكرة / Section 3: Store New Value
    ## ===================================================================
    ## sw (Store Word): تنقل 4 بايت من تسجيل إلى الذاكرة
    ## الصيغة: sw $register, label

    la $a0, line
    li $v0, 4
    syscall

    ## --- 3.1: إدخال قيمة جديدة / Input New Value ---
    la $a0, enter_msg
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t4, $v0              # $t4 = القيمة التي أدخلها المستخدم

    ## --- 3.2: تخزين القيمة في var3 / Store Value in var3 ---
    sw $t4, var3               # var3 = $t4
                               # sw تخزّن قيمة $t4 في عنوان var3 في الذاكرة
                               ## عكس lw: lw تقرأ من الذاكرة، sw تكتب إلى الذاكرة

    ## --- 3.3: إظهار القيمة المخزنة / Display Stored Value ---
    la $a0, stored_msg
    li $v0, 4
    syscall

    lw $t5, var3               # $t5 = نقرأ var3 من الذاكرة للتأكيد
    move $a0, $t5
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 4: تخزين وتحميل من مصفوفة / Section 4: Array (Buffer) Operations
    ## ===================================================================
    ## المصفوفة: مجموعة متتالية من الكلمات في الذاكرة
    ## Array: a contiguous group of words in memory
    ##
    ## الوصول للعنصر i: base_address + (i × 4)
    ## Accessing element i: base_address + (i × 4)
    ## buffer[0] في offset 0، buffer[1] في offset 4، buffer[2] في offset 8...

    la $a0, line
    li $v0, 4
    syscall

    ## --- 4.1: تخزين قيمة المستخدم في buffer[0] ---
    la $t6, buffer             # $t6 = العنوان الأساسي للمصفوفة buffer
    sw $t4, 0($t6)             # buffer[0] = $t4 (تخزين عند offset 0)
                               # الصيغة: sw $reg, offset($base)

    ## --- 4.2: تحميل القيمة من buffer[0] وعرضها ---
    lw $t7, 0($t6)             # $t7 = buffer[0] (تحميل من offset 0)
                               # نفس فكرة lw لكن مع إزاحة

    la $a0, loaded_msg
    li $v0, 4
    syscall

    move $a0, $t7
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 4.3: تخزين قيم متعددة في المصفوفة / Store Multiple Values ---
    ## buffer[1] في offset 4 (لأن كل كلمة = 4 بايت)
    ## buffer[2] في offset 8
    ## buffer[3] في offset 12
    ## لماذا offset 4؟ لأن كل كلمة 4 بايت، والبايت هو وحدة العنونة
    li $t8, 10
    sw $t8, 4($t6)             # buffer[1] = 10 (offset = 1 × 4)
    li $t8, 20
    sw $t8, 8($t6)             # buffer[2] = 20 (offset = 2 × 4)
    li $t8, 30
    sw $t8, 12($t6)            # buffer[3] = 30 (offset = 3 × 4)

    ## ===================================================================
    ## ## القسم 5: التبديل بين قيمتين (Swap) / Section 5: Swap Two Values
    ## ===================================================================
    ## عملية المبادلة: تبديل قيمتين في الذاكرة
    ## تحتاج إلى تسجيل مؤقت (temp) لحفظ إحدى القيمتين
    ## Swap process: exchange two values in memory
    ## Needs a temp register to hold one value

    la $a0, line
    li $v0, 4
    syscall

    ## --- 5.1: عرض القيم قبل التبديل / Show Values Before Swap ---
    la $a0, swap_before
    li $v0, 4
    syscall

    la $a0, var1_msg
    li $v0, 4
    syscall

    lw $s0, var1               # $s0 = قراءة var1 للعرض
    move $a0, $s0
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, var2_msg
    li $v0, 4
    syscall

    lw $s1, var2               # $s1 = قراءة var2 للعرض
    move $a0, $s1
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 5.2: عملية التبديل (Swap) / Swap Operation ---
    ## نستخدم عنوان var1 كأساس ونصل لـ var2 بإزاحة 4 بايت
    ## We use var1's address as base and reach var2 with 4-byte offset
    ## لماذا 4 بايت؟ لأن var1 و var2 متجاوران في الذاكرة، كل .word = 4 بايت
    la $t9, var1               # $t9 = عنوان var1 (العنوان الأساسي)
    lw $s2, 0($t9)             # $s2 = القيمة عند var1 (offset 0)
    lw $s3, 4($t9)             # $s3 = القيمة عند var2 (offset 4)
                               ## var2 يبعد 4 بايت عن var1

    ## تنفيذ المبادلة / Execute the Swap
    sw $s3, 0($t9)             # var1 = $s3 (القيمة القديمة لـ var2)
    sw $s2, 4($t9)             # var2 = $s2 (القيمة القديمة لـ var1)

    ## --- 5.3: عرض القيم بعد التبديل / Show Values After Swap ---
    la $a0, swap_after
    li $v0, 4
    syscall

    la $a0, var1_msg
    li $v0, 4
    syscall

    lw $s4, var1               # $s4 = قيمة var1 الجديدة
    move $a0, $s4
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, var2_msg
    li $v0, 4
    syscall

    lw $s5, var2               # $s5 = قيمة var2 الجديدة
    move $a0, $s5
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 6: جمع متغيرين وتخزين النتيجة / Section 6: Add & Store Result
    ## ===================================================================
    ## نجمع var1 + var2 (بعد التبادل) ونخزن النتيجة في var3

    la $a0, line
    li $v0, 4
    syscall

    lw $s6, var1               # $s6 = تحميل var1 (بعد التبديل)
    lw $s7, var2               # $s7 = تحميل var2 (بعد التبديل)
    add $s6, $s6, $s7          # $s6 = var1 + var2 (الجمع)
                               ## نعيد استخدام $s6 لتخزين المجموع

    sw $s6, var3               # var3 = المجموع (تخزين النتيجة في الذاكرة)
                               ## حفظ النتيجة للاستخدام المستقبلي

    la $a0, result_msg
    li $v0, 4
    syscall

    move $a0, $s6
    li $v0, 1
    syscall                    # طباعة var1 + var2

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 7: إنهاء البرنامج / Section 7: Exit Program
    ## ===================================================================
    li $v0, 10
    syscall

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية            | English Meaning             |
# |-----------|----------------------------|-----------------------------|
# | lw        | تحميل كلمة من الذاكرة      | Load Word (memory → reg)   |
# | sw        | تخزين كلمة في الذاكرة      | Store Word (reg → memory)  |
# | la        | تحميل عنوان                | Load Address                |
# | .word     | تعريف متغير بكلمة (4 بايت) | Define word variable        |
# | .space    | حجز مساحة في الذاكرة       | Reserve memory space        |
# -----------------------------------------------------------
# ## الوصول إلى الذاكرة مع إزاحة (Memory Access with Offset):
#   sw $t0, offset($base)
#   lw $t0, offset($base)
#   مثال: sw $t8, 4($t6) → buffer[1] = $t8
#
# ## الفرق بين la و lw:
#   la $t, X → $t = عنوان X (مثلاً 0x10010000)
#   lw $t, X → $t = القيمة المخزنة في X (مثلاً 42)
# ============================================================
