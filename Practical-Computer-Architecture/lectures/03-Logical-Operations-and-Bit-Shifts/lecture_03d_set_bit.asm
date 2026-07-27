# ============================================================
# 03d: تشغيل/إطفاء بت — Set / Clear Bit
# ============================================================
#
# ✨ نستخدم:
#    ORI  ← لتشغيل bit (1)
#    ANDI ← لإطفاء bit (0)
# ============================================================

.data
    msg_set: .asciiz "After set bit 3: 0x"
    msg_clr: .asciiz "After clear bit 3: 0x"
    newline: .asciiz "\n"

.text
main:
    li $t0, 0x12345678

    # ---- تشغيل bit 3: a | 8 ----
    la $a0, msg_set
    li $v0, 4
    syscall

    ori $t1, $t0, 8          # 8 = 2^3
    move $a0, $t1
    li $v0, 34
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ---- إطفاء bit 3: a & ~8 ----
    la $a0, msg_clr
    li $v0, 4
    syscall

    andi $t2, $t0, 0xFFFFFFF7  # 0xFFFFFFF7 = NOT(8)
    move $a0, $t2
    li $v0, 34
    syscall

    li $v0, 10
    syscall
