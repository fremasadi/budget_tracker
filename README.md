# Budget Tracker App

Budget Tracker adalah aplikasi pencatatan keuangan sederhana yang membantu pengguna dalam mengelola pemasukan dan pengeluaran. Aplikasi ini juga menyediakan fitur kategori yang dapat disesuaikan oleh pengguna, riwayat transaksi, serta notifikasi pengingat untuk mencatat transaksi secara berkala.

## Demo Video

Klik gambar di bawah untuk melihat demo video di YouTube:

[![Demo Video](https://img.youtube.com/vi/abcd1234/0.jpg)]([https://www.youtube.com/watch?v=abcd1234](https://youtu.be/Y_XdX8MRoOU))



## Fitur Utama

1. **Pencatatan Pemasukan dan Pengeluaran**: 
   - Aplikasi memungkinkan pengguna untuk mencatat pemasukan (income) dan pengeluaran (expenses) dengan mudah.
   - Pengguna dapat memasukkan jumlah dan memilih kategori untuk setiap transaksi.

2. **Membuat Kategori Sendiri**:
   - Pengguna dapat membuat kategori transaksi yang dapat disesuaikan sesuai kebutuhan mereka, baik untuk pemasukan maupun pengeluaran.
   - Tersedia berbagai ikon dan warna yang dapat dipilih untuk mempersonalisasi kategori.

3. **Riwayat Transaksi**:
   - Fitur ini menampilkan semua transaksi yang pernah dicatat oleh pengguna.
   - Pengguna dapat melihat riwayat transaksi berdasarkan bulan dan tahun.
   - Total balance (saldo), total pemasukan, dan total pengeluaran juga ditampilkan secara real-time.

4. **Notifikasi Pengingat**:
   - Pengguna dapat menerima notifikasi sebagai pengingat untuk mencatat pemasukan dan pengeluaran mereka.

5. **Penyimpanan Data dengan SQLite**:
   - Semua data transaksi dan kategori disimpan secara lokal di perangkat menggunakan SQLite.
   - Data yang tersimpan bersifat persisten dan tetap ada meskipun aplikasi ditutup.

6. **Menggunakan GetX untuk State Management dan Navigasi**:
   - GetX digunakan untuk mengelola state, navigasi, dan dependensi antar bagian aplikasi secara efisien.
   - GetX juga digunakan untuk notifikasi dan pengelolaan database.

## Teknologi yang Digunakan

- **Flutter**: Framework untuk membangun aplikasi mobile cross-platform (iOS & Android).
- **GetX**: Library Flutter untuk state management, navigasi, dan manajemen dependensi yang sederhana dan efisien.
- **SQLite**: Digunakan untuk penyimpanan data transaksi dan kategori secara lokal di perangkat pengguna.

## Cara Instalasi

1. Clone repositori ini ke komputer Anda:
   ```bash
   git clone https://github.com/username/budget-tracker.git
