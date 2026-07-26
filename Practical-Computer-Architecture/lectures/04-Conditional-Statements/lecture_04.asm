# ============================================================
# 04: الجمل الشرطية — if/else في MIPS
# ============================================================
#
# ✨ البرنامج يسأل المستخدم رقماً، ويقرر:
#    - زوجي أم فردي؟
#    - موجب أم سالب أم صفر؟
#
# للنسخ المبسّطة، راجع:
#   lecture_04a_even_odd.asm  ← زوجي/فردي فقط
#   lecture_04b_sign.asm      ← موجب/سالب/صفر فقط
#
# أوامر جديدة:
#   beqz $r, L   → if ($r == 0) goto L
#   bgt  $a,$b,L → if ($a > $b) goto L
#   blt  $a,$b,L → if ($a < $b) goto L
#   b    L       → goto L
#   $zero        → مسجل قيمته 0 دائماً
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    prompt: .asciiz "Enter a number: "
    even:   .asciiz "Even\n"
    odd:    .asciiz "Odd\n"
    pos:    .asciiz "Positive\n"
    neg:    .asciiz "Negative\n"
    zero:   .asciiz "Zero\n"

.text
main:
    # ------------------------------
    # 1) اقرأ رقماً من المستخدم
    # ------------------------------
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0            # $t0 = الرقم اللي أدخله المستخدم

    # ------------------------------
    # 2) زوجي أم فردي؟
    #    الفكرة: (رقم & 1) == 0 → زوجي
    # ------------------------------
    andi $t1, $t0, 1         # $t1 = أقل بت (LSB)
    beqz $t1, print_even     # if LSB == 0 → اذهب إلى print_even

    # --- فردي ---
    la $a0, odd
    li $v0, 4
    syscall
    b check_sign             # اذهب إلى check_sign (نتخطى print_even)

print_even:
    # --- زوجي ---
    la $a0, even
    li $v0, 4
    syscall

    # ------------------------------
    # 3) موجب أم سالب أم صفر؟
    #    نقارن مع $zero (اللي قيمته 0)
    # ------------------------------
check_sign:
    bgt $t0, $zero, print_pos   # if $t0 > 0 → موجب
    blt $t0, $zero, print_neg   # if $t0 < 0 → سالب
    # --- صفر ---
    la $a0, zero
    li $v0, 4
    syscall
    b done

print_pos:
    la $a0, pos
    li $v0, 4
    syscall
    b done

print_neg:
    la $a0, neg
    li $v0, 4
    syscall

done:
    li $v0, 10
    syscall
