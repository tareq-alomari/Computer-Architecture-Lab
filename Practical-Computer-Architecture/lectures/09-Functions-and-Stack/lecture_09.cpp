// ============================================================
// المقابل في C++ للمحاضرة التاسعة: الدوال والمكدس
// MIPS: lecture_09.asm  (jal / jr / $sp / $ra)
// ============================================================

#include <iostream>
using namespace std;

// ========================================
// مثال J: دالة add — اجمع رقمين
// MIPS: add_func:  add $v0, $a0, $a1  /  jr $ra
// ========================================
int add_func(int a, int b) {    // MIPS: $a0 = a, $a1 = b
    return a + b;               // MIPS: $v0 = $a0 + $a1
}

// ========================================
// مثال K: دالة factorial — 5!
// MIPS: factorial:  addi $sp / sw / jal / mul / jr
// ========================================
int factorial(int n) {
    if (n <= 1) return 1;       // MIPS: ble $a0, $t0, base_case
    return n * factorial(n - 1);// MIPS: jal factorial  /  mul
}

int main() {
    // --- مثال J ---
    // MIPS: li $a0, 5  /  li $a1, 3  /  jal add_func
    int result = add_func(5, 3);
    cout << "5 + 3 = " << result << endl;

    // --- مثال K ---
    // MIPS: li $a0, 5  /  jal factorial
    int fact = factorial(5);
    cout << "5! = " << fact << endl;

    return 0;
}
