// ============================================================
// المقابل في C++ للمحاضرة السابعة: المصفوفات
// MIPS: lecture_07.asm  (.space / sll / add / sw / lw)
// ============================================================

#include <iostream>
using namespace std;

int main() {
    int arr[5];                 // MIPS: arr: .space 20
    int sum = 0;                // MIPS: li $t2, 0

    // --- حلقة الإدخال ---
    // MIPS: input_loop
    //       sll $t1, $t0, 2   → offset = i × 4
    //       add $t1, $s0, $t1 → addr = &arr[0] + offset
    //       sw $v0, 0($t1)    → arr[i] = value
    for (int i = 0; i < 5; i++) {
        cout << "Enter number: ";
        cin >> arr[i];          // MIPS: li $v0, 5  /  syscall  /  sw
        sum += arr[i];
    }

    // --- اطبع المجموع ---
    cout << "Sum = " << sum << endl;

    return 0;
}
