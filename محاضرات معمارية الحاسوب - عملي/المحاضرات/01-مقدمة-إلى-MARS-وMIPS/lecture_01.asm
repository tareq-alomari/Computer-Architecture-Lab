# ============================================================
# ## المحاضرة الأولى: مقدمة إلى MARS وأساسيات MIPS
# ## Lecture 1: Introduction to MARS and MIPS Basics
# ============================================================
#
# ## خطوات البرنامج / Program Steps:
#   1. طباعة رسالة "Hello World!" للترحيب
#      Print "Hello World!" welcome message
#   2. طباعة خط فاصل للتنسيق
#      Print separator line for formatting
#   3. طباعة معلومات الطالب (الاسم، الرقم، التخصص، الجامعة)
#      Print student info (name, ID, major, university)
#   4. طباعة خط فاصل ورسالة نجاح التنفيذ
#      Print separator and success message
#   5. إنهاء البرنامج باستخدام syscall
#      Terminate program using syscall
#
# ## المفاهيم الأساسية / Key Concepts:
#   - .asciiz : تعريف سلسلة نصية منتهية بـ null / Define null-terminated string
#   - la : تحميل عنوان / Load Address (يحمل عنوان السلسلة إلى $a0)
#   - li : تحميل قيمة فورية / Load Immediate (يحدد رقم syscall في $v0)
#   - syscall : استدعاء نظام / System call (ينفذ العملية المحددة بـ $v0)
#   - $v0 = 4 : طباعة سلسلة / Print string
#   - $v0 = 10 : إنهاء البرنامج / Exit program
# ============================================================
# تعليمات التثبيت (للاستخدام في MARS):
# ---------------------------------------
# 1. تأكد من تثبيت Java:              java -version
# 2. حمّل MARS من حزمة CA-Tools.rar أو: https://courses.missouristate.edu/kenvollmar/mars/
# 3. شغّل MARS:                       java -jar Mars4_3.jar
# 4. افتح هذا الملف في MARS:          File -> Open
# 5. للتجميع اضغط F3 (Assemble)
# 6. للتشغيل اضغط F5 (Run)
# 7. للتنفيذ خطوة بخطوة اضغط F7 (Step)
# ---------------------------------------
# يوضح هذا المثال كيفية طباعة Hello World وطباعة معلومات الطالب
# Demonstrates printing Hello World and student information
#
# موارد إضافية:
#   - دليل MARS: أدوات/شرح العمل على برنامج mars.pdf
#   - حزمة الأدوات: أدوات/CA-Tools.rar (MARS + Java JRE + Logisim)
#   - مثال تفاعلي: mips001.asm (جمع الأعداد حتى إدخال الصفر)
# ============================================================

.data  # ===== قسم البيانات / Data Section =====
       # يتم تعريف الثوابت والسلاسل النصية هنا
       # تظل محملة في الذاكرة طوال فترة تشغيل البرنامج

    ## رسالة الترحيب / Welcome Message
    hello_msg:  .asciiz "\n=== Hello World! ===\n"
    # .asciiz تخزن السلسلة وتضيف \0 (null) تلقائياً في نهايتها
    # .asciiz stores the string and automatically adds \0 (null) at the end

    ## معلومات الطالب / Student Information
    # يتم تعريف كل معلومة في سلسلة مستقلة لتسهيل إعادة الاستخدام
    # Each piece of info is in a separate string for easy reuse
    name_msg:   .asciiz "Student Name: Ahmed Mohammed\n"
    id_msg:     .asciiz "Student ID: 20241234\n"
    major_msg:  .asciiz "Major: Computer Science\n"
    uni_msg:    .asciiz "University: Example University\n"

    ## رسالة نهاية البرنامج / Program End Message
    end_msg:    .asciiz "\nProgram executed successfully!\n"

    ## رسالة إضافية للتنسيق / Formatting Line
    # الخط الفاصل يجعل المخرجات أكثر تنظيماً ووضوحاً
    # The separator line makes output more organized and readable
    line:       .asciiz "------------------------\n"

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main  # يعلن أن main نقطة دخول عامة / Declares main as global entry point

main:  # نقطة بدء تنفيذ البرنامج / Program execution starts here

    ## ===================================================================
    ## ## القسم 1: طباعة رسالة الترحيب / Section 1: Print Welcome Message
    ## ===================================================================
    ## نستخدم ثلاث خطوات لكل عملية طباعة:
    ## 1. تحميل عنوان السلسلة إلى $a0 (وسيط الطباعة)
    ## 2. تعيين $v0 = 4 (رمز syscall لطباعة سلسلة)
    ## 3. استدعاء syscall لتنفيذ العملية
    ##
    ## Three steps for each print:
    ## 1. Load string address into $a0 (print argument)
    ## 2. Set $v0 = 4 (syscall code for print_string)
    ## 3. Call syscall to execute

    la $a0, hello_msg      # $a0 = عنوان رسالة الترحيب / Load address of hello_msg
                           # la تأخذ عنوان التسمية (label) وتضعه في التسجيل
    li $v0, 4              # $v0 = 4 ← كود syscall لطباعة سلسلة نصية
                           # كل syscall له رقم يميزه: 4 للطباعة، 5 للقراءة، 10 للخروج
    syscall                # ينفذ syscall: يطبع السلسلة الموجودة في $a0

    ## ===================================================================
    ## ## القسم 2: طباعة خط فاصل / Section 2: Print Separator Line
    ## ===================================================================
    ## الغرض: تحسين مظهر المخرجات بفصل الأقسام بصرياً
    ## Purpose: Improve output appearance by visually separating sections

    la $a0, line           # $a0 = عنوان الخط الفاصل
    li $v0, 4              # $v0 = 4 ← كود طباعة سلسلة
    syscall                # طباعة الخط الفاصل

    ## ===================================================================
    ## ## القسم 3: طباعة معلومات الطالب / Section 3: Print Student Info
    ## ===================================================================
    ## يتم طباعة 4 معلومات متتالية بنفس الطريقة
    ## 4 pieces of info printed sequentially using the same method

    ## --- 3.1: طباعة اسم الطالب / Print Student Name ---
    la $a0, name_msg       # $a0 = عنوان سلسلة الاسم
    li $v0, 4              # $v0 = 4
    syscall                # طباعة: "Student Name: Ahmed Mohammed"

    ## --- 3.2: طباعة رقم الطالب / Print Student ID ---
    la $a0, id_msg         # $a0 = عنوان سلسلة الرقم الجامعي
    li $v0, 4
    syscall                # طباعة: "Student ID: 20241234"

    ## --- 3.3: طباعة التخصص / Print Major ---
    la $a0, major_msg      # $a0 = عنوان سلسلة التخصص
    li $v0, 4
    syscall                # طباعة: "Major: Computer Science"

    ## --- 3.4: طباعة الجامعة / Print University ---
    la $a0, uni_msg        # $a0 = عنوان سلسلة الجامعة
    li $v0, 4
    syscall                # طباعة: "University: Example University"

    ## ===================================================================
    ## ## القسم 4: طباعة خط فاصل ورسالة النجاح / Section 4: Separator & Success
    ## ===================================================================

    la $a0, line           # $a0 = عنوان الخط الفاصل
    li $v0, 4
    syscall                # طباعة الخط الفاصل للفصل بين المحتوى ورسالة النهاية

    la $a0, end_msg        # $a0 = عنوان رسالة نجاح التنفيذ
    li $v0, 4
    syscall                # طباعة: "Program executed successfully!"

    ## ===================================================================
    ## ## القسم 5: إنهاء البرنامج / Section 5: Exit Program
    ## ===================================================================
    ## يجب إنهاء كل برنامج MIPS بشكل صحيح بإعلام نظام التشغيل
    ## Every MIPS program must properly terminate by notifying the OS

    li $v0, 10             # $v0 = 10 ← كود syscall للخروج (exit)
                           # الرقم 10 يخبر MARS بإنهاء البرنامج وإعادة التحكم
    syscall                # إنهاء البرنامج

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمات  | المعنى بالعربية         | English Meaning            |
# |------------|------------------------|----------------------------|
# | .asciiz    | تعريف سلسلة نصية        | Define null-terminated str |
# | la         | تحميل عنوان            | Load Address               |
# | li         | تحميل قيمة فورية       | Load Immediate             |
# | syscall    | استدعاء نظام           | System Call                |
# | $v0        | تسجيل رقم syscall      | Syscall code register      |
# | $a0        | تسجيل وسيط الطباعة     | Print argument register    |
# ============================================================
