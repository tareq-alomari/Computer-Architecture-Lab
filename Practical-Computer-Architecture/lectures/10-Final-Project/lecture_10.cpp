// ============================================================
// المقابل في C++ للمحاضرة العاشرة: نظام درجات الطلاب
// MIPS: lecture_10.asm
// ============================================================

#include <iostream>
using namespace std;

int main() {
    int grades[50];             // MIPS: grades: .space 200
    int n = 0;                  // MIPS: n: .word 0
    int sum = 0;                // MIPS: sum: .word 0

    while (true) {
        // ========================================
        // القائمة — اختر من 1 إلى 4
        // MIPS: menu:  la / li / syscall / beq
        // ========================================
        int choice;
        cout << "\n1. Enter grades\n2. Display grades\n";
        cout << "3. Show average\n4. Exit\nChoice: ";
        cin >> choice;

        // ========================================
        // Option 1: إدخال الدرجات
        // MIPS: option1:  sw / la / sll / add / sw
        // ========================================
        if (choice == 1) {
            cout << "Number of students: ";
            cin >> n;
            sum = 0;
            for (int i = 0; i < n; i++) {
                cout << "Grade: ";
                cin >> grades[i];
                sum += grades[i];
            }
        }

        // ========================================
        // Option 2: عرض الدرجات
        // MIPS: option2:  sll / add / lw
        // ========================================
        else if (choice == 2) {
            cout << "\n--- Grades ---\n";
            for (int i = 0; i < n; i++) {
                cout << "Student " << i + 1 << ": " << grades[i] << endl;
            }
        }

        // ========================================
        // Option 3: المتوسط (sum / n)
        // MIPS: option3:  div / mflo
        // ========================================
        else if (choice == 3) {
            int average = sum / n;      // قسمة صحيحة
            cout << "Average = " << average << endl;
        }

        // ========================================
        // Option 4: خروج
        // MIPS: exit:  syscall 10
        // ========================================
        else if (choice == 4) {
            cout << "Goodbye!\n";
            break;
        }

        else {
            cout << "Invalid!\n";
        }
    }

    return 0;
}
