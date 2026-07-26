# المحاضرة الثانية: العمليات الحسابية الأساسية

---

## شرح كل أمر

### `li $t0, 10` / `li $t1, 3`

وضع الرقمين 10 و 3 في `$t0`, `$t1`.
في C++: `int t0 = 10, t1 = 3;`

### `add $t2, $t0, $t1`

- **add** = Addition (جمع)
- `$t2 = $t0 + $t1`
- الصيغة: `add $destination, $source1, $source2`
- المسجل الأول دائماً هو مكان النتيجة
- في C++: `t2 = t0 + t1;`

### `sub $t3, $t0, $t1`

- **sub** = Subtraction (طرح)
- `$t3 = $t0 - $t1`
- الترتيب مهم: `sub $d, $a, $b` يعني `$d = $a - $b`
- في C++: `t3 = t0 - t1;`

### `mul $t4, $t0, $t1`

- **mul** = Multiplication (ضرب)
- `$t4 = $t0 * $t1`
- في C++: `t4 = t0 * t1;`

### `div $t0, $t1`

- **div** = Division (قسمة)
- `$t0 ÷ $t1`
- **الفرق:** `div` لا يعطي النتيجة في مسجل عادي
- النتيجة تذهب إلى مكانين خاصين داخل CPU:
  - **LO** = ناتج القسمة (Quotient)
  - **HI** = باقي القسمة (Remainder)
- لإحضارهما نستخدم `mflo` و `mfhi`

### `mflo $t5`

- **mflo** = Move From LO
- `$t5` = قيمة LO (ناتج القسمة)
- في C++: `t5 = t0 / t1;` (قسمة صحيحة)

### `mfhi $t6`

- **mfhi** = Move From HI
- `$t6` = قيمة HI (باقي القسمة)
- في C++: `t6 = t0 % t1;` (باقي القسمة)

### لماذا القسمة مختلفة؟

CPU ينفذ **عملية واحدة** فينتج **نتيجتين**: ناتج وباقٍ. فاستخدم مكانين خاصين (LO, HI) بدل عمليتين منفصلتين.

---

## الكود

```mips
.data
    msg_add: .asciiz "a + b = "
    msg_sub: .asciiz "a - b = "
    msg_mul: .asciiz "a * b = "
    msg_div: .asciiz "a / b = "
    msg_rem: .asciiz "a % b = "
    newline: .asciiz "\n"

.text
main:
    li $t0, 10               # $t0 = 10     (C++: int a = 10;)
    li $t1, 3                # $t1 = 3      (C++: int b = 3;)

    # ---------- a + b (جمع) ----------
    la $a0, msg_add
    li $v0, 4
    syscall
    add $t2, $t0, $t1        # $t2 = $t0 + $t1 = 13   (C++: t2 = a + b;)
    move $a0, $t2
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a - b (طرح) ----------
    la $a0, msg_sub
    li $v0, 4
    syscall
    sub $t3, $t0, $t1        # $t3 = $t0 - $t1 = 7    (C++: t3 = a - b;)
    move $a0, $t3
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a * b (ضرب) ----------
    la $a0, msg_mul
    li $v0, 4
    syscall
    mul $t4, $t0, $t1        # $t4 = $t0 * $t1 = 30   (C++: t4 = a * b;)
    move $a0, $t4
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a / b (قسمة) ----------
    la $a0, msg_div
    li $v0, 4
    syscall
    div $t0, $t1             # $t0 ÷ $t1  (LO = ناتج, HI = باقي)
    mflo $t5                 # $t5 = ناتج القسمة  (C++: t5 = a / b;)
    move $a0, $t5
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a % b (باقي القسمة) ----------
    la $a0, msg_rem
    li $v0, 4
    syscall
    mfhi $t6                 # $t6 = باقي القسمة  (C++: t6 = a % b;)
    move $a0, $t6
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- اخروج ----------
    li $v0, 10
    syscall
```

---

## خلاصة التعليمات الجديدة

| الأمر | المعنى | المقابل في C++ |
|-------|--------|----------------|
| `add $d, $a, $b` | `$d = $a + $b` (جمع) | `d = a + b` |
| `sub $d, $a, $b` | `$d = $a - $b` (طرح) | `d = a - b` |
| `mul $d, $a, $b` | `$d = $a * $b` (ضرب) | `d = a * b` |
| `div $a, $b` | `$a ÷ $b` (ناتج في LO, باقٍ في HI) | `a / b`, `a % b` |
| `mflo $d` | `$d = LO` (جلب ناتج القسمة) | `d = a / b` |
| `mfhi $d` | `$d = HI` (جلب باقي القسمة) | `d = a % b` |
