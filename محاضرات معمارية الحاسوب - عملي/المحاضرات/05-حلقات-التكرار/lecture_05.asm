# ============================================================
# ## المحاضرة الخامسة: حلقات التكرار
# ## Lecture 5: Loops
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. حساب المضروب (Factorial) باستخدام حلقة for:
#      Calculate factorial using a for loop:
#      a. إدخال n (عدد صحيح غير سالب) / Input n (non-negative integer)
#      b. التحقق من n >= 0 / Validate n >= 0
#      c. result = 1, i = 1
#      d. while (i <= n): result *= i; i++
#      e. طباعة n! / Print n!
#   2. طباعة الأرقام من 1 إلى 10 (حلقة for):
#      Print numbers 1 to 10 (for loop):
#      a. counter = 1
#      b. while (counter <= 10): print counter; counter++
#   3. طباعة الأرقام من 1 إلى N عمودياً (حلقة while):
#      Print numbers 1 to N vertically:
#      a. إدخال N / Input N
#      b. counter = 1
#      c. while (counter <= N): print counter; counter++
#   4. حساب مجموع الأرقام من 1 إلى N (حلقة for):
#      Calculate sum from 1 to N:
#      a. counter = 1, sum = 0
#      b. while (counter <= N): sum += counter; counter++
#   5. إنهاء البرنامج / Exit program
#
# ## هياكل الحلقات في MIPS:
#   MIPS ليس لديه تعليمات حلقة مدمجة مثل for/while
#   يجب بناء الحلقات يدوياً باستخدام:
#     - عداد (counter) في تسجيل
#     - شرط خروج (branch condition)
#     - قفزة للخلف (jump back)
#
#   هيكل الحلقة (Loop Structure):
#     loop_start:
#         bge $counter, $limit, loop_end   # شرط الخروج
#         ...                               # جسم الحلقة
#         addi $counter, $counter, 1        # تحديث العداد
#         b loop_start                      # العودة للبداية
#     loop_end:
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## رسائل البرنامج / Program Messages
    prompt:     .asciiz "Enter a positive integer for factorial: "
    result_msg: .asciiz "Factorial = "
    error_msg:  .asciiz "Error: Please enter a non-negative number.\n"
    factorial_of: .asciiz "! = "

    count_msg:  .asciiz "\nNumbers from 1 to 10: "
    space:      .asciiz " "
    newline:    .asciiz "\n"
    line:       .asciiz "\n------------------------\n"

    ## رسالة للعرض الرأسي / Vertical Display Messages
    vertical_msg: .asciiz "\nNumbers from 1 to N (vertical):\n"
    enter_n:    .asciiz "Enter N: "

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: حساب المضروب (Factorial) / Section 1: Factorial Calculation
    ## ===================================================================
    ## المضروب (n!) = n × (n-1) × (n-2) × ... × 1
    ## Factorial (n!) = n × (n-1) × (n-2) × ... × 1
    ##
    ## مثال: 5! = 5 × 4 × 3 × 2 × 1 = 120
    ##
    ## نستخدم حلقة تكرارية: نضرب result في i من 1 إلى n
    ## Iterative approach: multiply result by i from 1 to n

    ## --- 1.1: إدخال العدد / Input Number ---
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0              # $s0 = n (العدد المطلوب حساب مضروبه)

    ## --- 1.2: التحقق من أن n >= 0 / Validate n >= 0 ---
    ## المضروب غير معرّف للأعداد السالبة
    ## Factorial is undefined for negative numbers
    bltz $s0, factorial_error  # if (n < 0) → خطأ

    ## --- 1.3: حساب المضروب (حلقة for) / Calculate Factorial (for loop) ---
    li $t0, 1                  # $t0 = result = 1 (القيمة الابتدائية للمضروب)
                               # لماذا 1؟ لأن 1 هو العنصر المحايد في الضرب
                               # لو بدأنا بـ 0 فسيبقى الناتج 0 دائماً
    li $t1, 1                  # $t1 = counter = i = 1 (عداد الحلقة)
                               # نبدأ من 1 لأن الضرب في 0 سيجعل النتيجة 0

factorial_loop:
    ## شرط الخروج: if (i > n) → انتهت الحلقة
    bgt $t1, $s0, factorial_done   # if ($t1 > $s0) → اخرج من الحلقة
                                   # bgt = Branch if Greater Than

    mul $t0, $t0, $t1              # $t0 = $t0 * $t1 ← result *= i
                                   # نضرب النتيجة الحالية في قيمة العداد

    addi $t1, $t1, 1               # $t1++ ← i++ (زيادة العداد بمقدار 1)
                                   # addi = Add Immediate
    b factorial_loop               # ارجع إلى بداية الحلقة

    ## --- 1.4: طباعة النتيجة / Print Result ---
factorial_done:
    move $a0, $s0              # $a0 = n (لطباعة العدد الأصلي)
    li $v0, 1
    syscall                    # طباعة n

    la $a0, factorial_of       # "$a0 = "! = "
    li $v0, 4
    syscall

    move $a0, $t0              # $a0 = result (الناتج النهائي)
    li $v0, 1
    syscall                    # طباعة n!

    la $a0, newline
    li $v0, 4
    syscall

    b after_factorial          # تخطي رسالة الخطأ

    ## --- 1.5: حالة الخطأ / Error Case ---
factorial_error:
    la $a0, error_msg
    li $v0, 4
    syscall                    # طباعة رسالة الخطأ

after_factorial:
    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 2: طباعة الأرقام من 1 إلى 10 / Section 2: Print 1 to 10
    ## ===================================================================
    ## مثال بسيط لحلقة for: عداد من 1 إلى 10
    ## Simple for loop example: counter from 1 to 10

    la $a0, count_msg
    li $v0, 4
    syscall

    li $t2, 1                  # $t2 = counter = 1 (قيمة البداية)

print_1_to_10:
    bgt $t2, 10, done_printing # if ($t2 > 10) → اخرج
                               # 10 هي القيمة النهائية للعداد

    move $a0, $t2
    li $v0, 1
    syscall                    # طباعة قيمة العداد الحالية

    la $a0, space
    li $v0, 4
    syscall                    # طباعة مسافة بين الأرقام

    addi $t2, $t2, 1           # counter++ (زيادة العداد)
    b print_1_to_10            # العودة لبداية الحلقة

done_printing:
    la $a0, newline
    li $v0, 4
    syscall

    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 3: طباعة من 1 إلى N عمودياً / Section 3: Print 1 to N Vertically
    ## ===================================================================

    la $a0, vertical_msg
    li $v0, 4
    syscall

    la $a0, enter_n
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s1, $v0              # $s1 = N (العدد الذي أدخله المستخدم)

    li $t3, 1                  # $t3 = counter = 1

print_vertical_loop:
    bgt $t3, $s1, done_vertical  # while (counter <= N)
                                 # bgt: إذا العداد > N → اخرج

    move $a0, $t3
    li $v0, 1
    syscall                    # طباعة الرقم

    la $a0, newline
    li $v0, 4
    syscall                    # طباعة سطر جديد (الطباعة العمودية)

    addi $t3, $t3, 1           # counter++
    b print_vertical_loop

done_vertical:
    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 4: حساب مجموع الأرقام من 1 إلى N / Section 4: Sum 1 to N
    ## ===================================================================
    ## مثال: إذا N = 5 فإن المجموع = 1 + 2 + 3 + 4 + 5 = 15
    ## نستخدم حلقة لجمع الأعداد بشكل تراكمي

    li $t4, 1                  # $t4 = counter = 1 (عداد الحلقة)
    li $t5, 0                  # $t5 = sum = 0 (المجموع يبدأ من 0)
                               # نبدأ بـ 0 لأن 0 هو العنصر المحايد في الجمع

sum_loop:
    bgt $t4, $s1, done_sum     # if (counter > N) → اخرج من الحلقة

    add $t5, $t5, $t4          # $t5 = $t5 + $t4 ← sum = sum + counter
                               # نضيف قيمة العداد الحالي إلى المجموع

    addi $t4, $t4, 1           # counter++
    b sum_loop                 # العودة لبداية الحلقة

done_sum:
    ## المجموع محسوب في $t5 (يمكن إضافة طباعة هنا)
    ## Sum is computed in $t5 (print could be added here)

    ## ===================================================================
    ## ## القسم 5: إنهاء البرنامج / Section 5: Exit Program
    ## ===================================================================
    li $v0, 10
    syscall

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية        | English Meaning             |
# |-----------|------------------------|-----------------------------|
# | addi      | جمع مع قيمة فورية      | Add Immediate               |
# | mul       | ضرب                    | Multiply                    |
# | bgt       | فرع إذا كان أكبر       | Branch if Greater Than      |
# | bltz      | فرع إذا كان أقل من صفر | Branch if Less Than Zero    |
# | li        | تحميل قيمة فورية       | Load Immediate              |
# | b         | قفزة غير مشروطة        | Unconditional Branch        |
# -----------------------------------------------------------
# ## هيكل الحلقة (Loop Structure):
#   1. التهيئة (Initialization): تعيين العداد
#   2. الشرط (Condition): فحص شرط الخروج
#   3. الجسم (Body): العمليات المطلوبة
#   4. التحديث (Update): تغيير العداد
#   5. التكرار (Repeat): القفز للشرط مرة أخرى
# ============================================================
