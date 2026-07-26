# المحاضرة الرابعة: الجمل الشرطية

---

## شرح كل أمر

### `andi $t1, $t0, 1`

`$t1 = $t0 & 1`. لماذا 1؟ لأن 1 = `...0001` في Binary.
AND مع 1 يُخفي كل البتات إلا **أقل بت (LSB)**.
- إن كان LSB = 0 → العدد **زوجي** (Even)
- إن كان LSB = 1 → العدد **فردي** (Odd)

مثال: `5 = 101`, `5&1=1` → Odd | `6 = 110`, `6&1=0` → Even

### `beqz $t1, print_even`

- **beqz** = Branch if EQual to Zero
- إن كان `$t1 == 0`، اذهب (اقفز) إلى label المسمى `print_even`
- ليس مثل `if` في C++ — إنها **قفزة**. التنفيذ يستمر من `print_even`
- في C++: `if (t1 == 0) goto print_even;`

### `bgt $t0, $zero, print_pos`

- **bgt** = Branch if Greater Than
- إن كان `$t0 > $zero` (أي `$t0 > 0`)، اذهب إلى `print_pos`
- `$zero` = مسجل رقم 0، قيمته دائماً 0
- في C++: `if (t0 > 0) goto print_pos;`

### `blt $t0, $zero, print_neg`

- **blt** = Branch if Less Than
- إن كان `$t0 < 0`، اذهب إلى `print_neg`
- في C++: `if (t0 < 0) goto print_neg;`

### `b done`

- **b** = Branch غير مشروط (يعمل دائماً)
- اذهب إلى `done`. لا يوجد شرط. مثل `goto` في C++
- نستخدمه **لتخطي** كتلة else
- إن لم نضع `b done`، البرنامج سيستمر وينفذ كتلة else خطأً!

### هيكل if-else في Assembly

```
    C++:                          ASM:
    if (x > 0)                    bgt $t0, $zero, positive
        positive_code;            negative_code  (إن وصلت هنا فـ x ≤ 0)
    else                          j after_if
        negative_code;        positive:
                                  positive_code
                              after_if:
```

يجب استخدام `b` (قفزة غير مشروطة) لتخطي else.

---

## الكود

```mips
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
    andi $t1, $t0, 1         # $t1 = $t0 & 1   (إذا LSB=1 → فردي)
    beqz $t1, print_even     # إذا $t1 == 0 → اذهب إلى print_even

    # --- فردي (Odd) ---
    la $a0, odd
    li $v0, 4
    syscall
    b check_sign             # ← اذهب إلى check_sign

print_even:
    # --- زوجي (Even) ---
    la $a0, even
    li $v0, 4
    syscall

    # ---------- هل الرقم موجب أم سالب أم صفر؟ ----------
check_sign:
    bgt $t0, $zero, print_pos    # إذا $t0 > 0 → موجب
    blt $t0, $zero, print_neg    # إذا $t0 < 0 → سالب
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
```

---

## خلاصة التعليمات الجديدة

| الأمر | المعنى | المقابل في C++ |
|-------|--------|----------------|
| `beqz $r, L` | if (`$r == 0`) goto L | `if (r == 0)` |
| `bnez $r, L` | if (`$r != 0`) goto L | `if (r != 0)` |
| `bgt $a, $b, L` | if (`$a > $b`) goto L | `if (a > b)` |
| `blt $a, $b, L` | if (`$a < $b`) goto L | `if (a < b)` |
| `bge $a, $b, L` | if (`$a >= $b`) goto L | `if (a >= b)` |
| `ble $a, $b, L` | if (`$a <= $b`) goto L | `if (a <= b)` |
| `beq $a, $b, L` | if (`$a == $b`) goto L | `if (a == b)` |
| `bne $a, $b, L` | if (`$a != $b`) goto L | `if (a != b)` |
| `b L` | goto L (غير مشروط) | `goto L` |
| `$zero` | مسجل قيمته دائماً 0 | `0` |
