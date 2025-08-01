# تطبيق شام - حجز التذاكر والفنادق

تطبيق Flutter متكامل لحجز تذاكر الباص والطائرات والفنادق في سوريا، مصمم بواجهة عربية جميلة ومريحة.

## المميزات الرئيسية

### 🚌 نظام حجز تذاكر الباص
- **14 محافظة سورية**: دمشق، حلب، حمص، اللاذقية، طرطوس، دير الزور، حماة، درعا، السويداء، الرقة، إدلب، الحسكة، القنيطرة، ريف دمشق
- **8 شركات نقل**: شركات باصات سورية مع تقييمات ومراجعات
- **نظام مقاعد 2+1**: هيكل باص مريح مع إمكانية اختيار الجنس
- **ألوان مميزة**: أزرق للذكور، زهري للإناث
- **منع الحجز المختلط**: لا يمكن حجز مقاعد مختلفة الجنس معاً

### ✈️ نظام حجز الطائرات
- **3 مدن رئيسية**: دمشق، حلب، الحسكة
- **3 شركات طيران**: سورية للطيران، طيران الشرق، طيران الشام
- **معلومات الراكب**: الاسم، البريد الإلكتروني، الهاتف، تاريخ الميلاد
- **الجنسية والجواز**: دعم للمواطنين السوريين والأجانب
- **دفع الفيزا**: معلومات البطاقة مع التحقق

### 🏨 نظام حجز الفنادق
- **4 محافظات**: دمشق، حلب، اللاذقية، الحسكة
- **10 فنادق**: مع تقييمات ومراجعات ونجوم
- **ترتيب متقدم**: حسب التقييم، السعر، أو النجوم
- **معلومات الضيف**: الاسم، البريد الإلكتروني، الهاتف
- **تواريخ الحجز**: وصول ومغادرة مع عدد الضيوف والغرف

### 🎨 واجهة مستخدم عربية
- تصميم عصري وجذاب
- خط Cairo العربي
- ألوان متناسقة ومريحة للعين
- تجربة مستخدم سلسة

### 📱 شاشات التطبيق

#### الباص:
1. **الصفحة الرئيسية**: البحث عن الرحلات
2. **اختيار الشركة**: عرض شركات النقل المتاحة
3. **اختيار المقعد**: هيكل الباص مع نظام 2+1
4. **تأكيد الحجز**: معلومات الراكب وطرق الدفع
5. **التذكرة**: عرض التذكرة النهائية

#### الطائرة:
1. **اختيار المدن**: دمشق، حلب، الحسكة
2. **اختيار الشركة**: 3 شركات طيران
3. **معلومات الراكب**: مع الجنسية والجواز
4. **دفع الفيزا**: معلومات البطاقة
5. **التذكرة**: تذكرة الطائرة

#### الفندق:
1. **اختيار المحافظة**: 4 محافظات
2. **قائمة الفنادق**: مع التقييمات والأسعار
3. **حجز الفندق**: معلومات الضيف والدفع
4. **التذكرة**: تذكرة الفندق

### 💳 طرق الدفع
- فيزا / ماستر كارد
- الدفع عند الوصول/الصعود

### 🔐 نظام التحقق
- رمز تحقق عبر الهاتف
- تأكيد الحجز آمن

## التقنيات المستخدمة

- **Flutter**: إطار العمل الرئيسي
- **Dart**: لغة البرمجة
- **Material Design**: تصميم الواجهة
- **Cairo Font**: الخط العربي

## هيكل المشروع

```
lib/
├── main.dart                 # نقطة البداية
├── models/
│   ├── bus_models.dart       # نماذج الباص
│   ├── hotel_models.dart     # نماذج الفنادق
│   └── flight_models.dart    # نماذج الطائرات
├── data/
│   ├── bus_data.dart         # بيانات الباص
│   ├── hotel_data.dart       # بيانات الفنادق
│   └── flight_data.dart      # بيانات الطائرات
├── screens/
│   ├── home_page.dart        # الصفحة الرئيسية
│   ├── company_selection_screen.dart  # اختيار شركة الباص
│   ├── bus_seat_selection.dart        # اختيار مقعد الباص
│   ├── booking_summary_screen.dart    # تأكيد حجز الباص
│   ├── ticket_screen.dart             # تذكرة الباص
│   ├── hotel_selection_screen.dart    # اختيار الفندق
│   ├── hotel_booking_screen.dart      # حجز الفندق
│   ├── hotel_ticket_screen.dart       # تذكرة الفندق
│   ├── flight_company_selection_screen.dart  # اختيار شركة الطيران
│   ├── flight_booking_screen.dart     # حجز الطائرة
│   └── flight_ticket_screen.dart      # تذكرة الطائرة
└── l10n/                     # ملفات الترجمة
```

## كيفية التشغيل

1. تأكد من تثبيت Flutter
2. استنسخ المشروع
3. قم بتشغيل `flutter pub get`
4. شغل التطبيق بـ `flutter run`

## المميزات التقنية

- **State Management**: إدارة حالة التطبيق
- **Navigation**: التنقل بين الشاشات
- **Form Validation**: التحقق من صحة البيانات
- **Responsive Design**: تصميم متجاوب
- **Localization**: دعم اللغة العربية
- **Data Models**: نماذج بيانات منظمة
- **Error Handling**: معالجة الأخطاء

## المساهمة

نرحب بالمساهمات! يرجى إنشاء issue أو pull request.

## الترخيص

هذا المشروع مرخص تحت رخصة MIT.
