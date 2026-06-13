🌤️ Weather App "Pawangin"

Aplikasi cuaca berbasis Flutter yang memungkinkan pengguna mencari informasi cuaca berdasarkan nama kota secara real-time.


📚 Dibuat untuk memenuhi tugas mata kuliah Pemrograman Perangkat Bergerak

✨ Fitur Utama

🔍 Pencarian kota dengan validasi real-time ke API
🌡️ Informasi cuaca terkini (suhu, angin, kelembapan, tekanan udara, jarak pandang)
🕐 Prakiraan cuaca 6 jam ke depan
🌅 Informasi sunrise & sunset sesuai zona waktu kota
💾 Simpan & kelola lokasi favorit (tambah, edit, hapus)
🎞️ Animasi Lottie dinamis sesuai kondisi cuaca
📡 Deteksi koneksi internet saat validasi kota

📱 Screenshot


Coming soon




🛠️ Teknologi yang Digunakan

TeknologiKeteranganFlutter & DartFramework utama pengembangan aplikasiOpenWeatherMap APISumber data cuaca real-timeSQLite (sqflite)Database lokal untuk menyimpan lokasiHTTPPackage untuk melakukan request ke APILottiePackage untuk animasi cuaca

📂 Struktur Folder

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


🚀 Cara Menjalankan


Clone repository ini


bashgit clone https://github.com/kynich01/Weather_app.git


Masuk ke folder project


bashcd Weather_app


Install dependencies


bashflutter pub get


Jalankan aplikasi


bashflutter run


🔑 API Key

Aplikasi ini menggunakan OpenWeatherMap API. API key tersimpan di lib/services/weather_service.dart. tinggal login melalui gmail untuk mendapatkan keynya

👤 Developer

kynich01 — @kynich01
