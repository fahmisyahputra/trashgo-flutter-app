# TrashGo ♻️
Aplikasi mobile ramah lingkungan untuk layanan penjemputan sampah dan edukasi daur ulang, dibuat dengan Flutter.

## 🛠️ Fitur Utama
- 📍 Pencarian dan informasi Bank Sampah terdekat
- 🧾 Formulir permintaan penjemputan sampah
- 📖 Halaman edukasi daur ulang sampah
- 📊 Riwayat permintaan pickup
- 🔍 Fitur pencarian & filter data
- 🧭 Integrasi lokasi & Google Maps

## 📦 Struktur Folder
```
lib/
├── main.dart # Titik masuk utama aplikasi Flutter (entry point)
├── pickup_request_provider.dart # Provider untuk manajemen state permintaan pickup
│
├── models/ # Folder berisi struktur data (model class)
│ ├── bank_sampah.dart # Model untuk informasi bank sampah
│ ├── edukasi_artikel.dart # Model untuk artikel edukasi
│ └── pickup_request.dart # Model untuk request penjemputan sampah
│
├── pages/ # Folder berisi tampilan halaman (UI utama)
│ ├── bank_sampah_page.dart # Halaman daftar bank sampah
│ ├── edukasi_sampah_page.dart # Halaman edukasi tentang sampah
│ ├── home_page.dart # Halaman utama (berisi shortcut tombol navigasi)
│ ├── request_pickup_page.dart # Halaman form pengajuan pickup
│ └── riwayat_pickup_page.dart # Halaman riwayat permintaan pickup
│
├── widgets/ # Folder berisi komponen UI yang reusable
│ ├── appbar_navbar.dart # AppBar reusable berisi logo TrashGo
│ ├── bottom_navbar.dart # BottomNavigationBar custom (navigasi bawah)
│ └── shortcut_menu.dart # Tombol-tombol shortcut di halaman utama
```

## 🧰 Cara Menjalankan Project

### 1. Clone Repo
```bash
git clone https://github.com/fahmisyahputra/trashgo-flutter-app.git
cd trashgo-flutter-app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Jalankan Aplikasi
Pastikan device/emulator kamu sudah berjalan, lalu jalankan:
```bash
flutter run
```

Jika belum, jalankan emulator :

### 4. Menjalankan Emulator

#### Di macOS (VS Code)
Tekan `Cmd + Shift + P` lalu ketik:
```
Flutter: Launch Emulator
```

#### Di Windows (VS Code)
Tekan `Ctrl + Shift + P` lalu ketik:
```
Flutter: Launch Emulator
```

Atau kamu bisa buka Android Studio > Device Manager > Start Emulator.

Kemudian setelah Emulator sudah berjalan, jalankan 
```bash
flutter run
```

## 📍 Catatan
- Jangan lupa mengaktifkan akses lokasi pada emulator/device
- Logo tersedia di `assets/images/logo.png`
- Pastikan `pubspec.yaml` telah memuat aset dengan benar:
```yaml
flutter:
  assets:
    - assets/images/
```


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
