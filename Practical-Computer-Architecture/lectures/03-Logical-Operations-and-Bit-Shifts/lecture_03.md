# المحاضرة الثالثة: العمليات المنطقية وإزاحة البتات

---

## شرح كل أمر

### `li $t0, 0x12345678`

وضع الرقم `0x12345678` (hex) في `$t0`. الرمز `0x` يعني أن الرقم بالنظام السداسي عشر.
في C++: `int t0 = 0x12345678;`

### `andi $t1, $t0, 0xFF`

- **andi** = AND Immediate (AND مع قيمة فورية)
- `$t1 = $t0 & 0x000000FF`
- **AND على مستوى البتات:** `1&1=1`، `1&0=0`، `0&1=0`، `0&0=0`
- **الاستخدام:** إخفاء (masking) — نجعل بعض البتات 0
- `0xFF` = 255 = `000000FF` في Hex
- AND مع `0xFF` يُبقي أول 8 بتات كما هي ويُخفي الباقي
- الحرف `i` في `andi` = Immediate (القيمة الثانية ثابتة وليست مسجلاً)

### `ori $t2, $t0, 0xFF`

- **ori** = OR Immediate
- `$t2 = $t0 | 0x000000FF`
- **OR:** `0|0=0`، `0|1=1`، `1|0=1`، `1|1=1`
- **الاستخدام:** ضبط بتات معينة على 1
- OR مع `0xFF` يضبط أول 8 بتات على 1، والباقي كما هو

### `xori $t3, $t0, 0xFF`

- **xori** = XOR Immediate
- `$t3 = $t0 ^ 0x000000FF`
- **XOR:** `0^0=0`، `0^1=1`، `1^0=1`، `1^1=0`
- **الاستخدام:** عكس بتات معينة
- XOR مع `0xFF` يعكس أول 8 بتات
- XOR مع `0xFFFFFFFF` يعكس كل البتات (كأنه NOT)

### `sll $t4, $t0, 8`

- **sll** = Shift Left Logical (إزاحة يسار)
- `$t4 = $t0 << 8`
- حرّك البتات 8 خانات لليسار. كل إزاحة لليسار = ضرب في 2
- `sll` بـ 8 = ضرب في `2^8 = 256`

### `srl $t5, $t0, 8`

- **srl** = Shift Right Logical (إزاحة يمين)
- `$t5 = $t0 >> 8`
- كل إزاحة لليمين = قسمة على 2
- `srl` بـ 8 = قسمة على 256

### `syscall 34` (طباعة hex)

`$v0 = 34` يجعل `syscall` يطبع الرقم بالنظام السداسي عشر بدلاً من `syscall 1` الذي يطبع رقمًا عشريًا.

---

## الكود

```mips
.data
    msg_and: .asciiz "a & 0xFF = 0x"
    msg_or:  .asciiz "a | 0xFF = 0x"
    msg_xor: .asciiz "a ^ 0xFF = 0x"
    msg_sll: .asciiz "a << 8   = 0x"
    msg_srl: .asciiz "a >> 8   = 0x"
    newline: .asciiz "\n"

.text
main:
    li $t0, 0x12345678         # $t0 = 0x12345678  (C++: int a = 0x12345678;)

    # ---------- a & 0xFF (AND قناع) ----------
    la $a0, msg_and
    li $v0, 4
    syscall
    andi $t1, $t0, 0xFF        # $t1 = $t0 & 0xFF   (C++: t1 = a & 0xFF;)
    move $a0, $t1
    li $v0, 34                 # syscall 34 = اطبع hex
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a | 0xFF (OR ضبط) ----------
    la $a0, msg_or
    li $v0, 4
    syscall
    ori $t2, $t0, 0xFF         # $t2 = $t0 | 0xFF   (C++: t2 = a | 0xFF;)
    move $a0, $t2
    li $v0, 34
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a ^ 0xFF (XOR عكس) ----------
    la $a0, msg_xor
    li $v0, 4
    syscall
    xori $t3, $t0, 0xFF        # $t3 = $t0 ^ 0xFF   (C++: t3 = a ^ 0xFF;)
    move $a0, $t3
    li $v0, 34
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a << 8 (إزاحة يسار ×256) ----------
    la $a0, msg_sll
    li $v0, 4
    syscall
    sll $t4, $t0, 8            # $t4 = $t0 << 8      (C++: t4 = a << 8;)
    move $a0, $t4
    li $v0, 34
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- a >> 8 (إزاحة يمين ÷256) ----------
    la $a0, msg_srl
    li $v0, 4
    syscall
    srl $t5, $t0, 8            # $t5 = $t0 >> 8      (C++: t5 = a >> 8;)
    move $a0, $t5
    li $v0, 34
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
| `andi $t, $s, val` | `$t = $s & val` (AND قناع) | `t = s & val` |
| `ori $t, $s, val` | `$t = $s \| val` (OR ضبط) | `t = s \| val` |
| `xori $t, $s, val` | `$t = $s ^ val` (XOR عكس) | `t = s ^ val` |
| `sll $t, $s, n` | `$t = $s << n` (إزاحة يسار ×2ⁿ) | `t = s << n` |
| `srl $t, $s, n` | `$t = $s >> n` (إزاحة يمين ÷2ⁿ) | `t = s >> n` |
| `syscall 34` | اطبع hex | `cout << hex << x` |
