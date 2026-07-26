// ============================================================
// المقابل في C++ للمحاضرة الرابعة: الجمل الشرطية (if/else)
// MIPS: lecture_04.asm
// ============================================================

#include <iostream>
using namespace std;

int main() {
    // ---------- اقرأ رقماً ----------
    // MIPS: li $v0, 5   /  syscall  /  move $t0, $v0
    int x;
    cout << "Enter a number: ";
    cin >> x;

    // ---------- هل الرقم زوجي أم فردي؟ ----------
    // MIPS: andi $t1, $t0, 1  /  beqz $t1, print_even
    if ((x & 1) == 0) {
        cout << "Even\n";       // MIPS: print_even
    } else {
        cout << "Odd\n";        // MIPS: odd
    }

    // ---------- هل الرقم موجب أم سالب أم صفر؟ ----------
    // MIPS: bgt $t0, $zero, print_pos
    //       blt $t0, $zero, print_neg
    if (x > 0) {
        cout << "Positive\n";   // MIPS: print_pos
    } else if (x < 0) {
        cout << "Negative\n";   // MIPS: print_neg
    } else {
        cout << "Zero\n";       // MIPS: zero
    }

    return 0;
}
