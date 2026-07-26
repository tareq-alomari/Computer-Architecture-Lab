# ============================================================
# 08: السلاسل النصية — lb, sb, .asciiz
# ============================================================
#
# ✨ نصوص MIPS: كل نص ينتهي بـ \0 (null)
#    نقرأ حرفاً حرفاً بـ LB ونكتب بـ SB
#
# للنسخ المبسّطة، راجع:
#   lecture_08a_strlen.asm    ← حساب طول النص فقط
#   lecture_08b_to_upper.asm  ← تحويل إلى uppercase فقط
#
# أوامر جديدة:
#   .asciiz        → نص + \0 في النهاية
#   lb $t, addr    → اقرأ بايتاً واحداً
#   sb $t, addr    → اكتب بايتاً واحداً
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    str: .asciiz "hello"          # "hello" + \0 (6 بايت)
    msg_len: .asciiz "Length = "
    msg_up:  .asciiz "Uppercase: "
    newline: .asciiz "\n"

.text
main:
    # ========================================
    # 1) strlen: احسب طول النص
    #    نمشي على الحروف لنوصل لـ \0
    # ========================================
    la $a0, msg_len
    li $v0, 4
    syscall

    la $t0, str                  # $t0 = عنوان أول حرف
    li $t1, 0                    # $t1 = length = 0

len_loop:
    lb $t2, 0($t0)               # $t2 = الحرف الحالي
    beqz $t2, done_len           # if $t2 == 0 (null) → انتهى

    addi $t1, $t1, 1             # length++
    addi $t0, $t0, 1             # انتقل للحرف التالي
    b len_loop

done_len:
    move $a0, $t1
    li $v0, 1
    syscall                      # يظهر: 5
    la $a0, newline
    li $v0, 4
    syscall

    # ========================================
    # 2) to_upper: حوّل الحروف الصغيرة → كبيرة
    #    الفرق بين 'a' و 'A' = 32
    # ========================================
    la $a0, msg_up
    li $v0, 4
    syscall

    la $t0, str                  # $t0 = أول حرف

upper_loop:
    lb $t2, 0($t0)               # اقرأ الحرف
    beqz $t2, done_upper         # إذا null → انتهى

    # --- تحقق: هل الحرف بين 'a'(97) و 'z'(122)? ---
    li $t3, 97
    blt $t2, $t3, skip           # if < 'a' → تجاوز
    li $t3, 122
    bgt $t2, $t3, skip           # if > 'z' → تجاوز

    addi $t2, $t2, -32           # حوّل لكبير: 'h'(104) - 32 = 'H'(72)
    sb $t2, 0($t0)               # اكتب الحرف الكبير مكانه

skip:
    addi $t0, $t0, 1             # الحرف التالي
    b upper_loop

done_upper:
    la $a0, str
    li $v0, 4
    syscall                      # يظهر: HELLO

    li $v0, 10
    syscall
