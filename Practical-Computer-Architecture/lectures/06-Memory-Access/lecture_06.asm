# ============================================================
# 06: التعامل مع الذاكرة — lw, sw, la
# ============================================================
#
# ✨ الفرق بين المسجل (Register) والذاكرة (RAM):
#   Register: سريع, صغير, مؤقت
#   RAM:      بطيء, كبير, دائم
#
# للنسخ المبسّطة، راجع:
#   lecture_06a_lw.asm  ← قراءة من RAM فقط
#   lecture_06b_sw.asm  ← كتابة إلى RAM فقط
#   lecture_06c_la.asm  ← عنوان vs قيمة فقط
#
# أوامر جديدة:
#   .word n          → احجز 4 بايت في RAM، القيمة = n
#   lw $t, label     → اقرأ من RAM ← C++: t = x;
#   sw $t, label     → اكتب إلى RAM ← C++: x = t;
#   la $t, label     → $t = عنوان label ← C++: t = &x;
#
# كل سطر له شرح بالعربي 👇
# ============================================================

.data
    x: .word 42                # int x = 42; (في RAM)
    y: .word 0                 # int y = 0;  (في RAM)

    msg_x:  .asciiz "x = "
    msg_y:  .asciiz "y = "
    addr_x: .asciiz "Address of x = 0x"
    newline: .asciiz "\n"

.text
main:
    # ========================================
    # 1) LW: اقرأ من RAM
    # ========================================
    la $a0, msg_x
    li $v0, 4
    syscall

    lw $t0, x                  # $t0 = x
                                # اذهب إلى RAM وخذ قيمة x (= 42)
                                # ← C++: t0 = x;

    move $a0, $t0
    li $v0, 1
    syscall                    # يظهر: 42
    la $a0, newline
    li $v0, 4
    syscall

    # ========================================
    # 2) SW: اكتب إلى RAM
    # ========================================
    li $t1, 99                 # $t1 = 99 (في المسجل)
    sw $t1, y                  # y = $t1
                                # خذ 99 من $t1 وخزّنها في RAM (في y)
                                # ← C++: y = t1;

    la $a0, msg_y
    li $v0, 4
    syscall

    lw $t2, y                  # اقرأ y من RAM للتحقق
    move $a0, $t2
    li $v0, 1
    syscall                    # يظهر: 99
    la $a0, newline
    li $v0, 4
    syscall

    # ========================================
    # 3) LA vs LW: عنوان vs قيمة
    # ========================================
    la $a0, addr_x
    li $v0, 4
    syscall

    la $t3, x                  # $t3 = عنوان x
                                # ← C++: int* t3 = &x;
    move $a0, $t3
    li $v0, 34                 # اطبع العنوان (hex)
    syscall

    li $v0, 10
    syscall
