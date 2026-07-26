// ============================================================
// المقابل في C++ للمحاضرة السادسة: التعامل مع الذاكرة
// MIPS: lecture_06.asm  (lw / sw / la)
// ============================================================

#include <iostream>
using namespace std;

int main() {
    // .data section (متغيرات في RAM)
    int x = 42;                 // MIPS: x: .word 42
    int y = 0;                  // MIPS: y: .word 0

    // --- lw — اقرأ من RAM ---
    // MIPS: lw $t0, x
    int t0 = x;                 // $t0 = قيمة x
    cout << "x = " << t0 << endl;

    // --- sw — اكتب إلى RAM ---
    // MIPS: li $t1, 99
    //       sw $t1, y
    int t1 = 99;
    y = t1;                     // y = 99
    int t2 = y;                 // اقرأ y للتحقق  (lw $t2, y)
    cout << "y = " << t2 << endl;

    // --- la مقابل lw — عنوان vs قيمة ---
    // MIPS: la $t3, x  → $t3 = &x  (العنوان)
    //       lw $t0, x  → $t0 =  x  (القيمة)
    int* t3 = &x;               // la = عنوان x
    cout << "Address of x = 0x" << hex << (unsigned long)t3 << endl;

    return 0;
}
