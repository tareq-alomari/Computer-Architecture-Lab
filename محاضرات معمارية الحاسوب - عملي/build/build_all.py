# -*- coding: utf-8 -*-
"""بناء عروض المحاضرات العملية — معمارية الحاسوب"""
import os, sys, importlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from lab_deck import build_lecture

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))   # مجلد "محاضرات معمارية الحاسوب - عملي"
LECTURES_DIR = os.path.join(ROOT, "المحاضرات")

LECTURES = [
    ("content_lecture_01", "01-مقدمة-إلى-MARS-وMIPS", "01"),
    ("content_lecture_02", "02-العمليات-الحسابية-الأساسية", "02"),
    ("content_lecture_03", "03-العمليات-المنطقية-وإزاحة-البتات", "03"),
    ("content_lecture_04", "04-الجمل-الشرطية", "04"),
    ("content_lecture_05", "05-حلقات-التكرار", "05"),
    ("content_lecture_06", "06-التعامل-مع-الذاكرة", "06"),
    ("content_lecture_07", "07-المصفوفات", "07"),
    ("content_lecture_08", "08-السلاسل-النصية", "08"),
    ("content_lecture_09", "09-الدوال-والمكدس", "09"),
    ("content_lecture_10", "10-مناقشة-وتقييم-المشروع-النهائي", "10"),
]

def main():
    only = sys.argv[1] if len(sys.argv) > 1 else None
    for mod_name, folder, num in LECTURES:
        if only and num != only:
            continue
        mod = importlib.import_module(mod_name)
        cfg = mod.CONTENT
        out = os.path.join(LECTURES_DIR, folder, f"عرض المحاضرة {num} - {cfg['title']}.pptx")
        build_lecture(cfg, out)
    print("ALL DONE")

if __name__ == "__main__":
    main()
