# ============================================================
# ## mips001.asm - مثال تفاعلي لجمع الأعداد
# ## Interactive Example: Sum Numbers Until Zero
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. تهيئة count = 0 و sum = 0
#      Initialize count = 0 and sum = 0
#   2. طباعة "Enter a number: " وقراءة الإدخال
#      Print "Enter a number: " and read input
#   3. إذا كان الإدخال = 0 → انتقل لطباعة النتائج
#      If input == 0 → jump to print results
#   4. زيادة العداد وإضافة الرقم إلى المجموع
#      Increment counter and add number to sum
#   5. العودة إلى الخطوة 2 (حلقة تكرار)
#      Go back to step 2 (loop)
#   6. طباعة: العدد الإجمالي، المجموع
#      Print: total count, sum
#   7. إنهاء البرنامج
#      Exit program
#
# ## منطق البرنامج (Pseudocode):
#   count = 0
#   sum = 0
#   print "Enter a number: "
#   read x
#   while (x != 0):
#       count++
#       sum = sum + x
#       print "Enter a number: "
#       read x
#   print "You entered 0; finishing input."
#   print "Count = ", count
#   print "Sum = ", sum
# ============================================================
# مستوحى من دليل: شرح العمل على برنامج MARS
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## رسائل الإدخال والإخراج / Input/Output Messages
    # prompt: تطلب من المستخدم إدخال رقم
    # prompt: asks user to enter a number
    prompt:     .asciiz "Enter a number: "

    sum_msg:    .asciiz "\nSum of entered numbers: "
    count_msg:  .asciiz "\nNumber count: "

    # zero_msg: تُطبع عندما يدخل المستخدم صفراً لإعلامه بانتهاء الإدخال
    # zero_msg: printed when user enters 0 to notify input completion
    zero_msg:   .asciiz "\nYou entered 0; input finished.\n"

    newline:    .asciiz "\n"

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:

    ## ===================================================================
    ## ## القسم 1: تهيئة المتغيرات / Section 1: Initialize Variables
    ## ===================================================================
    ## $t0 = count (عداد الأرقام المدخلة)
    ## $t1 = sum (مجموع الأرقام)
    ##
    ## نستخدم التسجيلات المؤقتة $t لأننا لا نحتاج حفظ القيم بعد انتهاء البرنامج
    ## We use temporary registers $t since we don't need values after program ends

    li $t0, 0                  # $t0 = 0 ← count = 0
                               # يبدأ العدد من 0 قبل إدخال أي رقم
    li $t1, 0                  # $t1 = 0 ← sum = 0
                               # يبدأ المجموع من 0

    ## ===================================================================
    ## ## القسم 2: حلقة الإدخال والتجميع / Section 2: Input & Sum Loop
    ## ===================================================================
    ## هذه الحلقة تستمر في طلب الأرقام وجمعها حتى يدخل المستخدم صفراً
    ## This loop keeps asking for numbers and summing them until 0 is entered
    ##
    ## لماذا نستخدم 0 كشرط للإنهاء؟
    ## لأن الصفر هو قيمة محايدة في الجمع، ولن تؤثر على المجموع
    ## Why 0 as termination condition?
    ## Because zero is the additive identity, it won't affect the sum

prompt_loop:
    ## --- 2.1: طباعة رسالة الإدخال / Print Input Prompt ---
    la $a0, prompt             # $a0 = عنوان "Enter a number: "
    li $v0, 4                  # $v0 = 4 ← كود طباعة سلسلة
    syscall                    # طباعة الرسالة على الشاشة

    ## --- 2.2: قراءة الرقم من المستخدم / Read Number from User ---
    li $v0, 5                  # $v0 = 5 ← كود syscall لقراءة عدد صحيح
                               # syscall 5 يقرأ رقماً من لوحة المفاتيح ويخزنه في $v0
    syscall                    # قراءة الرقم، النتيجة في $v0
    move $t2, $v0              # $t2 = $v0 ← x (نقل الإدخال إلى $t2 للحفاظ عليه)
                               # ننقل القيمة لأن $v0 قد يتغير في syscall التالي

    ## --- 2.3: التحقق من شرط الإنهاء / Check Termination Condition ---
    beq $t2, $zero, done_input # if ($t2 == 0) → انتقل إلى done_input
                               # beq = Branch if EQual
                               # $zero هو تسجيل دائم القيمة صفر في MIPS
                               # نستخدمه للمقارنة لتجنب استخدام li $zero, 0

    ## --- 2.4: تحديث العداد والمجموع / Update Counter and Sum ---
    addi $t0, $t0, 1           # $t0 = $t0 + 1 ← count++
                               # addi = Add Immediate (جمع مع قيمة فورية)
                               # كلما أدخل المستخدم رقماً غير صفر، نزيد العدد بمقدار 1

    add $t1, $t1, $t2          # $t1 = $t1 + $t2 ← sum += x
                               # نضيف الرقم المدخل إلى المجموع التراكمي
                               # add تجمع قيم تسجيلين وتخزن النتيجة في الأول

    j prompt_loop              # ارجع إلى بداية الحلقة لتكرار العملية
                               # j = Jump (قفز غير مشروط)

    ## ===================================================================
    ## ## القسم 3: طباعة النتائج / Section 3: Print Results
    ## ===================================================================
    ## عند الوصول إلى هنا، يكون المستخدم قد أدخل 0 وتوقفت حلقة الإدخال
    ## When we reach here, user entered 0 and input loop stopped

done_input:
    ## --- 3.1: إعلام المستخدم بأن الإدخال انتهى / Notify Input Finished ---
    la $a0, zero_msg           # $a0 = عنوان رسالة الإنهاء
    li $v0, 4
    syscall                    # طباعة: "You entered 0; input finished."

    ## --- 3.2: طباعة عدد الأرقام المدخلة / Print Count of Numbers ---
    la $a0, count_msg          # $a0 = عنوان "Number count: "
    li $v0, 4
    syscall                    # طباعة التسمية

    move $a0, $t0              # $a0 = $t0 = count (ننقل قيمة العدد إلى وسيط الطباعة)
    li $v0, 1                  # $v0 = 1 ← كود syscall لطباعة عدد صحيح
    syscall                    # طباعة العدد

    ## --- 3.3: طباعة المجموع / Print Sum ---
    la $a0, sum_msg            # $a0 = عنوان "Sum of entered numbers: "
    li $v0, 4
    syscall                    # طباعة التسمية

    move $a0, $t1              # $a0 = $t1 = sum
    li $v0, 1                  # $v0 = 1 ← كود طباعة عدد صحيح
    syscall                    # طباعة المجموع

    ## --- 3.4: سطر جديد للتنسيق / Newline for Formatting ---
    la $a0, newline
    li $v0, 4
    syscall

    ## ===================================================================
    ## ## القسم 4: إنهاء البرنامج / Section 4: Exit Program
    ## ===================================================================
    li $v0, 10                 # $v0 = 10 ← كود إنهاء البرنامج
    syscall                    # إنهاء التنفيذ
