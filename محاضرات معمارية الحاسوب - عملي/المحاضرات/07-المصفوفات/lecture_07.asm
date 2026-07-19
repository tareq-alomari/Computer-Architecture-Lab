# ============================================================
# ## المحاضرة السابعة: المصفوفات
# ## Lecture 7: Arrays
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. إدخال حجم المصفوفة (n) والتحقق من الصحة (1-10)
#      Input array size (n) and validate (1-10)
#   2. إدخال عناصر المصفوفة باستخدام حلقة
#      Input array elements using a loop
#   3. طباعة عناصر المصفوفة
#      Print array elements
#   4. حساب مجموع عناصر المصفوفة
#      Calculate sum of array elements
#   5. حساب المتوسط (المجموع / n)
#      Calculate average (sum / n)
#   6. إيجاد أكبر عنصر (Maximum)
#      Find maximum element
#   7. إيجاد أصغر عنصر (Minimum)
#      Find minimum element
#   8. إنهاء البرنامج / Exit program
#
# ## المفاهيم الأساسية / Key Concepts:
#   - المصفوفة: مجموعة متتالية من الكلمات في الذاكرة
#     Array: a contiguous group of words in memory
#   - الوصول للعنصر: base_address + (index × 4)
#     Element access: base_address + (index × 4)
#   - sll: الضرب بـ 4 باستخدام الإزاحة (index << 2)
#     sll: multiply by 4 using shift (index << 2)
#   - الحلقات: تعبر المصفوفة باستخدام عداد (index)
#     Loops: traverse array using a counter (index)
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## تعريف المصفوفات / Array Definitions
    # .space 40 = 10 أعداد × 4 بايت = مساحة لـ 10 أعداد صحيحة
    # .space 40 = 10 numbers × 4 bytes = space for 10 integers
    array:      .space 40

    # .word 10 يحدد القيمة الافتراضية لحجم المصفوفة
    # .word 10 sets default array size
    array_size: .word 10

    ## رسائل البرنامج / Program Messages
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

    ## قيم افتراضية للمصفوفة (لتوضيح التهيئة)
    ## Default array values (to demonstrate initialization)
    init_array: .word 5, 12, 8, 3, 15, 7, 10, 2, 9, 6

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: إدخال حجم المصفوفة / Section 1: Input Array Size
    ## ===================================================================

    la $a0, enter_size
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0              # $s0 = حجم المصفوفة (n)

    ## --- 1.1: التحقق من صحة الحجم (1-10) / Validate Size (1-10) ---
    li $t0, 1                  # $t0 = الحد الأدنى 1
    li $t1, 10                 # $t1 = الحد الأقصى 10
    blt $s0, $t0, fix_size     # if (n < 1) → صحّح الحجم
    bgt $s0, $t1, fix_size     # if (n > 10) → صحّح الحجم
    b after_size_check         # الحجم صحيح → تابع

fix_size:
    li $s0, 5                  # $s0 = 5 (القيمة الافتراضية إذا كان الإدخال غير صالح)
                               # نختار 5 كحجم وسطي مناسب للأمثلة
    li $s0, 5                  # (تكرار للتأكيد)

after_size_check:

    ## ===================================================================
    ## ## القسم 2: إدخال عناصر المصفوفة / Section 2: Input Array Elements
    ## ===================================================================
    ## نستخدم حلقة مع عداد (index) من 0 إلى n-1
    ## لكل عنصر: نحسب عنوانه ثم نخزن القيمة
    ##
    ## حساب العنوان: address = array_base + (index × 4)
    ## Address calculation: address = array_base + (index × 4)
    ##
    ## لماذا index × 4؟ لأن كل عنصر (word) يشغل 4 بايت في الذاكرة

    la $s1, array              # $s1 = العنوان الأساسي للمصفوفة (array)
    li $t2, 0                  # $t2 = عداد الحلقة (index = 0)

input_loop:
    ## شرط الخروج: if (index >= n) → انتهى الإدخال
    bge $t2, $s0, input_done   # if ($t2 >= $s0) → اخرج

    ## --- 2.1: طباعة "Enter element [i]: " ---
    la $a0, enter_elem
    li $v0, 4
    syscall

    move $a0, $t2              # $a0 = index الحالي
    li $v0, 1
    syscall                    # طباعة رقم العنصر

    la $a0, close_brac
    li $v0, 4
    syscall

    ## --- 2.2: قراءة العنصر وتخزينه / Read and Store Element ---
    li $v0, 5
    syscall                    # قراءة قيمة العنصر من المستخدم

    ## حساب عنوان array[index] وتخزين القيمة
    sll $t3, $t2, 2            # $t3 = index × 4 (إزاحة لليسار بمقدار 2 = ضرب بـ 4)
                               ## sll بديل عن mul: index << 2 = index × 4
    add $t3, $s1, $t3          # $t3 = عنوان array[index] = base + offset
    sw $v0, 0($t3)             # تخزين قيمة العنصر في array[index]

    addi $t2, $t2, 1           # index++ (ننتقل للعنصر التالي)
    b input_loop               # العودة لبداية الحلقة

input_done:

    ## ===================================================================
    ## ## القسم 3: طباعة عناصر المصفوفة / Section 3: Print Array Elements
    ## ===================================================================
    ## نمر على المصفوفة ونطبع كل عنصر مفصولاً بمسافة

    la $a0, print_msg
    li $v0, 4
    syscall

    li $t2, 0                  # إعادة ضبط العداد (index = 0)

print_loop:
    bge $t2, $s0, print_done   # if (index >= n) → اخرج

    ## حساب عنوان العنصر / Calculate Element Address
    sll $t3, $t2, 2            # $t3 = index × 4
    add $t3, $s1, $t3          # $t3 = عنوان array[index]
    lw $t4, 0($t3)             # $t4 = array[index] (قراءة القيمة)

    move $a0, $t4
    li $v0, 1
    syscall                    # طباعة قيمة العنصر

    la $a0, space
    li $v0, 4
    syscall                    # طباعة مسافة بين العناصر

    addi $t2, $t2, 1
    b print_loop

print_done:
    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 4: حساب مجموع عناصر المصفوفة / Section 4: Calculate Sum
    ## ===================================================================

    li $t2, 0                  # $t2 = 0 ← إعادة ضبط العداد
    li $s2, 0                  # $s2 = 0 ← المجموع (sum)

sum_loop:
    bge $t2, $s0, sum_done     # if (index >= n) → اخرج

    ## حساب العنوان وقراءة العنصر
    sll $t3, $t2, 2
    add $t3, $s1, $t3
    lw $t4, 0($t3)             # $t4 = array[index]

    add $s2, $s2, $t4          # $s2 = $s2 + $t4 ← sum += array[index]

    addi $t2, $t2, 1
    b sum_loop

sum_done:
    la $a0, sum_msg
    li $v0, 4
    syscall

    move $a0, $s2
    li $v0, 1
    syscall                    # طباعة المجموع

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 5: حساب المتوسط / Section 5: Calculate Average
    ## ===================================================================
    ## المتوسط = sum / n
    ## نعرض الجزء الصحيح فقط (quotient) بدون باقي القسمة

    la $a0, avg_msg
    li $v0, 4
    syscall

    div $s2, $s0               # قسمة sum على n: LO = quotient, HI = remainder
    mflo $t5                   # $t5 = LO ← الجزء الصحيح من المتوسط
    mfhi $t6                   # $t6 = HI ← باقي القسمة (غير مستخدم هنا)

    move $a0, $t5
    li $v0, 1
    syscall                    # طباعة المتوسط

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 6: إيجاد أكبر عنصر (Maximum) / Section 6: Find Maximum
    ## ===================================================================
    ## نبدأ بافتراض أن العنصر الأول (array[0]) هو الأكبر
    ## ثم نقارن مع باقي العناصر، وإذا وجدنا عنصراً أكبر نحدّث القيمة
    ##
    ## Initial assumption: first element (array[0]) is the maximum
    ## Then compare with remaining elements, update if larger found

    lw $s3, 0($s1)             # $s3 = max = array[0] (نفترض أن الأول هو الأكبر)
    li $t2, 1                  # نبدأ من العنصر الثاني (index = 1)

max_loop:
    bge $t2, $s0, max_done     # if (index >= n) → اخرج

    sll $t3, $t2, 2
    add $t3, $s1, $t3
    lw $t4, 0($t3)             # $t4 = array[index]

    ble $t4, $s3, not_max      # if (array[i] <= max) → ليس أكبر → تخطي
                               # ble = Branch if Less or Equal

    move $s3, $t4              # $s3 = array[i] ← تحديث القيمة القصوى

not_max:
    addi $t2, $t2, 1
    b max_loop

max_done:
    la $a0, max_msg
    li $v0, 4
    syscall

    move $a0, $s3
    li $v0, 1
    syscall                    # طباعة أكبر عنصر

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 7: إيجاد أصغر عنصر (Minimum) / Section 7: Find Minimum
    ## ===================================================================
    ## نبدأ بافتراض أن array[0] هو الأصغر
    ## ثم نقارن مع باقي العناصر

    lw $s4, 0($s1)             # $s4 = min = array[0] (نفترض أن الأول هو الأصغر)
    li $t2, 1                  # نبدأ من العنصر الثاني

min_loop:
    bge $t2, $s0, min_done

    sll $t3, $t2, 2
    add $t3, $s1, $t3
    lw $t4, 0($t3)

    bge $t4, $s4, not_min      # if (array[i] >= min) → ليس أصغر → تخطي

    move $s4, $t4              # $s4 = array[i] ← تحديث القيمة الدنيا

not_min:
    addi $t2, $t2, 1
    b min_loop

min_done:
    la $a0, min_msg
    li $v0, 4
    syscall

    move $a0, $s4
    li $v0, 1
    syscall                    # طباعة أصغر عنصر

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 8: إنهاء البرنامج / Section 8: Exit Program
    ## ===================================================================
    li $v0, 10
    syscall

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية            | English Meaning             |
# |-----------|----------------------------|-----------------------------|
# | sll       | إزاحة يسار (للضرب بـ 4)    | Shift Left (for ×4)        |
# | lw/sw     | تحميل/تخزين كلمة           | Load/Store Word             |
# | .space    | حجز مساحة للمصفوفة         | Reserve array space         |
# | bge/ble   | فروع شرطية للمقارنة        | Conditional branches        |
# -----------------------------------------------------------
# ## هيكل المصفوفة في الذاكرة:
#   array[0] عند offset 0
#   array[1] عند offset 4
#   array[2] عند offset 8
#   ...
#   array[i] عند offset i × 4
#
# ## صيغة الوصول للعناصر:
#   sll $t, $i, 2         # $t = i × 4
#   add $t, $base, $t     # $t = &array[i]
#   lw $val, 0($t)        # $val = array[i]
# ============================================================
