# ایران سفر — Flutter scaffold (Full)

این پروژه شامل دیتاست کامل ۳۱ استان با ۴ مکان مهم برای هر استان (آفلاین) و اسکریپت دانلود تصاویر از ویکی‌پدیا.
فایل ZIP شامل پروژهٔ Flutter است.

**نکات نصب**
1. استخراج ZIP و ورود به پوشه:
   cd iran_safar_flutter
   flutter pub get
2. برای اجرای در شبیه‌ساز:
   flutter run
3. برای ساخت APK:
   flutter build apk --release

**تصاویر واقعی**
- برای دانلود تصاویر واقعی: اجرا کن
  python3 scripts/download_images.py


در پوشهٔ assets/images/places فایل‌های placeholder موجود است. برای دانلود تصاویر واقعی اجرا کن:

```bash
python3 scripts/download_images.py
```


## ترجمه‌ها
- فایل `assets/data/places_full.json` اکنون شامل فیلد `translations` برای هر مکان است.
- هر مکان ترجمه‌ٔ نام و توضیحات را به زبان‌های fa/en/ar/ru/zh/hi دارد (توضیحات ۲-۳ جمله‌ای، توضیحات انگلیسی/عربی/روسی/چینی/هندی به صورت خلاصه). 
