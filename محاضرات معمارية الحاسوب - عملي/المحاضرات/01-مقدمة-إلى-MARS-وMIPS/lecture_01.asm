# ============================================================
# المحاضرة الأولى: مقدمة إلى MARS وأساسيات MIPS
# Lecture 1: Introduction to MARS and MIPS Basics
# ============================================================
# يوضح هذا المثال كيفية طباعة Hello World وطباعة معلومات الطالب
# Demonstrates printing Hello World and student information
# ============================================================

.data
    # رسالة الترحيب
    hello_msg:  .asciiz "\n=== Hello World! ===\n"
    
    # معلومات الطالب
    name_msg:   .asciiz "Student Name: Ahmed Mohammed\n"
    id_msg:     .asciiz "Student ID: 20241234\n"
    major_msg:  .asciiz "Major: Computer Science\n"
    uni_msg:    .asciiz "University: Example University\n"
    
    # رسالة نهاية البرنامج
    end_msg:    .asciiz "\nProgram executed successfully!\n"
    
    # رسالة إضافية للتنسيق
    line:       .asciiz "------------------------\n"

.text
.globl main

main:
    # ===== طباعة Hello World =====
    la $a0, hello_msg      # تحميل عنوان الرسالة
    li $v0, 4              # syscall للطباعة (print_string)
    syscall
    
    # ===== طباعة خط فاصل =====
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== طباعة اسم الطالب =====
    la $a0, name_msg
    li $v0, 4
    syscall
    
    # ===== طباعة رقم الطالب =====
    la $a0, id_msg
    li $v0, 4
    syscall
    
    # ===== طباعة التخصص =====
    la $a0, major_msg
    li $v0, 4
    syscall
    
    # ===== طباعة الجامعة =====
    la $a0, uni_msg
    li $v0, 4
    syscall
    
    # ===== طباعة خط فاصل =====
    la $a0, line
    li $v0, 4
    syscall
    
    # ===== طباعة رسالة نجاح التنفيذ =====
    la $a0, end_msg
    li $v0, 4
    syscall

    # ===== إنهاء البرنامج =====
    li $v0, 10             # syscall للخروج (exit)
    syscall

# ============================================================
# ملخص التعليمات المستخدمة:
# .asciiz  - تعريف سلسلة نصية منتهية بـ null
# la       - تحميل عنوان (Load Address)
# li       - تحميل قيمة فورية (Load Immediate)
# syscall  - استدعاء نظام لتنفيذ عملية
# $v0      - تسجيل يحتوي على رقم syscall
# $a0      - تسجيل وسيط للطباعة
# ============================================================
