# دليل الهوية البصرية
## Brand Style Guide — Ibb University

<div dir="rtl" align="center">
  <strong>جامعة إب — كلية الحاسابات والعلوم التطبيقية</strong>
  <br>
  <strong>Computer Architecture Lab — CS 221</strong>
</div>

---

## 1. شعار الجامعة

<div align="center">
  <img src="الشعار/images.jpeg" alt="Ibb University Logo" width="120">
  <br>
  <em>شعار جامعة إب — Ibb University Shield Logo</em>
</div>

| العنصر | المواصفة |
|:---|---|
| **الموقع** | أعلى يسار الشريحة (RTL) |
| **الحجم الافتراضي** | 60×60 بكسل |
| **الحجم الكبير** | 120×120 بكسل (الشريحة الرئيسية) |
| **التباعد** | 0.3 بوصة من الحافة العلوية، 0.3 بوصة من الحافة اليمنى |
| **الخلفية** | يستخدم على الخلفيات الفاتحة والداكنة |

---

## 2. لوحة الألوان

### الألوان الأساسية

| العيّنة | الاسم | HEX | RGB | الاستخدام |
|:---:|---|---:|---:|---|
| <span style="background:#0C4A2D; color:#fff; padding:4px 20px;">&nbsp;</span> | **Royal Green**<br>الأخضر الملكي | `#0C4A2D` | `12, 74, 45` | العناوين الرئيسية، الخلفيات الداكنة، التذييل |
| <span style="background:#15803D; color:#fff; padding:4px 20px;">&nbsp;</span> | **Emerald**<br>الأخضر الزمردي | `#15803D` | `21, 128, 61` | الأزرار، الأيقونات، العناصر التفاعلية |
| <span style="background:#0EA5E9; color:#fff; padding:4px 20px;">&nbsp;</span> | **Sky Blue**<br>الأزرق السماوي | `#0EA5E9` | `14, 165, 233` | الروابط، التمييز، العناصر الثانوية |
| <span style="background:#C79100; color:#fff; padding:4px 20px;">&nbsp;</span> | **Gold**<br>الذهبي الفخم | `#C79100` | `199, 145, 0` | التأكيد، الدرجات، الشارات الخاصة |
| <span style="background:#1A1A2E; color:#fff; padding:4px 20px;">&nbsp;</span> | **Deep Navy**<br>الكحلي العميق | `#1A1A2E` | `26, 26, 46` | النصوص الأساسية، الخطوط العريضة |
| <span style="background:#F8F9FA; color:#000; padding:4px 20px; border:1px solid #ddd;">&nbsp;</span> | **Light BG**<br>الخلفية الفاتحة | `#F8F9FA` | `248, 249, 250` | خلفيات الصفحات، البطاقات |

### الألوان المساعدة

| العيّنة | الاسم | HEX | الاستخدام |
|:---:|---|---:|---:|
| <span style="background:#DC2626; color:#fff; padding:4px 20px;">&nbsp;</span> | **Red** — أحمر | `#DC2626` | أخطاء، تنبيهات، رسائل مهمة |
| <span style="background:#059669; color:#fff; padding:4px 20px;">&nbsp;</span> | **Green** — أخضر ناصع | `#059669` | نجاح، اكتمال، تأكيد |
| <span style="background:#D97706; color:#fff; padding:4px 20px;">&nbsp;</span> | **Orange** — برتقالي | `#D97706` | تحذير، تنبيه متوسط |
| <span style="background:#6B7280; color:#fff; padding:4px 20px;">&nbsp;</span> | **Gray** — رمادي | `#6B7280` | نصوص ثانوية، توجيهات |

### درجات الألوان

```css
/* Ibb University Color Tokens */
:root {
  /* ===== Primary ===== */
  --primary-900: #0C4A2D;    /* Royal Green — darkest */
  --primary-800: #0F5C37;
  --primary-700: #126E41;
  --primary-600: #15803D;    /* Emerald — base */
  --primary-500: #22C55E;
  --primary-400: #4ADE80;
  --primary-300: #86EFAC;
  --primary-200: #BBF7D0;
  --primary-100: #DCFCE7;
  --primary-50:  #F0FDF4;

  /* ===== Secondary ===== */
  --secondary-900: #0369A1;
  --secondary-800: #0284C7;
  --secondary-700: #0EA5E9;   /* Sky Blue — base */
  --secondary-600: #38BDF8;
  --secondary-500: #7DD3FC;
  --secondary-400: #BAE6FD;
  --secondary-300: #E0F2FE;
  --secondary-200: #F0F9FF;

  /* ===== Accent (Gold) ===== */
  --accent-900: #92400E;
  --accent-800: #A16207;
  --accent-700: #C79100;     /* Gold — base */
  --accent-600: #EAB308;
  --accent-500: #FACC15;
  --accent-400: #FDE047;
  --accent-300: #FEF08A;
  --accent-200: #FEF9C3;

  /* ===== Neutral ===== */
  --ink:       #1A1A2E;      /* Deep Navy */
  --ink-muted: #4B5563;
  --ink-light: #6B7280;
  --line:      #E5E7EB;
  --line-soft: #F3F4F6;
  --bg:        #FFFFFF;
  --bg-soft:   #F8F9FA;
}
```

---

## 3. الخطوط

| الخط | النمط | الحجم | الاستخدام |
|:---|:---:|:---:|---|
| **Cairo** | `Regular 400` | 17px | النصوص الأساسية (عربي + إنجليزي) |
| **Cairo** | `Bold 700` | 17px | النصوص الغليظة |
| **Cairo** | `ExtraBold 800` | 36px | العناوين الرئيسية (H1) |
| **Cairo** | `SemiBold 600` | 28px | العناوين الفرعية (H2) |
| **Cairo** | `Medium 500` | 22px | العناوين الصغيرة (H3) |
| **JetBrains Mono** | `Regular 400` | 15px | أكواد MIPS البرمجية |
| **JetBrains Mono** | `Bold 700` | 15px | الكلمات المفتاحية في الكود |

### أحجام النصوص

| العنصر | الحجم | الوزن | المسافة |
|:---|---|---:|
| Display | 56px | 800 | 1.1 |
| H1 | 36px | 800 | 1.2 |
| H2 | 28px | 600 | 1.3 |
| H3 | 22px | 500 | 1.4 |
| Body | 17px | 400 | 1.6 |
| Small | 14px | 400 | 1.5 |
| Micro | 12px | 400 | 1.4 |

---

## 4. تخطيط الشرائح

| العنصر | القيمة |
|:---|---|
| **أبعاد الشريحة** | 1280 × 720 بكسل (13.333 × 7.5 بوصة) |
| **اتجاه النص** | RTL (يمين → يسار) |
| **الشريط العلوي** | 6px - تدرج من `#0C4A2D` إلى `#15803D` |
| **الشريط السفلي** | 4px - تدرج من `#0EA5E9` إلى `#0369A1` |
| **الهوامش** | 48px يمين/يسار، 24px أعلى/أسفل |
| **زوايا البطاقات** | 12px (دائرية) |
| **زوايا الأزرار** | 6px (دائرية قليلاً) |

### مكونات الشريحة

```
┌─────────────────────────────────────────────────────────────────┐
│  [شعار]  العنوان الرئيسي                        [رقم الشريحة]   │  ← شريط علوي 6px
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐  │
│  │                  محتوى الشريحة                              │  │
│  │                                                             │  │
│  │  • البطاقات     • الجداول     • أكواد MIPS                  │  │
│  │  • الصور        • القوائم     • الملاحظات                   │  │
│  │                                                             │  │
│  └─────────────────────────────────────────────────────────────┘  │
│                                                                   │
│  اسم الجامعة — المقرر                               العدد / الإجمالي  │
└─────────────────────────────────────────────────────────────────┘
                          ← شريط سفلي 4px
```

---

## 5. الظلال والتأثيرات

| العنصر | الظل |
|:---|---|
| **البطاقات** | `0 4px 12px rgba(12, 74, 45, 0.06)` |
| **النوافذ المنبثقة** | `0 8px 24px rgba(26, 26, 46, 0.08)` |
| **الأزرار (عادي)** | `0 2px 4px rgba(12, 74, 45, 0.1)` |
| **الأزرار (hover)** | `0 4px 12px rgba(12, 74, 45, 0.2)` |

---

## 6. أيقونات

- استخدم **Material Icons** حصراً للمحافظة على التناسق البصري
- حجم الأيقونات: 24px للعناصر العادية، 32px للأيقونات الرئيسية
- لون الأيقونات: `#15803D` للأساسي، `#0EA5E9` للثانوي

---

<div align="center">
  <br>
  <img src="الشعار/images.jpeg" alt="Ibb University" width="60">
  <br>
  <strong>جامعة إب — كلية الحاسابات والعلوم التطبيقية</strong>
  <br>
  <sub>Ibb University — College of Computing and Applied Sciences</sub>
  <br><br>
  <sub>© 2024-2025 — جميع الحقوق محفوظة</sub>
</div>
