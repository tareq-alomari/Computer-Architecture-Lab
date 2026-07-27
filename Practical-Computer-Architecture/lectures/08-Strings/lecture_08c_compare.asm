# ============================================================
# 08c: مقارنة نصين — String Compare
# ============================================================
#
# ✨ نقارن نصين حرفاً حرفاً
#    إذا كل الحروف متساوية → النصوص متساوية
# ============================================================

.data
    str1: .asciiz "hello"
    str2: .asciiz "hello"
    msg_eq: .asciiz "Strings are equal\n"
    msg_ne: .asciiz "Strings are not equal\n"

.text
main:
    la $t0, str1
    la $t1, str2

comp_loop:
    lb $t2, 0($t0)           # حرف من str1
    lb $t3, 0($t1)           # حرف من str2

    bne $t2, $t3, not_equal  # إذا مختلفان → مش متساويين
    beqz $t2, equal           # إذا وصلنا \0 → متساويين

    addi $t0, $t0, 1
    addi $t1, $t1, 1
    b comp_loop

equal:
    la $a0, msg_eq
    li $v0, 4
    syscall
    b done

not_equal:
    la $a0, msg_ne
    li $v0, 4
    syscall

done:
    li $v0, 10
    syscall
