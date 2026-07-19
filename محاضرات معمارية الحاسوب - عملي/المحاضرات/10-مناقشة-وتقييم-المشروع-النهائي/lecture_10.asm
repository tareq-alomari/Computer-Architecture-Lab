# ============================================================
# ## المحاضرة العاشرة: المشروع النهائي - نظام إدارة درجات الطلاب
# ## Lecture 10: Final Project - Student Grades Management System
# ============================================================
#
# ## وصف النظام / System Description:
#   نظام متكامل لإدارة درجات الطلاب مع قائمة تفاعلية (Menu)
#   Integrated student grade management system with interactive menu
#
# ## القوائم / Menu Options:
#   1. Enter grades        - إدخال درجات الطلاب
#   2. Display all grades  - عرض جميع الدرجات
#   3. Calculate average   - حساب المتوسط الحسابي
#   4. Find max & min      - إيجاد أعلى وأقل درجة
#   5. Count pass & fail   - حساب عدد الناجحين والراسبين
#   6. Display statistics  - عرض إحصائيات كاملة
#   7. Exit                - الخروج
#
# ## هيكل البرنامج / Program Structure:
#   main → menu_loop (اختيار الخيار)
#        ├── option_enter_grades  : إدخال البيانات
#        ├── option_display       : عرض البيانات
#        ├── option_average       : حساب المتوسط
#        ├── option_min_max       : أعلى/أقل درجة
#        ├── option_pass_fail     : ناجح/راسب
#        ├── option_statistics    : إحصائيات كاملة
#        └── exit_program         : خروج
#
# ## المفاهيم المطبقة / Concepts Applied:
#   - .word / .space : تعريف المتغيرات والمصفوفات
#   - lw / sw : التعامل مع الذاكرة
#   - sll : الوصول لعناصر المصفوفة (index × 4)
#   - beq / bgt / blt : فروع شرطية
#   - div / mflo / mfhi : قسمة
#   - حلقات تكرارية / Loops
#   - قائمة تفاعلية / Interactive Menu
# ============================================================

.data  # ===== قسم البيانات / Data Section =====

    ## ================================================================
    ## ## الثوابت والمتغيرات الأساسية / Constants & Core Variables
    ## ================================================================

    ## الحد الأقصى لعدد الطلاب / Maximum Students
    MAX_STUDENTS:   .word 50

    ## مصفوفة لتخزين درجات الطلاب (200 بايت = 50 × 4)
    ## Array to store student grades (200 bytes = 50 × 4)
    grades:         .space 200

    ## متغيرات النظام / System Variables
    num_students:   .word 0            # عدد الطلاب الفعلي / Actual student count
    sum_grades:     .word 0            # مجموع الدرجات / Sum of grades
    average:        .word 0            # المتوسط الحسابي / Average
    max_grade:      .word 0            # أعلى درجة / Maximum grade
    min_grade:      .word 100          # أقل درجة (تبدأ بـ 100 كحد أقصى) / Minimum
    pass_count:     .word 0            # عدد الناجحين / Pass count
    fail_count:     .word 0            # عدد الراسبين / Fail count

    ## ================================================================
    ## ## رسائل القائمة الرئيسية / Main Menu Messages
    ## ================================================================
    menu_title:     .asciiz "\n========== Student Grades Management System ==========\n"
    menu_option1:   .asciiz "1. Enter grades\n"
    menu_option2:   .asciiz "2. Display all grades\n"
    menu_option3:   .asciiz "3. Calculate average\n"
    menu_option4:   .asciiz "4. Find maximum and minimum grades\n"
    menu_option5:   .asciiz "5. Count pass and fail\n"
    menu_option6:   .asciiz "6. Display statistics summary\n"
    menu_option7:   .asciiz "7. Exit\n"
    menu_prompt:    .asciiz "\nEnter your choice (1-7): "
    menu_line:      .asciiz "======================================================\n"

    ## ================================================================
    ## ## رسائل الإدخال / Input Messages
    ## ================================================================
    enter_num_msg:  .asciiz "Enter number of students (1-50): "
    enter_grade_msg: .asciiz "Enter grade for student "
    colon_msg:      .asciiz ": "
    invalid_msg:    .asciiz "Invalid input! Please try again.\n"
    invalid_range:  .asciiz "Grade must be between 0 and 100.\n"

    ## ================================================================
    ## ## رسائل العرض / Display Messages
    ## ================================================================
    display_title:  .asciiz "\n--- Student Grades ---\n"
    student_label:  .asciiz "Student "
    grade_label:    .asciiz ": Grade = "
    no_data_msg:    .asciiz "\nNo data available. Please enter grades first.\n"

    ## ================================================================
    ## ## رسائل الإحصائيات / Statistics Messages
    ## ================================================================
    avg_msg:        .asciiz "\n--- Average ---\n"
    avg_result:     .asciiz "Average grade: "
    avg_remainder:  .asciiz " remainder "

    min_max_msg:    .asciiz "\n--- Min & Max ---\n"
    max_result:     .asciiz "Maximum grade: "
    min_result:     .asciiz "Minimum grade: "

    pass_fail_msg:  .asciiz "\n--- Pass & Fail ---\n"
    pass_result:    .asciiz "Number of passed students: "
    fail_result:    .asciiz "Number of failed students: "
    pass_rate_msg:  .asciiz "Pass rate: "
    percent_msg:    .asciiz "%\n"
    passed_label:   .asciiz " PASSED"
    failed_label:   .asciiz " FAILED"

    stats_title:    .asciiz "\n========== Full Statistics Summary ==========\n"
    total_students: .asciiz "Total students: "
    stats_line:     .asciiz "----------------------------------------------\n"

    exit_msg:       .asciiz "\nThank you! Program terminated.\n"
    success_msg:    .asciiz "Grades entered successfully!\n"

    ## درجة النجاح / Pass Threshold
    pass_threshold: .word 50            # درجة النجاح = 50

.text  # ===== قسم التعليمات البرمجية / Code Section =====
.globl main

main:
    ## ===================================================================
    ## ## التهيئة الأولية / Initialization
    ## ===================================================================
    ## نضبط جميع المتغيرات على قيمها الابتدائية
    ## Reset all variables to initial values

    sw $zero, num_students     # num_students = 0
    sw $zero, sum_grades       # sum_grades = 0
    sw $zero, average          # average = 0
    sw $zero, max_grade        # max_grade = 0
    li $t0, 100
    sw $t0, min_grade          # min_grade = 100 (لأن أي درجة ≤ 100)
    sw $zero, pass_count       # pass_count = 0
    sw $zero, fail_count       # fail_count = 0

    ## ===================================================================
    ## ## الحلقة الرئيسية (القائمة التفاعلية) / Main Loop (Interactive Menu)
    ## ===================================================================
    ## تعرض القائمة وتنتظر اختيار المستخدم حتى يختار 7 (خروج)
    ## Displays menu and waits for user choice until 7 (Exit) is selected

menu_loop:
    ## --- عرض القائمة / Display Menu ---
    la $a0, menu_title
    li $v0, 4
    syscall

    la $a0, menu_option1
    li $v0, 4
    syscall

    la $a0, menu_option2
    li $v0, 4
    syscall

    la $a0, menu_option3
    li $v0, 4
    syscall

    la $a0, menu_option4
    li $v0, 4
    syscall

    la $a0, menu_option5
    li $v0, 4
    syscall

    la $a0, menu_option6
    li $v0, 4
    syscall

    la $a0, menu_option7
    li $v0, 4
    syscall

    la $a0, menu_line
    li $v0, 4
    syscall

    ## --- قراءة اختيار المستخدم / Read User Choice ---
    la $a0, menu_prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0              # $t0 = choice (اختيار المستخدم 1-7)

    ## --- توجيه الاختيار / Route Choice ---
    li $t1, 1
    beq $t0, $t1, option_enter_grades   # choice = 1 → إدخال درجات

    li $t1, 2
    beq $t0, $t1, option_display        # choice = 2 → عرض الدرجات

    li $t1, 3
    beq $t0, $t1, option_average        # choice = 3 → حساب المتوسط

    li $t1, 4
    beq $t0, $t1, option_min_max        # choice = 4 → أعلى/أقل درجة

    li $t1, 5
    beq $t0, $t1, option_pass_fail      # choice = 5 → ناجح/راسب

    li $t1, 6
    beq $t0, $t1, option_statistics     # choice = 6 → إحصائيات كاملة

    li $t1, 7
    beq $t0, $t1, exit_program          # choice = 7 → خروج

    ## --- خيار غير صالح / Invalid Choice ---
    la $a0, invalid_msg
    li $v0, 4
    syscall
    b menu_loop                # العودة للقائمة

    ## ================================================================
    ## ## الخيار 1: إدخال درجات الطلاب / Option 1: Enter Grades
    ## ================================================================
    ## يطلب عدد الطلاب ويدرج درجاتهم مع التحقق من الصحة
    ## Asks for student count and inputs their grades with validation
    ## يقوم أيضاً بتحديث: المجموع، أعلى/أقل درجة، عدد الناجحين/الراسبين
    ## Also updates: sum, max/min grade, pass/fail count

option_enter_grades:
    ## --- 1.1: إدخال عدد الطلاب / Input Number of Students ---
    la $a0, enter_num_msg
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0              # $s0 = عدد الطلاب

    ## --- 1.2: التحقق من صحة العدد (1-50) / Validate Count (1-50) ---
    li $t0, 1                  # الحد الأدنى
    li $t1, 50                 # الحد الأقصى
    blt $s0, $t0, invalid_num  # if (count < 1) → خطأ
    bgt $s0, $t1, invalid_num  # if (count > 50) → خطأ

    sw $s0, num_students       # حفظ عدد الطلاب في الذاكرة

    ## --- 1.3: إعادة تهيئة المتغيرات للحسابات الجديدة / Reset Variables ---
    sw $zero, sum_grades       # sum_grades = 0
    sw $zero, pass_count       # pass_count = 0
    sw $zero, fail_count       # fail_count = 0
    li $t2, 0
    sw $t2, max_grade          # max_grade = 0
    li $t2, 100
    sw $t2, min_grade          # min_grade = 100

    ## --- 1.4: إدخال درجات الطلاب / Input Student Grades ---
    la $s1, grades             # $s1 = عنوان مصفوفة grades
    li $t2, 0                  # $t2 = عداد (index = 0)

input_grades_loop:
    bge $t2, $s0, input_grades_done  # if (index >= count) → انتهى

    ## طباعة "Enter grade for student i: "
    la $a0, enter_grade_msg
    li $v0, 4
    syscall

    addi $t3, $t2, 1           # رقم الطالب (1-based: index + 1)
    move $a0, $t3
    li $v0, 1
    syscall

    la $a0, colon_msg
    li $v0, 4
    syscall

    ## قراءة الدرجة / Read Grade
    li $v0, 5
    syscall
    move $t4, $v0              # $t4 = الدرجة

    ## --- 1.5: التحقق من صحة الدرجة (0-100) / Validate Grade (0-100) ---
    bltz $t4, invalid_grade    # if (grade < 0) → خطأ
    li $t5, 100
    bgt $t4, $t5, invalid_grade # if (grade > 100) → خطأ

    ## --- 1.6: تخزين الدرجة في المصفوفة / Store Grade in Array ---
    sll $t5, $t2, 2            # $t5 = index × 4 (حجم الكلمة)
    add $t5, $s1, $t5          # $t5 = عنوان grades[index]
    sw $t4, 0($t5)             # grades[index] = grade

    ## --- 1.7: تحديث المجموع / Update Sum ---
    lw $t6, sum_grades         # $t6 = المجموع الحالي
    add $t6, $t6, $t4          # $t6 += grade
    sw $t6, sum_grades         # حفظ المجموع الجديد

    ## --- 1.8: تحديث أعلى درجة / Update Maximum Grade ---
    lw $t7, max_grade          # $t7 = أعلى درجة حالية
    ble $t4, $t7, not_new_max  # if (grade <= max) → ليس أعلى
    sw $t4, max_grade          # max_grade = grade (تحديث)
not_new_max:

    ## --- 1.9: تحديث أقل درجة / Update Minimum Grade ---
    lw $t8, min_grade          # $t8 = أقل درجة حالية
    bge $t4, $t8, not_new_min  # if (grade >= min) → ليس أقل
    sw $t4, min_grade          # min_grade = grade (تحديث)
not_new_min:

    ## --- 1.10: حساب الناجحين والراسبين / Count Pass/Fail ---
    lw $t9, pass_threshold     # $t9 = درجة النجاح (50)
    blt $t4, $t9, count_fail   # if (grade < threshold) → راسب

    ## ناجح / Pass
    lw $t9, pass_count         # $t9 = عدد الناجحين الحالي
    addi $t9, $t9, 1           # pass_count++
    sw $t9, pass_count
    b after_pass_fail_count

count_fail:
    ## راسب / Fail
    lw $t9, fail_count         # $t9 = عدد الراسبين الحالي
    addi $t9, $t9, 1           # fail_count++
    sw $t9, fail_count

after_pass_fail_count:
    addi $t2, $t2, 1           # index++ → ننتقل للطالب التالي
    b input_grades_loop

    ## --- 1.11: معالجة الأخطاء / Error Handling ---
invalid_num:
    la $a0, invalid_msg
    li $v0, 4
    syscall
    b option_enter_grades      # إعادة محاولة إدخال عدد الطلاب

invalid_grade:
    la $a0, invalid_range
    li $v0, 4
    syscall
    b input_grades_loop        # إعادة محاولة إدخال الدرجة (نفس index)

input_grades_done:
    la $a0, success_msg
    li $v0, 4
    syscall
    b menu_loop                # العودة للقائمة الرئيسية

    ## ================================================================
    ## ## الخيار 2: عرض جميع الدرجات / Option 2: Display All Grades
    ## ================================================================
    ## يعرض درجات جميع الطلاب مع حالة النجاح/الرسوب لكل طالب
    ## Displays all student grades with pass/fail status per student

option_display:
    lw $t0, num_students
    blez $t0, no_data           # if (num_students <= 0) → لا توجد بيانات

    la $a0, display_title
    li $v0, 4
    syscall

    la $s1, grades              # $s1 = عنوان مصفوفة الدرجات
    li $t1, 0                   # $t1 = index = 0

display_loop:
    bge $t1, $t0, display_done  # if (index >= count) → انتهى

    ## طباعة "Student X: Grade = Y"
    la $a0, student_label
    li $v0, 4
    syscall

    addi $t2, $t1, 1            # Student number = index + 1 (1-based)
    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, grade_label
    li $v0, 4
    syscall

    ## قراءة وعرض الدرجة / Load and Display Grade
    sll $t2, $t1, 2
    add $t2, $s1, $t2
    lw $t3, 0($t2)              # $t3 = grades[index]
    move $a0, $t3
    li $v0, 1
    syscall

    ## عرض حالة النجاح/الرسوب / Show Pass/Fail Status
    lw $t4, pass_threshold
    bge $t3, $t4, show_pass     # if (grade >= 50) → ناجح
    la $a0, failed_label
    li $v0, 4
    syscall
    b after_show_status

show_pass:
    la $a0, passed_label
    li $v0, 4
    syscall

after_show_status:
    la $a0, newline
    li $v0, 4
    syscall

    addi $t1, $t1, 1
    b display_loop

display_done:
    b menu_loop

    ## ================================================================
    ## ## الخيار 3: حساب المتوسط / Option 3: Calculate Average
    ## ================================================================
    ## المتوسط = مجموع الدرجات / عدد الطلاب
    ## Average = sum of grades / number of students

option_average:
    lw $t0, num_students
    blez $t0, no_data            # if (num_students <= 0) → لا توجد بيانات

    la $a0, avg_msg
    li $v0, 4
    syscall

    la $a0, avg_result
    li $v0, 4
    syscall

    lw $t1, sum_grades           # $t1 = مجموع الدرجات
    lw $t2, num_students         # $t2 = عدد الطلاب

    div $t1, $t2                 # قسمة: LO = quotient, HI = remainder
    mflo $t3                     # $t3 = quotient (الجزء الصحيح من المتوسط)
    mfhi $t4                     # $t4 = remainder (الباقي)

    sw $t3, average              # حفظ المتوسط في الذاكرة

    move $a0, $t3
    li $v0, 1
    syscall

    ## طباعة الباقي إذا كان موجوداً / Print Remainder If Present
    beqz $t4, avg_no_remainder   # if (remainder == 0) → تخطى

    la $a0, avg_remainder
    li $v0, 4
    syscall

    move $a0, $t4
    li $v0, 1
    syscall

avg_no_remainder:
    la $a0, newline
    li $v0, 4
    syscall
    b menu_loop

    ## ================================================================
    ## ## الخيار 4: إيجاد أعلى وأقل درجة / Option 4: Find Max & Min
    ## ================================================================

option_min_max:
    lw $t0, num_students
    blez $t0, no_data

    la $a0, min_max_msg
    li $v0, 4
    syscall

    la $a0, max_result
    li $v0, 4
    syscall

    lw $t1, max_grade
    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, min_result
    li $v0, 4
    syscall

    lw $t2, min_grade
    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall
    b menu_loop

    ## ================================================================
    ## ## الخيار 5: حساب عدد الناجحين والراسبين / Option 5: Pass & Fail
    ## ================================================================
    ## بالإضافة إلى عرض نسبة النجاح
    ## Also displays pass rate percentage

option_pass_fail:
    lw $t0, num_students
    blez $t0, no_data

    la $a0, pass_fail_msg
    li $v0, 4
    syscall

    ## --- 5.1: عدد الناجحين / Pass Count ---
    la $a0, pass_result
    li $v0, 4
    syscall

    lw $t1, pass_count
    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 5.2: عدد الراسبين / Fail Count ---
    la $a0, fail_result
    li $v0, 4
    syscall

    lw $t2, fail_count
    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 5.3: حساب نسبة النجاح / Calculate Pass Rate ---
    ## النسبة = (pass_count × 100) / num_students
    la $a0, pass_rate_msg
    li $v0, 4
    syscall

    lw $t3, pass_count          # $t3 = عدد الناجحين
    li $t4, 100
    mul $t3, $t3, $t4           # $t3 = pass_count × 100
    lw $t4, num_students        # $t4 = عدد الطلاب الكلي
    div $t3, $t4                # قسمة: (pass_count × 100) / num_students
    mflo $t5                    # $t5 = النسبة المئوية

    move $a0, $t5
    li $v0, 1
    syscall

    la $a0, percent_msg
    li $v0, 4
    syscall
    b menu_loop

    ## ================================================================
    ## ## الخيار 6: عرض إحصائيات كاملة / Option 6: Full Statistics
    ## ================================================================
    ## يعرض كل الإحصائيات في شاشة واحدة:
    ## عدد الطلاب، المتوسط، أعلى/أقل درجة، الناجحين/الراسبين
    ## Displays all stats in one screen

option_statistics:
    lw $t0, num_students
    blez $t0, no_data

    la $a0, stats_title
    li $v0, 4
    syscall

    la $a0, stats_line
    li $v0, 4
    syscall

    ## --- 6.1: عدد الطلاب / Total Students ---
    la $a0, total_students
    li $v0, 4
    syscall

    lw $t1, num_students
    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 6.2: المتوسط الحسابي / Average ---
    la $a0, avg_result
    li $v0, 4
    syscall

    lw $t2, sum_grades
    lw $t3, num_students
    div $t2, $t3
    mflo $t4
    sw $t4, average

    move $a0, $t4
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 6.3: أعلى درجة / Maximum Grade ---
    la $a0, max_result
    li $v0, 4
    syscall

    lw $t5, max_grade
    move $a0, $t5
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 6.4: أقل درجة / Minimum Grade ---
    la $a0, min_result
    li $v0, 4
    syscall

    lw $t6, min_grade
    move $a0, $t6
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 6.5: عدد الناجحين / Pass Count ---
    la $a0, pass_result
    li $v0, 4
    syscall

    lw $t7, pass_count
    move $a0, $t7
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    ## --- 6.6: عدد الراسبين / Fail Count ---
    la $a0, fail_result
    li $v0, 4
    syscall

    lw $t8, fail_count
    move $a0, $t8
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, stats_line
    li $v0, 4
    syscall
    b menu_loop

    ## ================================================================
    ## ## حالة عدم وجود بيانات / No Data Available
    ## ================================================================
    ## تُستدعى عندما يحاول المستخدم عرض أو حساب إحصائيات
    ## قبل إدخال أي درجات

no_data:
    la $a0, no_data_msg
    li $v0, 4
    syscall
    b menu_loop

    ## ================================================================
    ## ## الخيار 7: الخروج من البرنامج / Option 7: Exit Program
    ## ================================================================

exit_program:
    la $a0, exit_msg
    li $v0, 4
    syscall

    li $v0, 10
    syscall

## تعريف newline إضافي (قد تستخدمه بعض الأجزاء)
newline: .asciiz "\n"

# ============================================================
# ## ملخص التعليمات المستخدمة / Instructions Summary:
# -----------------------------------------------------------
# | التعليمة | المعنى بالعربية            | English Meaning             |
# |-----------|----------------------------|-----------------------------|
# | .word     | تعريف متغير بكلمة (4 بايت) | Define word variable       |
# | .space    | حجز مساحة في الذاكرة       | Reserve memory space        |
# | lw/sw     | تحميل/تخزين كلمة           | Load/Store Word             |
# | sll       | إزاحة يسار (للوصول للمصفوفة)| Shift Left (array access)  |
# | beq/bne   | فرع شرطي (مساواة/عدم)      | Branch if (Not) Equal       |
# | bgt/blt   | فرع شرطي (أكبر/أصغر)       | Branch if Greater/Less      |
# | bge/ble   | فرع شرطي (أكبر/أصغر أو يساوي)| Branch if Greater/Less or Equal |
# | div/mflo  | قسمة وجلب الناتج           | Division + Get quotient    |
# | mfhi      | جلب باقي القسمة            | Get remainder              |
# -----------------------------------------------------------
# ## ملخص المشروع / Project Summary:
#   هذا المشروع النهائي يجمع كل المفاهيم السابقة:
#   - المتغيرات والذاكرة (.word, .space, lw, sw)
#   - المصفوفات (الوصول باستخدام sll والإزاحة)
#   - الحلقات التكرارية (for, while في MIPS)
#   - الجمل الشرطية (if-else chains مع الفروع)
#   - القوائم التفاعلية (Menu مع اختيارات متعددة)
#   - العمليات الحسابية (جمع، قسمة، ضرب)
#   - التحقق من صحة المدخلات (Input Validation)
# ============================================================
