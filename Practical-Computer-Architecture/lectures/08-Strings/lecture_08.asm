# ============================================================
# المحاضرة الثامنة: السلاسل النصية — lb, sb, .asciiz
# ============================================================
#
# ----------------------------------
# الأوامر الجديدة:
#   .asciiz        →  نص + \0 في النهاية
#   lb $t, addr    →  اقرأ بايتاً واحداً من RAM   (C++: char c = str[i];)
#   sb $t, addr    →  اكتب بايتاً واحداً في RAM    (C++: str[i] = c;)
#   beqz $r, L     →  إذا $r == 0 اذهب إلى L
# ----------------------------------

.data
    str: .asciiz "hello"          # "hello" + \0  (6 بايت في RAM)
    msg_len: .asciiz "Length = "
    msg_up:  .asciiz "Uppercase: "
    newline: .asciiz "\n"

.text
main:
    # ========================================
    # مثال L: strlen — احسب طول النص
    # C++:
    #   char str[] = "hello";
    #   int len = 0;
    #   while (str[len] != '\0') len++;
    # ========================================
    la $a0, msg_len
    li $v0, 4
    syscall

    la $t0, str                  # $t0 = عنوان أول حرف  (C++: char* t0 = str;)
    li $t1, 0                    # $t1 = length = 0

len_loop:
    lb $t2, 0($t0)               # $t2 = الحرف الحالي    (C++: char c = *t0;)
    beqz $t2, done_len           # إذا الحرف = \0 → انتهى النص

    addi $t1, $t1, 1             # length++
    addi $t0, $t0, 1             # انتقل للحرف التالي   (C++: t0++;)

    b len_loop

done_len:
    move $a0, $t1                # اطبع الطول
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ========================================
    # مثال: تحويل الأحرف الصغيرة إلى كبيرة
    # C++:
    #   for (int i = 0; str[i] != '\0'; i++)
    #       if (str[i] >= 'a' && str[i] <= 'z')
    #           str[i] -= 32;
    # ملاحظة: 'a' = 97, 'A' = 65, الفرق = 32
    # ========================================
    la $a0, msg_up
    li $v0, 4
    syscall

    la $t0, str                  # $t0 = عنوان أول حرف

upper_loop:
    lb $t2, 0($t0)               # اقرأ الحرف الحالي
    beqz $t2, done_upper         # إذا \0 → انتهى

    # --- تحقق إذا الحرف بين 'a' (97) و 'z' (122) ---
    li $t3, 97                   # $t3 = 'a'
    blt $t2, $t3, skip           # إذا الحرف < 'a' → تجاوز
    li $t3, 122                  # $t3 = 'z'
    bgt $t2, $t3, skip           # إذا الحرف > 'z' → تجاوز

    addi $t2, $t2, -32           # حوّل إلى كبير: c - 32  (C++: c -= 32;)
    sb $t2, 0($t0)               # اكتب الحرف الكبير مكانه  (C++: str[i] = c;)

skip:
    addi $t0, $t0, 1             # انتقل للحرف التالي
    b upper_loop

done_upper:
    la $a0, str                  # اطبع النص بعد التحويل
    li $v0, 4
    syscall

    li $v0, 10
    syscall
