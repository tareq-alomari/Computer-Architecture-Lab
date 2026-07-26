# ============================================================
# 03: العمليات المنطقية وإزاحة البتات
# ============================================================
#
# ✨ تعلّم كيف تتعامل مع البتات (bits)
#    للنسخ المبسّطة، راجع:
#      lecture_03a_logic.asm  ← AND, OR, XOR فقط
#      lecture_03b_shift.asm  ← SLL, SRL فقط
#
# أوامر جديدة:
#   andi $t, $s, n   →  $t = $s & n       (AND)
#   ori  $t, $s, n   →  $t = $s | n       (OR)
#   xori $t, $s, n   →  $t = $s ^ n       (XOR)
#   sll  $t, $s, n   →  $t = $s << n      (إزاحة يسار)
#   srl  $t, $s, n   →  $t = $s >> n      (إزاحة يمين)
#   syscall 34       →  اطبع بصيغة hex
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    msg_and: .asciiz "a & 0xFF = 0x"
    msg_or:  .asciiz "a | 0xFF = 0x"
    msg_xor: .asciiz "a ^ 0xFF = 0x"
    msg_sll: .asciiz "a << 8   = 0x"
    msg_srl: .asciiz "a >> 8   = 0x"
    newline: .asciiz "\n"

.text
main:
    li $t0, 0x12345678         # a = 0x12345678 (رقم hex كبير)

    # ------------------------------
    # 1) AND: a & 0xFF
    #    يحتفظ بأول 8 bits فقط
    # ------------------------------
    la $a0, msg_and
    li $v0, 4
    syscall

    andi $t1, $t0, 0xFF        # $t1 = $t0 & 0xFF = 0x78

    move $a0, $t1
    li $v0, 34                 # syscall 34 = اطبع hex
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ------------------------------
    # 2) OR: a | 0xFF
    #    يجعل أول 8 bits كلها 1
    # ------------------------------
    la $a0, msg_or
    li $v0, 4
    syscall

    ori $t2, $t0, 0xFF         # $t2 = $t0 | 0xFF

    move $a0, $t2
    li $v0, 34
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ------------------------------
    # 3) XOR: a ^ 0xFF
    #    يعكس أول 8 bits
    # ------------------------------
    la $a0, msg_xor
    li $v0, 4
    syscall

    xori $t3, $t0, 0xFF        # $t3 = $t0 ^ 0xFF

    move $a0, $t3
    li $v0, 34
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ------------------------------
    # 4) SLL: a << 8
    #    كل إزاحة يسار = ضرب × 2
    # ------------------------------
    la $a0, msg_sll
    li $v0, 4
    syscall

    sll $t4, $t0, 8            # $t4 = $t0 << 8

    move $a0, $t4
    li $v0, 34
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ------------------------------
    # 5) SRL: a >> 8
    #    كل إزاحة يمين = قسمة ÷ 2
    # ------------------------------
    la $a0, msg_srl
    li $v0, 4
    syscall

    srl $t5, $t0, 8            # $t5 = $t0 >> 8

    move $a0, $t5
    li $v0, 34
    syscall

    li $v0, 10
    syscall
