// ============================================================
// المقابل في C++ للمحاضرة الثانية: العمليات الحسابية
// MIPS: lecture_02.asm
// ============================================================

#include <iostream>
using namespace std;

int main() {
    int a = 10;      // MIPS: li $t0, 10
    int b = 3;       // MIPS: li $t1, 3

    // ---------- a + b (جمع) ----------
    // MIPS: add $t2, $t0, $t1
    int t2 = a + b;
    cout << "a + b = " << t2 << endl;

    // ---------- a - b (طرح) ----------
    // MIPS: sub $t3, $t0, $t1
    int t3 = a - b;
    cout << "a - b = " << t3 << endl;

    // ---------- a * b (ضرب) ----------
    // MIPS: mul $t4, $t0, $t1
    int t4 = a * b;
    cout << "a * b = " << t4 << endl;

    // ---------- a / b (قسمة) ----------
    // MIPS: div $t0, $t1
    //       mflo $t5
    int t5 = a / b;   // ناتج القسمة (LO)
    cout << "a / b = " << t5 << endl;

    // ---------- a % b (باقي القسمة) ----------
    // MIPS: mfhi $t6
    int t6 = a % b;   // باقي القسمة (HI)
    cout << "a % b = " << t6 << endl;

    return 0;
}
