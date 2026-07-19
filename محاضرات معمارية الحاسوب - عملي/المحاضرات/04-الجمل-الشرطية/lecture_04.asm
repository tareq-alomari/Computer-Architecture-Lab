# ============================================================
# ## المحاضرة الرابعة: الجمل الشرطية
# ## Lecture 4: Conditional Statements
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. التحقق من زوجية الرقم (Even/Odd Check):
#      Check if a number is even or odd:
#      a. إدخال رقم / Input a number
#      b. استخدام AND مع 1 لفحص أقل بت (LSB)
#         Use AND with 1 to check least significant bit
#      c. إذا LSB = 0 → زوجي، إذا LSB = 1 → فردي
#         If LSB = 0 → even, if LSB = 1 → odd
#   2. مقارنة رقمين (Compare Two Numbers):
#      a. إدخال a و b / Input a and b
#      b. مقارنة a مع b: أكبر، أصغر، أو يساوي
#         Compare a with b: greater, less, or equal
#   3. تقدير الدرجات (Grade Calculator):
#      a. إدخال درجة من 0-100 / Input score from 0-100
#      b. التحقق من صحة المدخل / Validate input
#      c. تقدير: A (90-100), B (80-89), C (70-79), D (60-69), F (0-59)
#   4. إنهاء البرنامج / Exit program
#
# ## مفاهيم مهمة / Important Concepts:
#   - LSB: Least Significant Bit (أقل بت دلالة) - يحدد زوجية الرقم
#   - القناع 1: 1 & num = 1 إذا الرقم فردي، 0 إذا زوجي
#   - if-else chain: سلسلة من الشروط المتتالية
#   - branch instructions: تحويل مسار التنفيذ بناءً على شرط
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## رسائل التحقق من الزوجية / Even/Odd Messages
    enter_num:  .asciiz "Enter a number: "
    even_msg:   .asciiz "\nThe number is EVEN.\n"
    odd_msg:    .asciiz "\nThe number is ODD.\n"

    ## رسائل تقدير الدرجات / Grade Calculator Messages
    enter_grade: .asciiz "\nEnter your score (0-100): "
    grade_a:    .asciiz "Grade: A - Excellent!\n"
    grade_b:    .asciiz "Grade: B - Very Good!\n"
    grade_c:    .asciiz "Grade: C - Good!\n"
    grade_d:    .asciiz "Grade: D - Pass!\n"
    grade_f:    .asciiz "Grade: F - Failed!\n"
    invalid_msg: .asciiz "Invalid score! Must be between 0 and 100.\n"

    ## رسائل مقارنة رقمين / Comparison Messages
    enter_a:    .asciiz "\nEnter first number (a): "
    enter_b:    .asciiz "Enter second number (b): "
    a_greater:  .asciiz "a is greater than b\n"
    b_greater:  .asciiz "b is greater than a\n"
    equal_msg:  .asciiz "a equals b\n"

    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: التحقق من زوجية الرقم / Section 1: Even/Odd Check
    ## ===================================================================
    ## النظرية: أي عدد زوجي يقبل القسمة على 2 بدون باقي
    ## في النظام الثنائي، أقل بت (LSB) = 0 للأعداد الزوجية
    ## Theory: Any even number is divisible by 2 with no remainder
    ## In binary, LSB = 0 for even numbers, LSB = 1 for odd numbers
    ##
    ## مثال: 5 (101) ← LSB = 1 → فردي
    ##       6 (110) ← LSB = 0 → زوجي
    ##
    ## لذلك: num & 1 = 0 يعني زوجي، num & 1 = 1 يعني فردي
    ## Therefore: num & 1 = 0 means even, num & 1 = 1 means odd

    ## --- 1.1: إدخال الرقم / Input Number ---
    la $a0, enter_num
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0              # $t0 = رقم الإدخال

    ## --- 1.2: التحقق من الزوجية / Check Even/Odd ---
    andi $t1, $t0, 1           # $t1 = $t0 & 1 ← نأخذ أقل بت فقط
                               # لماذا 1؟ لأن 1 = 0...0001 في الثنائي
                               # AND مع 1 يخفي كل البتات إلا LSB
    beqz $t1, is_even          # if ($t1 == 0) → الرقم زوجي → اذهب إلى is_even
                               # beqz = Branch if EQual to Zero
    bnez $t1, is_odd           # if ($t1 != 0) → الرقم فردي → اذهب إلى is_odd
                               # bnez = Branch if Not Equal to Zero

    ## --- 1.3: طباعة النتيجة / Print Result ---
is_even:
    la $a0, even_msg
    li $v0, 4
    syscall                    # طباعة "The number is EVEN."
    b after_even_odd           # b = branch غير مشروط → تخطي is_odd

is_odd:
    la $a0, odd_msg
    li $v0, 4
    syscall                    # طباعة "The number is ODD."

after_even_odd:
    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 2: مقارنة رقمين / Section 2: Compare Two Numbers
    ## ===================================================================
    ## MIPS يوفر تعليمات فرع شرطي تقارن قيمتين مباشرة:
    ## MIPS provides conditional branch instructions that compare directly:
    ##   bgt  - Branch if Greater Than
    ##   blt  - Branch if Less Than
    ##   beq  - Branch if EQual
    ##
    ## هذه التعليمات تجعل المقارنة أسهل من استخدام sub + beqz

    ## --- 2.1: إدخال الرقمين / Input Two Numbers ---
    la $a0, enter_a
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t2, $v0              # $t2 = a (الرقم الأول)

    la $a0, enter_b
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t3, $v0              # $t3 = b (الرقم الثاني)

    ## --- 2.2: المقارنة / Comparison ---
    ## نقارن a مع b باستخدام سلسلة if-else
    bgt $t2, $t3, a_bigger     # if ($t2 > $t3) → a أكبر → a_bigger
    blt $t2, $t3, b_bigger     # if ($t2 < $t3) → b أكبر → b_bigger
    beq $t2, $t3, numbers_equal # if ($t2 == $t3) → متساويان → numbers_equal
    b after_compare            # للتأمين (لن يصل التنفيذ هنا عادةً)

    ## --- 2.3: طباعة النتيجة / Print Result ---
a_bigger:
    la $a0, a_greater
    li $v0, 4
    syscall
    b after_compare

b_bigger:
    la $a0, b_greater
    li $v0, 4
    syscall
    b after_compare

numbers_equal:
    la $a0, equal_msg
    li $v0, 4
    syscall

after_compare:
    la $a0, line
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 3: تقدير الدرجات / Section 3: Grade Calculator
    ## ===================================================================
    ##   A: 90 - 100  (ممتاز / Excellent)
    ##   B: 80 - 89   (جيد جداً / Very Good)
    ##   C: 70 - 79   (جيد / Good)
    ##   D: 60 - 69   (مقبول / Pass)
    ##   F: 0 - 59    (راسب / Failed)
    ##
    ## استراتيجية التقدير: نبدأ من أعلى درجة وننزل للأسفل
    ## Grading strategy: start from highest and go down
    ## نستخدم bge (≥) للتحقق من كل حد أعلى
    ## أول شرط يتحقق هو التقدير المناسب

    ## --- 3.1: إدخال الدرجة / Input Score ---
    la $a0, enter_grade
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t4, $v0              # $t4 = الدرجة (score)

    ## --- 3.2: التحقق من صحة المدخلات (0-100) / Validate Input ---
    bltz $t4, invalid          # if ($t4 < 0) → درجة غير صالحة
                               # bltz = Branch if Less Than Zero
    bgt $t4, 100, invalid      # if ($t4 > 100) → درجة غير صالحة

    ## --- 3.3: تقدير الدرجة / Grade Calculation ---
    ## نستخدم سلسلة if-else تنازلية:
    ## التحقق من 90 أولاً، ثم 80، ثم 70، ثم 60، وأخيراً F
    ##
    ## لماذا نبدأ من الأعلى؟ لأن bge تعني "أكبر أو يساوي"
    ## فإذا بدأنا من 90، فإن 95 ستنطبق على A وليس B

    bge $t4, 90, grade_A       # if (score >= 90) → A
    bge $t4, 80, grade_B       # else if (score >= 80) → B
    bge $t4, 70, grade_C       # else if (score >= 70) → C
    bge $t4, 60, grade_D       # else if (score >= 60) → D
    b grade_F                  # else → F

    ## --- 3.4: طباعة التقدير / Print Grade ---
grade_A:
    la $a0, grade_a
    li $v0, 4
    syscall
    b after_grade

grade_B:
    la $a0, grade_b
    li $v0, 4
    syscall
    b after_grade

grade_C:
    la $a0, grade_c
    li $v0, 4
    syscall
    b after_grade

grade_D:
    la $a0, grade_d
    li $v0, 4
    syscall
    b after_grade

grade_F:
    la $a0, grade_f
    li $v0, 4
    syscall
    b after_grade

invalid:
    la $a0, invalid_msg
    li $v0, 4
    syscall

after_grade:
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
# | التعليمة | المعنى بالعربية            | English Meaning                 |
# |-----------|----------------------------|---------------------------------|
# | beqz      | فرع إذا كان صفراً          | Branch if EQual to Zero         |
# | bnez      | فرع إذا لم يكن صفراً       | Branch if Not Equal to Zero     |
# | beq       | فرع إذا كان متساوياً        | Branch if EQual                 |
# | bne       | فرع إذا لم يكن متساوياً     | Branch if Not Equal             |
# | bgt       | فرع إذا كان أكبر            | Branch if Greater Than          |
# | bge       | فرع إذا كان أكبر أو يساوي   | Branch if Greater or Equal      |
# | blt       | فرع إذا كان أصغر            | Branch if Less Than             |
# | ble       | فرع إذا كان أصغر أو يساوي   | Branch if Less or Equal         |
# | bltz      | فرع إذا كان أقل من صفر      | Branch if Less Than Zero        |
# | b         | فرع غير مشروط              | Unconditional Branch            |
# -----------------------------------------------------------
# ## ملاحظة: الفرق بين beqz و beq:
# - beqz $t, label  : if $t == 0
# - beq $t1, $t2, label : if $t1 == $t2
# ============================================================
