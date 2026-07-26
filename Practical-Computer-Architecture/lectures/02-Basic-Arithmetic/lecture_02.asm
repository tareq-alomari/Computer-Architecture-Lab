# ============================================================
# المحاضرة الثانية: العمليات الحسابية — جمع، طرح، ضرب، قسمة
# ============================================================
#
# ----------------------------------
# الأوامر الجديدة:
#   add  $d, $a, $b  →  $d = $a + $b    (جمع)
#   sub  $d, $a, $b  →  $d = $a - $b    (طرح)
#   mul  $d, $a, $b  →  $d = $a * $b    (ضرب)
#   div  $a, $b      →  $a ÷ $b         (قسمة)
#   mflo $d          →  $d = LO         (ناتج القسمة)
#   mfhi $d          →  $d = HI         (باقي القسمة)
# ----------------------------------

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
    # div يعطي ناتجين: LO = ناتج القسمة، HI = باقي القسمة
    la $a0, msg_div
    li $v0, 4
    syscall
    div $t0, $t1             # $t0 ÷ $t1  (C++: a / b;)
    mflo $t5                 # $t5 = LO = ناتج القسمة  (C++: t5 = a / b;)
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
    mfhi $t6                 # $t6 = HI = باقي القسمة  (C++: t6 = a % b;)
    move $a0, $t6
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---------- اخروج ----------
    li $v0, 10
    syscall
