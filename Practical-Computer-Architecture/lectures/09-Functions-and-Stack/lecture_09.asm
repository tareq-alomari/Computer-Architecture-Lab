# ============================================================
# المحاضرة التاسعة: الدوال والمكدس — jal, jr, $sp, $ra
# ============================================================
#
# ----------------------------------
# الأوامر الجديدة:
#   jal label   →  استدعِ الدالة + احفظ $ra   (C++: result = func();)
#   jr $ra      →  ارجع من الدالة              (C++: return;)
#   $ra         →  عنوان الرجوع
#   $sp         →  مؤشر المكدس
#   $a0-$a3     →  معاملات الدالة
#   $v0         →  قيمة إرجاع الدالة
# ----------------------------------

.data
    msg_add: .asciiz "5 + 3 = "
    msg_fact: .asciiz "5! = "
    newline: .asciiz "\n"

.text
main:
    # ========================================
    # مثال J: دالة add — اجمع رقمين
    # C++:
    #   int add(int a, int b) { return a + b; }
    #   int main() { int r = add(5, 3); cout << r; }
    # ========================================
    la $a0, msg_add
    li $v0, 4
    syscall

    li $a0, 5                    # $a0 = 5  (المعامل الأول)
    li $a1, 3                    # $a1 = 3  (المعامل الثاني)
    jal add_func                 # استدعِ add  ← يحفظ $ra ويقفز

    move $a0, $v0                # $v0 = النتيجة (8)
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # ========================================
    # مثال K: دالة factorial — 5!
    # C++:
    #   int factorial(int n) {
    #       if (n <= 1) return 1;
    #       return n * factorial(n - 1);
    #   }
    # ========================================
    la $a0, msg_fact
    li $v0, 4
    syscall

    li $a0, 5                    # $a0 = 5
    jal factorial                # استدعِ factorial

    move $a0, $v0                # اطبع النتيجة
    li $v0, 1
    syscall

    li $v0, 10
    syscall

# ========================================
# الدالة add_func: $v0 = $a0 + $a1
# ========================================
add_func:
    add $v0, $a0, $a1           # $v0 = $a0 + $a1   (C++: return a + b;)
    jr $ra                      # ارجع إلى main

# ========================================
# الدالة factorial: $v0 = $a0!
# تحتاج مكدس لأنها تستدعي نفسها (recursion)
# ========================================
factorial:
    # --- احفظ $ra و $a0 في المكدس ---
    addi $sp, $sp, -8            # احجز 8 بايت
    sw $ra, 0($sp)               # احفظ $ra  (لأن jal داخلي سيغيره)
    sw $a0, 4($sp)               # احفظ $a0

    li $t0, 1
    ble $a0, $t0, base_case      # إذا n <= 1 → base case

    addi $a0, $a0, -1            # n = n - 1
    jal factorial                # factorial(n-1)
    lw $a0, 4($sp)               # استرجع $a0 (n الأصلي)
    mul $v0, $a0, $v0            # n * factorial(n-1)
    b return_fact

base_case:
    li $v0, 1                    # return 1

return_fact:
    lw $ra, 0($sp)               # استرجع $ra
    addi $sp, $sp, 8             # حرّر المكدس
    jr $ra                       # ارجع
