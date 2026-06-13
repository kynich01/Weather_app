# Weather App "Pawangin"

Aplikasi cuaca berbasis Flutter yang memungkinkan pengguna mencari informasi cuaca berdasarkan nama kota secara real-time.

> Dibuat untuk memenuhi tugas mata kuliah Pemrograman Perangkat Bergerak

---

## Fitur Utama

- Pencarian kota dengan validasi real-time ke API
- Informasi cuaca terkini (suhu, angin, kelembapan, tekanan udara, jarak pandang)
- Prakiraan cuaca 6 jam ke depan
- Informasi sunrise & sunset sesuai zona waktu kota
- Simpan & kelola lokasi favorit (tambah, edit, hapus)
- Animasi Lottie dinamis sesuai kondisi cuaca
- Deteksi koneksi internet saat validasi kota

---

## Teknologi yang Digunakan

| Teknologi | Keterangan |
|-----------|------------|
| Flutter & Dart | Framework utama pengembangan aplikasi |
| OpenWeatherMap API | Sumber data cuaca real-time |
| SQLite (sqflite) | Database lokal untuk menyimpan lokasi |
| HTTP | Package untuk melakukan request ke API |
| Lottie | Package untuk animasi cuaca |

---

## Struktur Folder

```
lib/
├── controller/
│   ├── saved_locations_controller.dart
│   ├── search_controller.dart
│   └── weather_controller.dart
├── db/
│   └── weather_location_db.dart
├── models/
│   └── saved_location.dart
├── services/
│   └── weather_service.dart
└── ui/
    ├── pages/
    │   ├── result.dart
    │   ├── saved_locations_page.dart
    │   └── search_field.dart
    └── widgets/
        ├── add_location_sheet.dart
        ├── auto_slide_card.dart
        ├── blue_card.dart
        ├── location_card.dart
        ├── result_search_bar.dart
        ├── search_bottom_panel.dart
        ├── search_input_field.dart
        ├── weather_bottom_section.dart
        ├── weather_navbar.dart
        └── weather_top_section.dart
```

---

## Cara Menjalankan

1. Clone repository ini
2. Masuk ke folder project
3. Jalankan perintah berikut:

```
flutter pub get
flutter run
```

---

## API Key

Aplikasi ini menggunakan OpenWeatherMap API. API key tersimpan di `lib/services/weather_service.dart`.

---

## Developer

- **Nama**: kynich
- **GitHub**: [@kynich01](https://github.com/kynich01)
