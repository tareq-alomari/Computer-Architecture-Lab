// ============================================================
// المقابل في C++ لمثال: اقرأ رقماً واطبعه
// MIPS: mips001.asm
// ============================================================

#include <iostream>
using namespace std;

int main() {
    // ---------- ارفع "Enter a number: " ----------
    // MIPS: la $a0, prompt
    //       li $v0, 4
    //       syscall
    cout << "Enter a number: ";

    // ---------- اقرأ رقماً من المستخدم ----------
    // MIPS: li $v0, 5
    //       syscall
    //       move $t0, $v0
    int t0;
    cin >> t0;

    // ---------- اطبع "You entered: " ----------
    // MIPS: la $a0, out_msg
    //       li $v0, 4
    //       syscall
    cout << "You entered: ";

    // ---------- اطبع الرقم ----------
    // MIPS: move $a0, $t0
    //       li $v0, 1
    //       syscall
    cout << t0 << endl;

    return 0;
}
