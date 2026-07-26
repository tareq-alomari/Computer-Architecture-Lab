# ============================================================
# 04b: موجب أم سالب أم صفر؟ (Positive / Negative / Zero)
# ============================================================
#
# ✨ نقارن الرقم مع الصفر:
#   إذا الرقم > 0 ← Positive
#   إذا الرقم < 0 ← Negative
#   وإلا          ← Zero
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    prompt: .asciiz "Enter a number: "
    pos:    .asciiz "Positive\n"    # "موجب"
    neg:    .asciiz "Negative\n"    # "سالب"
    zero:   .asciiz "Zero\n"        # "صفر"

.text
main:
    # ------------------------------
    # 1) اقرأ رقم من المستخدم
    # ------------------------------
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # $t0 = الرقم

    # ------------------------------
    # 2) قارن مع الصفر
    #    $zero = مسجل ثابت قيمته 0
    # ------------------------------

    bgt $t0, $zero, print_pos  # if $t0 > 0 → اذهب إلى print_pos
                                # "إذا الرقم أكبر من صفر → موجب"

    blt $t0, $zero, print_neg  # if $t0 < 0 → اذهب إلى print_neg
                                # "إذا الرقم أصغر من صفر → سالب"

    # --- هنا نصل إذا الرقم = 0 ---
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
