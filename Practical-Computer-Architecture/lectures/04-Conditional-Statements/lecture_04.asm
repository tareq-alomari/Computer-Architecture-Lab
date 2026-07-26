# ============================================================
# المحاضرة الرابعة: الجمل الشرطية — if/else
# ============================================================
#
# ----------------------------------
# الأوامر الجديدة:
#   beqz $r, L   → if ($r == 0) goto L
#   bgt  $a,$b,L → if ($a > $b) goto L
#   blt  $a,$b,L → if ($a < $b) goto L
#   b    L       → goto L
#   $zero        → مسجل قيمته 0 دائماً
# ----------------------------------

.data
    prompt: .asciiz "Enter a number: "
    even:   .asciiz "Even\n"
    odd:    .asciiz "Odd\n"
    pos:    .asciiz "Positive\n"
    neg:    .asciiz "Negative\n"
    zero:   .asciiz "Zero\n"

.text
main:
    # ---------- اقرأ رقماً من المستخدم ----------
    la $a0, prompt
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t0, $v0            # $t0 = الرقم الذي أدخله المستخدم

    # ---------- هل الرقم زوجي أم فردي؟ ----------
    # فكرة: أقل بت (LSB) يحدد الزوجية. 1 = فردي، 0 = زوجي
    andi $t1, $t0, 1         # $t1 = $t0 & 1   (C++: t1 = t0 & 1;)
    beqz $t1, print_even     # إذا $t1 == 0 → اذهب إلى print_even

    # --- فردي (Odd) ---
    la $a0, odd
    li $v0, 4
    syscall
    b check_sign             # ← اذهب إلى check_sign (نتخطى print_even)

print_even:
    # --- زوجي (Even) ---
    la $a0, even
    li $v0, 4
    syscall

    # ---------- هل الرقم موجب أم سالب أم صفر؟ ----------
check_sign:
    bgt $t0, $zero, print_pos    # إذا $t0 > 0 → اذهب إلى print_pos
    blt $t0, $zero, print_neg    # إذا $t0 < 0 → اذهب إلى print_neg
    # --- صفر (Zero) ---
    la $a0, zero
    li $v0, 4
    syscall
    b done

print_pos:
    # --- موجب (Positive) ---
    la $a0, pos
    li $v0, 4
    syscall
    b done

print_neg:
    # --- سالب (Negative) ---
    la $a0, neg
    li $v0, 4
    syscall

done:
    li $v0, 10
    syscall
