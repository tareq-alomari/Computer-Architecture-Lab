# ============================================================
# ## المحاضرة الثانية: العمليات الحسابية الأساسية
# ## Lecture 2: Basic Arithmetic Operations - Simple Calculator
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. إدخال ثلاثة أرقام من المستخدم (a, b, c)
#      Input three numbers from user (a, b, c)
#   2. حساب a + b + c وعرض الناتج (الجمع)
#      Calculate a + b + c and display result (addition)
#   3. حساب a - b - c وعرض الناتج (الطرح)
#      Calculate a - b - c and display result (subtraction)
#   4. حساب (a + b + c) / 3 وعرض الناتج مع الباقي (المتوسط)
#      Calculate (a + b + c) / 3 and display quotient and remainder (average)
#   5. حساب a * b باستخدام mul (الضرب)
#      Calculate a * b using mul (multiplication)
#   6. إنهاء البرنامج
#      Exit program
#
# ## المفاهيم الأساسية / Key Concepts:
#   - add  : جمع عددين (Addition) - قد يسبب تجاوز (overflow)
#   - sub  : طرح عددين (Subtraction)
#   - div  : قسمة عددين (Division) - النتيجة في LO، الباقي في HI
#   - mul  : ضرب عددين (Multiplication)
#   - mflo : نقل ناتج القسمة من LO (Move From LO)
#   - mfhi : نقل باقي القسمة من HI (Move From HI)
#   - move : نقل قيمة بين التسجيلات (Move)
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## رسائل الإدخال / Input Prompts
    prompt1:    .asciiz "Enter first number: "
    prompt2:    .asciiz "Enter second number: "
    prompt3:    .asciiz "Enter third number: "

    ## رسائل النتائج / Result Messages
    sum_msg:    .asciiz "\nSum = "
    sub_msg:    .asciiz "Subtraction (a - b - c) = "
    avg_msg:    .asciiz "Average = "

    # remainder_msg: تُطبع قبل إظهار باقي القسمة
    # remainder_msg: printed before showing the division remainder
    remainder_msg: .asciiz " with remainder "

    newline:    .asciiz "\n"
    line:       .asciiz "------------------------\n"

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: إدخال الأرقام الثلاثة / Section 1: Input Three Numbers
    ## ===================================================================
    ## نستخدم $t0 و $t1 و $t2 لتخزين a, b, c على التوالي
    ## We use $t0, $t1, $t2 to store a, b, c respectively
    ##
    ## كل قراءة تتبع نفس النمط: طباعة رسالة → قراءة عدد → حفظ القيمة
    ## Each read follows the same pattern: print prompt → read int → save value

    ## --- 1.1: إدخال الرقم الأول (a) / Input First Number (a) ---
    la $a0, prompt1            # $a0 = عنوان "Enter first number: "
    li $v0, 4                  # $v0 = 4 ← كود طباعة سلسلة
    syscall                    # طباعة رسالة الطلب

    li $v0, 5                  # $v0 = 5 ← كود قراءة عدد صحيح
    syscall                    # يقرأ رقماً من لوحة المفاتيح ويخزنه في $v0
    move $t0, $v0              # $t0 = الرقم الأول (a) - ننقله للحفاظ عليه

    ## --- 1.2: إدخال الرقم الثاني (b) / Input Second Number (b) ---
    la $a0, prompt2
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t1, $v0              # $t1 = الرقم الثاني (b)

    ## --- 1.3: إدخال الرقم الثالث (c) / Input Third Number (c) ---
    la $a0, prompt3
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t2, $v0              # $t2 = الرقم الثالث (c)

    ## ===================================================================
    ## ## القسم 2: عملية الجمع / Section 2: Addition (a + b + c)
    ## ===================================================================
    ## الجمع في MIPS يتم باستخدام add التي قد تسبب تجاوزاً (overflow)
    ## إذا كنت لا تريد التحقق من التجاوز، استخدم addu
    ## Addition in MIPS uses add which may cause overflow
    ## Use addu if you don't want overflow checking

    la $a0, sum_msg            # $a0 = عنوان "Sum = "
    li $v0, 4
    syscall                    # طباعة تسمية النتيجة

    add $t3, $t0, $t1          # $t3 = $t0 + $t1 ← a + b
                               # add: $t3 = a + b (جمع $t0 و $t1)
    add $t3, $t3, $t2          # $t3 = $t3 + $t2 ← (a + b) + c
                               # نجمع النتيجة السابقة مع c

    move $a0, $t3              # $a0 = $t3 = الناتج
    li $v0, 1                  # $v0 = 1 ← كود طباعة عدد صحيح
    syscall                    # طباعة المجموع

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 3: عملية الطرح / Section 3: Subtraction (a - b - c)
    ## ===================================================================
    ## الطرح مشابه للجمع لكن باستخدام sub
    ## ترتيب المعاملات مهم: sub $t4, $t0, $t1 يعني $t4 = $t0 - $t1
    ## Subtraction is similar to addition but uses sub
    ## Operand order matters: sub $t4, $t0, $t1 means $t4 = $t0 - $t1

    la $a0, sub_msg            # $a0 = عنوان "Subtraction (a - b - c) = "
    li $v0, 4
    syscall

    sub $t4, $t0, $t1          # $t4 = $t0 - $t1 ← a - b
                               # sub: $t4 = a - b (طرح $t1 من $t0)
    sub $t4, $t4, $t2          # $t4 = $t4 - $t2 ← (a - b) - c

    move $a0, $t4
    li $v0, 1
    syscall                    # طباعة ناتج الطرح

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 4: حساب المتوسط / Section 4: Calculate Average
    ## ===================================================================
    ## المتوسط = (a + b + c) / 3
    ## القسمة في MIPS: div تخزن الخارج في LO والباقي في HI
    ## Average = (a + b + c) / 3
    ## Division in MIPS: div stores quotient in LO, remainder in HI
    ##
    ## لماذا نستخدم HI و LO؟
    ## لأن القسمة تنتج قيمتين (الخارج والباقي)، وتسجيل واحد لا يكفي
    ## Why LO and HI? Because division produces two values, one register isn't enough

    la $a0, avg_msg
    li $v0, 4
    syscall

    add $t5, $t0, $t1          # $t5 = $t0 + $t1 ← a + b
    add $t5, $t5, $t2          # $t5 = $t5 + $t2 ← a + b + c (المجموع الكلي)

    li $t6, 3                  # $t6 = 3 (القاسم / divisor)
    div $t5, $t6               # قسمة $t5 على $t6: LO = quotient, HI = remainder
                               # div لا تخزن النتيجة مباشرة في تسجيل
                               # بل تستخدم تسجيلين خاصين: LO و HI

    mflo $t7                   # $t7 = LO ← ناتج القسمة (quotient)
                               # mflo = Move From LO إلى تسجيل عادي
    mfhi $t8                   # $t8 = HI ← باقي القسمة (remainder)
                               # mfhi = Move From HI إلى تسجيل عادي

    move $a0, $t7
    li $v0, 1
    syscall                    # طباعة الجزء الصحيح من المتوسط

    ## طباعة الباقي إذا كان موجوداً / Print Remainder If Present
    la $a0, remainder_msg      # $a0 = عنوان " with remainder "
    li $v0, 4
    syscall

    move $a0, $t8
    li $v0, 1
    syscall                    # طباعة باقي القسمة

    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 5: عمليات إضافية - الضرب / Section 5: Extra - Multiplication
    ## ===================================================================
    ## الضرب باستخدام mul: $t9 = a * b
    ## mul يحسب حاصل ضرب تسجيلين ويخزن النتيجة في تسجيل ثالث
    ## Multiplication using mul: $t9 = a * b
    ## mul multiplies two registers and stores result in a third

    la $a0, line
    li $v0, 4
    syscall                    # طباعة خط فاصل

    mul $t9, $t0, $t1          # $t9 = $t0 * $t1 ← a * b
                               # mul: ضرب a و b وتخزين النتيجة في $t9

    ## ملاحظة: يتم طباعة خط فاصل دون طباعة قيمة $t9 (قيد التطوير)
    ## Note: separator printed without showing $t9 value (under development)

    li $v0, 4
    la $a0, line
    syscall

    ## ===================================================================
    ## ## القسم 6: إنهاء البرنامج / Section 6: Exit Program
    ## ===================================================================
    li $v0, 10                 # $v0 = 10 ← كود إنهاء البرنامج
    syscall

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية        | English Meaning         |
# |-----------|------------------------|-------------------------|
# | add       | جمع (قد يسبب overflow)| Addition (may overflow) |
# | sub       | طرح                   | Subtraction             |
# | div       | قسمة                  | Division                |
# | mul       | ضرب                   | Multiplication          |
# | mflo      | نقل من LO             | Move From LO            |
# | mfhi      | نقل من HI             | Move From HI            |
# | move      | نقل بين التسجيلات     | Move between registers  |
# ============================================================
