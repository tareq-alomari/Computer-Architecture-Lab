# ============================================================
# 05: حلقات التكرار — for و while
# ============================================================
#
# ✨ مثالان:
#    1) For loop:   اطبع 1 2 3 4 5 6 7 8 9 10
#    2) While loop: مجموع 1+2+3+...+N (المستخدم يدخل N)
#
# للنسخ المبسّطة، راجع:
#   lecture_05a_for_loop.asm    ← for loop فقط
#   lecture_05b_while_loop.asm  ← while loop فقط
#
# أوامر جديدة:
#   addi $t, $s, n   →  $t = $s + n   (جمع مع رقم ثابت)
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    space:   .asciiz " "
    newline: .asciiz "\n"
    prompt:  .asciiz "Enter N: "
    sum_msg: .asciiz "Sum = "

.text
main:
    # ========================================
    # مثال 1: For loop — اطبع 1 إلى 10
    # ========================================
    li $t0, 1                # $t0 = i = 1

print_loop:
    bgt $t0, 10, done_print  # if i > 10 → اخرج
                              # شرط الخروج (عكس C++)

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall

    addi $t0, $t0, 1         # i++
    b print_loop             # ارجع إلى بداية الحلقة

done_print:
    la $a0, newline
    li $v0, 4
    syscall

    # ========================================
    # مثال 2: While loop — مجموع 1+2+...+N
    # ========================================

    # --- اسأل المستخدم: أدخل N ---
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t1, $v0            # $t1 = N

    # --- جهّز الحلقة ---
    li $t2, 1                # $t2 = i = 1
    li $t3, 0                # $t3 = sum = 0

sum_loop:
    bgt $t2, $t1, done_sum   # if i > N → اخرج

    add $t3, $t3, $t2        # sum += i
    addi $t2, $t2, 1         # i++
    b sum_loop               # كرّر

done_sum:
    la $a0, sum_msg
    li $v0, 4
    syscall

    move $a0, $t3
    li $v0, 1
    syscall

    li $v0, 10
    syscall
