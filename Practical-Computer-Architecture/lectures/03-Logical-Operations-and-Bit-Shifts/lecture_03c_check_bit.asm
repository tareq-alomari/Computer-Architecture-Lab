# ============================================================
# 03c: تحقق من بت معين — Check Bit
# ============================================================
#
# ✨ نتحقق: هل bit رقم 3 في الرقم = 1؟
#    نستخدم ANDI + SRL
# ============================================================

.data
    msg_on: .asciiz "Bit 3 is ON\n"
    msg_off: .asciiz "Bit 3 is OFF\n"

.text
main:
    li $t0, 0x12345678      # الرقم

    srl $t1, $t0, 3         # انقل bit 3 إلى أول مكان
    andi $t1, $t1, 1        # خذ أول bit فقط

    beqz $t1, off           # if 0 → OFF

    la $a0, msg_on
    li $v0, 4
    syscall
    b done

off:
    la $a0, msg_off
    li $v0, 4
    syscall

done:
    li $v0, 10
    syscall
