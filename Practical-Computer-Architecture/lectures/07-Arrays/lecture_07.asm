# ============================================================
# المحاضرة السابعة: المصفوفات — الوصول إلى arr[i]
# ============================================================
#
# ----------------------------------
# الأوامر الجديدة:
#   .space n          → احجز n بايت في RAM (مصفوفة)
#   sll $t, $s, 2     → $t = $s × 4   (للوصول إلى arr[i])
#   sw $v, offset($b) → اكتب في RAM عند ($b + offset)
#   lw $v, offset($b) → اقرأ من RAM عند ($b + offset)
#   $s0-$s7           → مسجلات محفوظة (تضمن بقاءها)
# ----------------------------------

.data
    arr:    .space 20            # 20 بايت = 5 أعداد × 4 بايت  (C++: int arr[5];)
    prompt: .asciiz "Enter number: "
    sum_msg: .asciiz "Sum = "
    newline: .asciiz "\n"

.text
main:
    # ========================================
    # مثال H + I: مصفوفة — اقرأ 5 أرقام واحسب مجموعها
    # C++:
    #   int arr[5], sum = 0;
    #   for (int i = 0; i < 5; i++) {
    #       cin >> arr[i];
    #       sum += arr[i];
    #   }
    # ========================================

    la $s0, arr                  # $s0 = عنوان أول عنصر  (C++: int* s0 = arr;)
    li $t0, 0                    # $t0 = i (عداد)
    li $t2, 0                    # $t2 = sum (المجموع)

    # --- حلقة الإدخال ---
input_loop:
    bge $t0, 5, sum_done         # إذا i >= 5 → خلصنا

    la $a0, prompt               # اطبع "Enter number: "
    li $v0, 4
    syscall
    li $v0, 5                    # اقرأ رقماً
    syscall                      # $v0 = الرقم المدخل

    # --- خزّن الرقم في المصفوفة: arr[i] = v0 ---
    # arr[i] = base + (i × 4)
    sll $t1, $t0, 2              # $t1 = i × 4          (C++: offset = i * 4;)
    add $t1, $s0, $t1            # $t1 = &arr[0] + offset  (C++: addr = arr + i;)
    sw $v0, 0($t1)               # arr[i] = v0          (C++: arr[i] = value;)

    add $t2, $t2, $v0            # sum += v0
    addi $t0, $t0, 1             # i++
    b input_loop                 # كرّر

sum_done:
    # --- اطبع المجموع ---
    la $a0, sum_msg
    li $v0, 4
    syscall
    move $a0, $t2
    li $v0, 1
    syscall

    li $v0, 10
    syscall
