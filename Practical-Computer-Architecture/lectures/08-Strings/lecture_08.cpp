// ============================================================
// المقابل في C++ للمحاضرة الثامنة: السلاسل النصية
// MIPS: lecture_08.asm  (.asciiz / lb / sb / beqz)
// ============================================================

#include <iostream>
using namespace std;

int main() {
    char str[] = "hello";       // MIPS: str: .asciiz "hello"

    // ========================================
    // مثال L: strlen — احسب طول النص
    // MIPS: lb / beqz / addi
    // ========================================
    int len = 0;                // MIPS: li $t1, 0
    while (str[len] != '\0') {  // MIPS: lb $t2, 0($t0)  /  beqz $t2, done_len
        len++;                  // MIPS: addi $t1, $t1, 1
    }
    cout << "Length = " << len << endl;

    // ========================================
    // مثال: تحويل الأحرف الصغيرة → كبيرة
    // MIPS: lb / blt / bgt / addi -32 / sb
    // (char)('a' - 'A') = 32
    // ========================================
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] -= 32;       // MIPS: addi $t2, $t2, -32  /  sb
        }
    }
    cout << "Uppercase: " << str << endl;

    return 0;
}
