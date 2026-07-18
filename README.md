<div align="center">
  <img src="الشعار/images.jpeg" alt="Ibb University Logo" width="120" />
  <br><br>
  <h1 dir="rtl">معمارية الحاسوب - عملي</h1>
  <p dir="rtl"><strong>Computer Architecture Lab — CS 221</strong></p>
  <p dir="rtl"><strong>جامعة إب — كلية الحاسابات والعلوم التطبيقية</strong></p>
  <p dir="rtl">Ibb University — College of Computing and Applied Sciences</p>

  [![License](https://img.shields.io/badge/license-Educational-blue)](#)
  [![Students](https://img.shields.io/badge/for-Students-success)](#)
  [![MIPS](https://img.shields.io/badge/architecture-MIPS-brightgreen)](#)
  [![MARS](https://img.shields.io/badge/simulator-MARS_4.5-orange)](#)
  [![Language](https://img.shields.io/badge/language-Arabic_%7C_English-lightgrey)](#)

  <hr style="border: 2px solid #15803D; width: 80%;">
</div>

---

## 📋 جدول المحتويات

- [عن المقرر](#عن-المقرر)
- [المحاضرات](#المحاضرات)
- [هيكل المجلدات](#هيكل-المجلدات)
- [متطلبات المقرر](#متطلبات-المقرر)
- [كيفية الاستخدام](#كيفية-الاستخدام)
- [الأدوات والتقنيات](#الأدوات-والتقنيات)
- [الهوية البصرية](#الهوية-البصرية)
- [المؤلف](#المؤلف)

---

## 🎓 للطلاب — كيفية الوصول إلى المحتوى

<div dir="rtl">

هذا المستودع يحتوي على جميع مواد مقرر **معمارية الحاسوب - عملي**. يمكنك الوصول إلى المحتوى بالطرق التالية:

### 📥 تحميل المستودع كاملًا

```bash
# تحميل المستودع
git clone https://github.com/tareq-alomari/Computer-Architecture-Lab.git

# أو تحميل ZIP
# افتح الرابط: https://github.com/tareq-alomari/Computer-Architecture-Lab
# اضغط على زر Code ← Download ZIP
```

### 📂 محتوى كل محاضرة

| الملف | الوصف |
|:---:|---|
| `خطة المحاضرة` | الأهداف والمدة الزمنية والأنشطة |
| `تحليل المحاضرة` | شرح تفصيلي للمحتوى |
| `ورقة عمل` | تمارين وأنشطة عملية للحل |
| `lecture_XX.asm` | أكواد MIPS قابلة للتشغيل في MARS |
| `*.pptx` | شرائح العرض التقديمي |

### 💡 نصائح للدراسة

1. اقرأ **خطة المحاضرة** أولاً لتعرف الأهداف
2. ادرس **تحليل المحاضرة** للمحتوى النظري
3. حمّل **MARS** وجرّب الأكواد بنفسك
4. حل **ورقة العمل** لتثبيت المعلومات
5. استخدم **دليل MIPS الشامل** كمرجع سريع

</div>

---  

## 🎯 عن المقرر

<div dir="rtl">

يهدف هذا المقرر إلى تعليم طلاب كلية الحاسابات والعلوم التطبيقية في **جامعة إب** أساسيات لغة التجميع **MIPS Assembly** باستخدام بيئة المحاكاة **MARS**. يغطي المقرر 10 محاضرات عملية تمتد من المفاهيم الأساسية إلى الموضوعات المتقدمة مثل الدوال والمكدس.

</div>

---

## 📚 المحاضرات

| # | عنوان المحاضرة | الموضوعات الرئيسية |
|:---:|---|---|
| 01 | **مقدمة إلى MARS وأساسيات MIPS** | بيئة العمل، هيكل البرنامج، المسجلات، استدعاءات النظام |
| 02 | **العمليات الحسابية الأساسية** | `add`, `sub`, `addi`, `mul`, `div` |
| 03 | **العمليات المنطقية وإزاحة البتات** | `and`, `or`, `nor`, `sll`, `srl` |
| 04 | **الجمل الشرطية** | `beq`, `bne`, `slt`, `if-else` |
| 05 | **حلقات التكرار** | `for`, `while` بلغة التجميع |
| 06 | **التعامل مع الذاكرة** | `lw`, `sw`, عنونة الذاكرة |
| 07 | **المصفوفات** | تعريف، تصفح، معالجة مصفوفات |
| 08 | **السلاسل النصية** | معالجة النصوص، مقارنة، نسخ |
| 09 | **الدوال والمكدس** | `jal`, `jr`, `$ra`, `$sp` |
| 10 | **مناقشة وتقييم المشروع النهائي** | مراجعة وتقييم |

---

## 📁 هيكل المشروع

```
Computer-Architecture-Lab/
│
├── الشعار/                                  # شعار جامعة إب
│   └── images.jpeg
│
├── توصيف مقرر معمارية الحاسوب - عملي.docx   # توصيف المقرر المعتمد
│
└── محاضرات معمارية الحاسوب - عملي/           # المحتوى التعليمي
    │
    ├── المحاضرات/                           # 10 محاضرات دراسية
    │   ├── 01-مقدمة-إلى-MARS-وMIPS/
    │   │   ├── 📄 خطة المحاضرة 1.md          # خطة تدريسية مفصلة
    │   │   ├── 📄 خطة المحاضرة 1.pdf
    │   │   ├── 📄 تحليل المحاضرة 1.md        # تحليل المحتوى التعليمي
    │   │   ├── 📄 تحليل المحاضرة 1.pdf
    │   │   ├── 📄 ورقة عمل المحاضرة 1.md     # تمارين وأنشطة
    │   │   ├── 💻 lecture_01.asm             # أمثلة عملية MIPS
    │   │   └── 📊 *.pptx                     # عروض تقديمية
    │   │
    │   ├── 02-العمليات-الحسابية-الأساسية/
    │   ├── 03-العمليات-المنطقية-وإزاحة-البتات/
    │   ├── 04-الجمل-الشرطية/
    │   ├── 05-حلقات-التكرار/
    │   ├── 06-التعامل-مع-الذاكرة/
    │   ├── 07-المصفوفات/
    │   ├── 08-السلاسل-النصية/
    │   ├── 09-الدوال-والمكدس/
    │   └── 10-مناقشة-وتقييم-المشروع-النهائي/
    │
    └── أدوات/                               # أدوات مساعدة
        ├── convert_to_pdf.py                # سكربت تحويل MD → PDF
        ├── style.css                        # هوية جامعة إب البصرية
        └── 📖 دليل MIPS الشامل.md            # شرح جميع أوامر MIPS
```

### مكونات كل محاضرة

| المكون | الوصف | الصيغة |
|:---:|---|---|
| **📄 الخطة** | أهداف، مدة زمنية، أنشطة، تقييم | `.md` + `.pdf` |
| **📄 التحليل** | تحليل المحتوى والجمهور المستهدف | `.md` + `.pdf` |
| **📄 ورقة عمل** | أسئلة نظرية، تمارين عملية، تحديات | `.md` |
| **💻 كود MIPS** | أمثلة عملية قابلة للتشغيل | `.asm` |
| **📊 العرض** | شرائح عرض تقديمية (متوفرة للمحاضرة 1) | `.pptx` |

---

## 💻 متطلبات المقرر

<div dir="rtl">

| المتطلب | الوصف |
|:---|---|
| **Java Runtime** | الإصدار 8 أو أحدث |
| **MARS Simulator** | الإصدار 4.5 (أو الأحدث) |
| **المعرفة المسبقة** | أساسيات أنظمة الحاسوب، أنظمة العد (ثنائي، عشري، سداسي عشري) |

</div>

### تحميل MARS

```bash
# تحميل MARS من الموقع الرسمي
https://courses.missouristate.edu/kenvollmar/mars/

# تشغيل MARS
java -jar Mars.jar
```

---

## 🚀 كيفية الاستخدام

### تشغيل أكواد MIPS

```bash
1. افتح MARS
2. File → Open → اختر ملف .asm
3. F3 → تجميع (Assemble)
4. F5 → تشغيل (Run)
5. F7 → تنفيذ خطوة بخطوة (Step)
```

### تحويل الخطط إلى PDF

```bash
python3 "محاضرات معمارية الحاسوب - عملي/أدوات/convert_to_pdf.py"
```

### توليد عروض PowerPoint

```bash
python3 /tmp/create_clean.py
```

---

## 🛠️ الأدوات والتقنيات

| الأداة | الغرض |
|:---:|---|
| <img src="https://img.shields.io/badge/MARS-MIPS%20Simulator-orange" height="24"> | محاكاة وتجميع وتنفيذ كود MIPS |
| <img src="https://img.shields.io/badge/Python-3.12-blue" height="24"> | توليد العروض والملفات |
| <img src="https://img.shields.io/badge/python--pptx-1.0.2-green" height="24"> | إنشاء عروض PowerPoint |
| <img src="https://img.shields.io/badge/fpdf2-2.8-green" height="24"> | تحويل MD إلى PDF |
| <img src="https://img.shields.io/badge/pandoc-3.1-yellow" height="24"> | تحويل المستندات |

---

## 🎨 الهوية البصرية — دليل العلامة التجارية

<div dir="rtl" align="center">
تم تصميم الهوية البصرية لهذا المقرر لتتماشى مع العلامة التجارية لجامعة إب، وتعكس الاحترافية والجودة التعليمية.
</div>

### الألوان الأساسية

<table>
<tr>
  <th align="center" width="120">العيّنة</th>
  <th align="center" width="160">الاسم</th>
  <th align="center" width="120">HEX</th>
  <th align="center">الاستخدام</th>
</tr>
<tr>
  <td align="center" bgcolor="#0C4A2D" style="border-radius: 8px;"></td>
  <td align="center"><strong>الأخضر الملكي</strong><br><span style="color: #666; font-size: 0.8em;">Royal Green</span></td>
  <td align="center"><code>#0C4A2D</code></td>
  <td align="right">العناوين الرئيسية، الخلفيات الداكنة، التذييل</td>
</tr>
<tr>
  <td align="center" bgcolor="#15803D"></td>
  <td align="center"><strong>الأخضر الزمردي</strong><br><span style="color: #666; font-size: 0.8em;">Emerald</span></td>
  <td align="center"><code>#15803D</code></td>
  <td align="right">الأزرار، الأيقونات، العناصر التفاعلية</td>
</tr>
<tr>
  <td align="center" bgcolor="#0EA5E9"></td>
  <td align="center"><strong>الأزرق السماوي</strong><br><span style="color: #666; font-size: 0.8em;">Sky Blue</span></td>
  <td align="center"><code>#0EA5E9</code></td>
  <td align="right">الروابط، التمييز، العناصر الثانوية</td>
</tr>
<tr>
  <td align="center" bgcolor="#C79100"></td>
  <td align="center"><strong>الذهبي الفخم</strong><br><span style="color: #666; font-size: 0.8em;">Gold</span></td>
  <td align="center"><code>#C79100</code></td>
  <td align="right">التأكيد، الدرجات، الشارات الخاصة</td>
</tr>
<tr>
  <td align="center" bgcolor="#1A1A2E"></td>
  <td align="center"><strong>الكحلي العميق</strong><br><span style="color: #666; font-size: 0.8em;">Deep Navy</span></td>
  <td align="center"><code>#1A1A2E</code></td>
  <td align="right">النصوص الأساسية، الخطوط العريضة</td>
</tr>
<tr>
  <td align="center" bgcolor="#F8F9FA"></td>
  <td align="center"><strong>الخلفية الفاتحة</strong><br><span style="color: #666; font-size: 0.8em;">Light Background</span></td>
  <td align="center"><code>#F8F9FA</code></td>
  <td align="right">خلفيات الصفحات، البطاقات، الحواف</td>
</tr>
</table>

### الألوان المساعدة

<table>
<tr>
  <th align="center" width="120">العيّنة</th>
  <th align="center" width="160">الاسم</th>
  <th align="center" width="120">HEX</th>
  <th align="center">الاستخدام</th>
</tr>
<tr>
  <td align="center" bgcolor="#DC2626"></td>
  <td align="center"><strong>الأحمر</strong></td>
  <td align="center"><code>#DC2626</code></td>
  <td align="right">أخطاء، تنبيهات، رسائل مهمة</td>
</tr>
<tr>
  <td align="center" bgcolor="#059669"></td>
  <td align="center"><strong>الأخضر الناصع</strong></td>
  <td align="center"><code>#059669</code></td>
  <td align="right">نجاح، اكتمال، تأكيد</td>
</tr>
<tr>
  <td align="center" bgcolor="#D97706"></td>
  <td align="center"><strong>البرتقالي</strong></td>
  <td align="center"><code>#D97706</code></td>
  <td align="right">تحذير، تنبيه متوسط</td>
</tr>
<tr>
  <td align="center" bgcolor="#6B7280"></td>
  <td align="center"><strong>الرمادي</strong></td>
  <td align="center"><code>#6B7280</code></td>
  <td align="right">نصوص ثانوية، توجيهات</td>
</tr>
</table>

### قواعد الاستخدام

<div dir="rtl">

1. **الأخضر الملكي** (`#0C4A2D`) — اللون الأساسي للعلامة التجارية، يُستخدم في الشعار والعناوين الرئيسية.
2. **الأخضر الزمردي** (`#15803D`) — لون التفاعل، يُستخدم للأزرار والعناصر القابلة للنقر.
3. **الأزرق السماوي** (`#0EA5E9`) — لون الروابط والتمييز، يضيف حيوية للتصميم.
4. **الذهبي الفخم** (`#C79100`) — لون التميز والدرجات العليا، يُستخدم باعتدال للفت الانتباه.
5. يجب أن تكون التباينات واضحة لضمان سهولة القراءة (نسبة تباين ≥ 4.5:1).

</div>

---

### تطبيقات الألوان

| العنصر | اللون الأساسي | اللون الثانوي |
|:---|:---:|:---:|
| العناوين | <code>#0C4A2D</code> | <code>#15803D</code> |
| النصوص | <code>#1A1A2E</code> | <code>#4B5563</code> |
| الأزرار | <code>#15803D</code> | <code>#0C4A2D</code> |
| الروابط | <code>#0EA5E9</code> | <code>#0284C7</code> |
| الخلفيات | <code>#FFFFFF</code> | <code>#F8F9FA</code> |
| الحدود | <code>#E5E7EB</code> | <code>#D1D5DB</code> |
| التنبيه (نجاح) | <code>#059669</code> | <code>#D1FAE5</code> |
| التنبيه (خطأ) | <code>#DC2626</code> | <code>#FEE2E2</code> |

---

## 👤 المؤلف

<div dir="rtl">

**طارق العمري** — Tareq Al-Omari  
قسم علوم الحاسوب — كلية الحاسابات والعلوم التطبيقية  
جامعة إب — الجمهورية اليمنية

</div>

---

<div align="center">
  <img src="الشعار/images.jpeg" alt="Ibb University Logo" width="80" />
  <br>
  <strong>جامعة إب — كلية الحاسابات والعلوم التطبيقية</strong>
  <br>
  Ibb University — College of Computing and Applied Sciences
  <br><br>
  <sub>© 2024-2025 — جميع الحقوق محفوظة</sub>
</div>
