# ============================================================
# المحاضرة الخامسة: حلقات التكرار — for و while
# ============================================================
#
# ----------------------------------
# الأوامر الجديدة:
#   addi $t, $s, n   →  $t = $s + n   (جمع مع رقم ثابت)
# ----------------------------------

.data
    space:   .asciiz " "          # مسافة للفصل بين الأعداد
    newline: .asciiz "\n"
    prompt:  .asciiz "Enter N: "
    sum_msg: .asciiz "Sum = "

.text
main:
    # ========================================
    # مثال F: for loop — اطبع 1 2 3 4 5 6 7 8 9 10
    # C++: for (int i = 1; i <= 10; i++) cout << i << " ";
    # ========================================
    li $t0, 1                    # $t0 = 1   (العداد i)

print_loop:
    bgt $t0, 10, done_print      # إذا i > 10 → اخرج من الحلقة

    move $a0, $t0                # اطبع i
    li $v0, 1
    syscall
    la $a0, space                # اطبع مسافة " "
    li $v0, 4
    syscall

    addi $t0, $t0, 1             # $t0++  (C++: i++;)
    b print_loop                 # ارجع إلى بداية الحلقة

done_print:
    la $a0, newline
    li $v0, 4
    syscall

    # ========================================
    # مثال G: while loop — مجموع 1+2+3+...+N
    # C++:
    #   int N; cin >> N;
    #   int sum = 0, i = 1;
    #   while (i <= N) { sum += i; i++; }
    #   cout << sum;
    # ========================================

    # --- اقرأ N من المستخدم ---
    la $a0, prompt
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t1, $v0                # $t1 = N

    # --- جهّز الحلقة ---
    li $t2, 1                    # $t2 = i (عداد)
    li $t3, 0                    # $t3 = sum (المجموع)

sum_loop:
    bgt $t2, $t1, done_sum       # إذا i > N → اخرج

    add $t3, $t3, $t2            # sum = sum + i   (C++: sum += i;)
    addi $t2, $t2, 1             # i++

    b sum_loop                   # كرّر

done_sum:
    la $a0, sum_msg
    li $v0, 4
    syscall
    move $a0, $t3
    li $v0, 1
    syscall

    li $v0, 10
    syscall
