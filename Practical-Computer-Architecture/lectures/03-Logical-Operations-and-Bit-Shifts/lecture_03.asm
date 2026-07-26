# ============================================================
# المحاضرة الثالثة: العمليات المنطقية وإزاحة البتات
# ============================================================
#
# ----------------------------------
# الأوامر الجديدة:
#   andi $t, $s, n   →  $t = $s & n       (AND)
#   ori  $t, $s, n   →  $t = $s | n       (OR)
#   xori $t, $s, n   →  $t = $s ^ n       (XOR)
#   sll  $t, $s, n   →  $t = $s << n      (إزاحة يسار ×2^n)
#   srl  $t, $s, n   →  $t = $s >> n      (إزاحة يمين ÷2^n)
#   syscall 34       →  اطبع رقماً بصيغة hex
# ----------------------------------

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
    # 0xFF = 255 = أول 8 بتات فقط
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

    # ---------- a << 8 (إزاحة يسار = ضرب ×256) ----------
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

    # ---------- a >> 8 (إزاحة يمين = قسمة ÷256) ----------
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
