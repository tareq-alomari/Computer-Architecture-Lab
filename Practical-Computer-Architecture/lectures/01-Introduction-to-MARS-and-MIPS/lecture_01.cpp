// ============================================================
// المقابل في C++ للمحاضرة الأولى: اطبع "Hello World!"
// MIPS: lecture_01.asm
// ============================================================

#include <iostream>
using namespace std;

int main() {
    // ---------- اطبع النص ----------
    // MIPS: la $a0, msg
    //       li $v0, 4
    //       syscall
    cout << "Hello World!\n";

    // ---------- اخروج ----------
    // MIPS: li $v0, 10
    //       syscall
    return 0;
}
