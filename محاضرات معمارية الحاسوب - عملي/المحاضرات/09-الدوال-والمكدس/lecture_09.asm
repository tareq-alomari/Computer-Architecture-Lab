# ============================================================
# ## المحاضرة التاسعة: الدوال والمكدس
# ## Lecture 9: Functions and Stack
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. دالة الأس (Power Function) - حساب x^n باستخدام حلقة:
#      Calculate x^n using iterative loop:
#      a. إدخال الأساس (base) والأس (exponent)
#         Input base and exponent
#      b. استدعاء power_function مع حفظ/استعادة المكدس
#         Call power_function with stack save/restore
#      c. طباعة النتيجة / Print result
#   2. دالة المضروب بالاستدعاء الذاتي (Recursive Factorial):
#      Recursive factorial:
#      a. إدخال n والتحقق من الصحة / Input n and validate
#      b. استدعاء factorial_recursive / Call factorial_recursive
#      c. طباعة النتيجة (مع المقارنة بالتكرارية)
#         Print result (compare with iterative)
#   3. دالة المضروب بالتكرار (Iterative Factorial):
#      Iterative factorial (for comparison)
#   4. استدعاء متعدد: حساب 2^3 + 4! باستخدام الدوال
#      Multiple calls: calculate 2^3 + 4! using functions
#   5. إنهاء البرنامج / Exit program
#
# ## المفاهيم الأساسية / Key Concepts:
#   - المكدس (Stack): منطقة ذاكرة للتخزين المؤقت (LIFO)
#     Stack: memory area for temporary storage (LIFO)
#   - $sp (Stack Pointer): مؤشر إلى أعلى المكدس
#     $sp: pointer to the top of the stack
#   - jal: استدعاء دالة (يحفظ $ra) / Jump And Link (saves $ra)
#   - jr $ra: العودة من دالة / Return from function
#   - يجب حفظ $ra قبل استدعاء دالة أخرى (استدعاء متداخل)
#     Must save $ra before calling another function (nested calls)
#   - الاستدعاء الذاتي (Recursion): دالة تستدعي نفسها
#     Recursion: a function calls itself
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## رسائل دالة الأس / Power Function Messages
    base_msg:   .asciiz "Enter base (x): "
    exp_msg:    .asciiz "Enter exponent (n): "
    power_msg:  .asciiz "\nPower: "

    ## رسائل دالة المضروب / Factorial Messages
    fact_msg:   .asciiz "\nEnter a number for factorial: "
    fact_result: .asciiz "Factorial (recursive) = "
    fact_of:    .asciiz "! = "
    fact_iter_msg: .asciiz "Factorial (iterative) = "

    ## رسائل أخرى / Other Messages
    error_msg:  .asciiz "Error: Factorial is not defined for negative numbers.\n"
    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"
    call_msg:   .asciiz "\n--- Testing functions with stack ---\n"

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: دالة الأس (Power) / Section 1: Power Function
    ## ===================================================================
    ##   $s0 = base (x)     - الأساس
    ##   $s1 = exponent (n) - الأس
    ##   $s2 = result (x^n) - النتيجة

    ## --- 1.1: إدخال الأساس / Input Base ---
    la $a0, base_msg
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0              # $s0 = base (x)

    ## --- 1.2: إدخال الأس / Input Exponent ---
    la $a0, exp_msg
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s1, $v0              # $s1 = exponent (n)

    ## --- 1.3: استدعاء دالة power(base, exponent) ---
    move $a0, $s0              # $a0 = base (المعامل الأول)
    move $a1, $s1              # $a1 = exponent (المعامل الثاني)
    jal power_function         # استدعاء الدالة: $v0 = power(base, exp)

    move $s2, $v0              # $s2 = النتيجة (x^n)

    ## --- 1.4: طباعة النتيجة / Print Result ---
    la $a0, power_msg
    li $v0, 4
    syscall

    move $a0, $s2
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 2: دالة المضروب بالاستدعاء الذاتي / Section 2: Recursive Factorial
    ## ===================================================================
    ## الاستدعاء الذاتي: دالة تستدعي نفسها بحل مشكلة أصغر
    ## Recursion: function calls itself with a smaller problem
    ##
    ## factorial(n) = n × factorial(n-1)
    ## شرط الإيقاف (base case): n <= 1 → return 1

    ## --- 2.1: إدخال n / Input n ---
    la $a0, fact_msg
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s3, $v0              # $s3 = n

    ## --- 2.2: التحقق من n >= 0 ---
    bltz $s3, fact_error       # if (n < 0) → خطأ

    ## --- 2.3: الاستدعاء الذاتي / Recursive Call ---
    move $a0, $s3
    jal factorial_recursive    # $v0 = factorial_recursive(n)
    move $s4, $v0              # $s4 = النتيجة (recursive)

    ## --- 2.4: طباعة النتيجة / Print Result ---
    move $a0, $s3
    li $v0, 1
    syscall                    # طباعة n

    la $a0, fact_of
    li $v0, 4
    syscall

    move $a0, $s4
    li $v0, 1
    syscall                    # طباعة n!

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 2.5: المقارنة مع الطريقة التكرارية / Compare with Iterative ---
    move $a0, $s3
    jal factorial_iterative
    move $s5, $v0              # $s5 = النتيجة (iterative)

    la $a0, fact_iter_msg
    li $v0, 4
    syscall

    move $a0, $s5
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    b after_factorial

fact_error:
    la $a0, error_msg
    li $v0, 4
    syscall

after_factorial:
    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 3: استدعاء دالة من دالة أخرى / Section 3: Nested Function Calls
    ## ===================================================================
    ## حساب 2^3 + 4! باستخدام المكدس
    ## المكدس ضروري هنا لأننا نستدعي دوالاً متعددة بالتتابع
    ## Stack is needed here because we call multiple functions sequentially

    la $a0, call_msg
    li $v0, 4
    syscall

    ## --- 3.1: حساب 2^3 / Calculate 2^3 ---
    li $a0, 2                  # base = 2
    li $a1, 3                  # exponent = 3
    jal power_function         # $v0 = 2^3 = 8
    move $t0, $v0              # $t0 = 8

    ## --- 3.2: حساب 4! / Calculate 4! ---
    li $a0, 4                  # n = 4
    jal factorial_recursive    # $v0 = 4! = 24
    move $t1, $v0              # $t1 = 24

    ## --- 3.3: جمع النتائج / Add Results ---
    add $t2, $t0, $t1          # $t2 = 8 + 24 = 32

    ## طباعة 2^3 + 4! = 32 (تستخدم رسالة power_msg للتوضيح فقط)
    li $v0, 4
    la $a0, power_msg
    syscall

    li $v0, 10
    syscall

# ====================================================================
# ## دالة الأس (Power): حساب x^n / Function: Power (x^n)
# -------------------------------------------------------------------
# ## المعاملات (Parameters):
#   $a0 = base (x)
#   $a1 = exponent (n)
# ## المخرجات (Return):
#   $v0 = x^n
# ## المنطق (Logic):
#   result = 1
#   for (counter = 0; counter < exponent; counter++)
#       result *= base
# ## المكدس (Stack):
#   نحفظ $ra و $s0 و $s1 لأننا نستخدم دوالاً أخرى
#   We save $ra, $s0, $s1 because we might call other functions
# ====================================================================
power_function:
    ## --- حفظ قيم التسجيلات على المكدس / Save Registers to Stack ---
    addi $sp, $sp, -12         # $sp = $sp - 12 ← نخصّص 3 كلمات (12 بايت) في المكدس
                               ## المكدس ينمو للأسفل (عناوين أقل)
    sw $ra, 0($sp)             # حفظ $ra في المكدس (عنوان العودة)
    sw $s0, 4($sp)             # حفظ $s0 (يحتوي base)
    sw $s1, 8($sp)             # حفظ $s1 (يحتوي exponent)

    move $s0, $a0              # $s0 = base
    move $s1, $a1              # $s1 = exponent

    li $t0, 1                  # $t0 = result = 1
    li $t1, 0                  # $t1 = counter = 0

power_loop:
    bge $t1, $s1, power_done   # if (counter >= exponent) → انتهى
    mul $t0, $t0, $s0          # result *= base
    addi $t1, $t1, 1           # counter++
    b power_loop

power_done:
    move $v0, $t0              # $v0 = result (القيمة المرجعة)

    ## --- استعادة القيم من المكدس / Restore Registers from Stack ---
    lw $ra, 0($sp)             # استعادة $ra
    lw $s0, 4($sp)             # استعادة $s0
    lw $s1, 8($sp)             # استعادة $s1
    addi $sp, $sp, 12          # $sp = $sp + 12 ← تحرير المساحة (عكس التخصيص)

    jr $ra                     # العودة إلى المتصل

# ====================================================================
# ## دالة المضروب بالاستدعاء الذاتي / Function: Recursive Factorial
# -------------------------------------------------------------------
# ## المعاملات (Parameters):
#   $a0 = n
# ## المخرجات (Return):
#   $v0 = n!
# ## المنطق (Logic):
#   base case: n <= 1 → return 1
#   recursive: n * factorial(n-1)
# ## مثال: factorial(5) = 5 * factorial(4)
# ##                       = 5 * 4 * factorial(3) ...
# ====================================================================
factorial_recursive:
    ## --- حفظ قيم التسجيلات على المكدس ---
    addi $sp, $sp, -8          # تخصيص كلمتين (8 بايت) في المكدس
    sw $ra, 0($sp)             # حفظ $ra (عنوان العودة)
    sw $a0, 4($sp)             # حفظ $a0 (n - المعامل)

    ## --- حالة الأساس (Base Case): n <= 1 ---
    li $t0, 1
    ble $a0, $t0, base_case    # if (n <= 1) → return 1
                               ## ble = Branch if Less or Equal

    ## --- الخطوة التكرارية (Recursive Step): n * factorial(n-1) ---
    addi $a0, $a0, -1          # $a0 = n - 1 (نحضر المعامل للاستدعاء التالي)
    jal factorial_recursive    # استدعاء ذاتي: $v0 = factorial(n-1)
                               ## jal يحفظ $ra الحالي ويفقد القديم!
                               ## لهذا السبب حفظنا $ra في المكدس

    ## بعد العودة من الاستدعاء الذاتي:
    lw $a0, 4($sp)             # $a0 = استعادة n (القيمة الأصلية)
    mul $v0, $a0, $v0          # $v0 = n * factorial(n-1)
                               ## نضرب n في النتيجة المرجعة من الاستدعاء

    b return_from_fact         # اذهب لاستعادة التسجيلات والعودة

base_case:
    li $v0, 1                  # $v0 = 1 ← factorial(0) = 1, factorial(1) = 1

return_from_fact:
    lw $ra, 0($sp)             # استعادة $ra
    addi $sp, $sp, 8           # تحرير المساحة
    jr $ra                     # العودة للمتصل

# ====================================================================
# ## دالة المضروب بالتكرار (للمقارنة) / Function: Iterative Factorial
# -------------------------------------------------------------------
# ## المعاملات (Parameters):
#   $a0 = n
# ## المخرجات (Return):
#   $v0 = n!
# ## المنطق (Logic):
#   result = 1
#   for (i = 1; i <= n; i++)
#       result *= i
# ====================================================================
factorial_iterative:
    li $v0, 1                  # $v0 = result = 1
    li $t0, 1                  # $t0 = counter = 1

fact_iter_loop:
    bgt $t0, $a0, fact_iter_done  # if (counter > n) → انتهى
    mul $v0, $v0, $t0          # result *= counter
    addi $t0, $t0, 1           # counter++
    b fact_iter_loop

fact_iter_done:
    jr $ra

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية          | English Meaning            |
# |-----------|--------------------------|----------------------------|
# | $sp       | مؤشر المكدس             | Stack Pointer              |
# | addi $sp  | تخصيص/تحرير مساحة مكدس  | Allocate/Free stack space |
# | sw $reg   | حفظ تسجيل في المكدس     | Save register to stack    |
# | lw $reg   | تحميل تسجيل من المكدس   | Load register from stack  |
# | jal       | استدعاء دالة             | Jump And Link             |
# | jr $ra    | العودة من دالة          | Jump Register (return)    |
# | $ra       | تسجيل عنوان العودة       | Return Address            |
# -----------------------------------------------------------
# ## أهمية المكدس (Why Stack?):
#   1. حفظ $ra قبل استدعاء دالة أخرى (nested calls)
#   2. حفظ التسجيلات المؤقتة ($s0, $s1, ...)
#   3. تمرير معاملات إضافية (أكثر من 4)
#   4. دعم الاستدعاء الذاتي (recursion)
#
# ## الفرق بين التكراري والاستدعاء الذاتي:
#   - التكراري: أسرع وأقل استخداماً للذاكرة
#   - الاستدعاء الذاتي: أبسط منطقياً لكنه أبطأ ويستهلك مكدساً أكثر
# ============================================================
