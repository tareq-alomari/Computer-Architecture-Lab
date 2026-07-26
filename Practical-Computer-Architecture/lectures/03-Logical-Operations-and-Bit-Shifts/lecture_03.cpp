// ============================================================
// المقابل في C++ للمحاضرة الثالثة: العمليات المنطقية والإزاحة
// MIPS: lecture_03.asm
// ============================================================

#include <iostream>
using namespace std;

int main() {
    unsigned int a = 0x12345678;   // MIPS: li $t0, 0x12345678

    // ---------- a & 0xFF (AND) ----------
    // MIPS: andi $t1, $t0, 0xFF
    unsigned int t1 = a & 0xFF;
    cout << "a & 0xFF = 0x" << hex << t1 << endl;

    // ---------- a | 0xFF (OR) ----------
    // MIPS: ori $t2, $t0, 0xFF
    unsigned int t2 = a | 0xFF;
    cout << "a | 0xFF = 0x" << hex << t2 << endl;

    // ---------- a ^ 0xFF (XOR) ----------
    // MIPS: xori $t3, $t0, 0xFF
    unsigned int t3 = a ^ 0xFF;
    cout << "a ^ 0xFF = 0x" << hex << t3 << endl;

    // ---------- a << 8 (إزاحة يسار ×256) ----------
    // MIPS: sll $t4, $t0, 8
    unsigned int t4 = a << 8;
    cout << "a << 8   = 0x" << hex << t4 << endl;

    // ---------- a >> 8 (إزاحة يمين ÷256) ----------
    // MIPS: srl $t5, $t0, 8
    unsigned int t5 = a >> 8;
    cout << "a >> 8   = 0x" << hex << t5 << endl;

    return 0;
}
