# 🕵️‍♀️ SQL Murder Mystery - Data Detective Project

**Author**: Maylinna Rahayu Ningsih  
**Source Case**: [Knight Lab's SQL Murder Mystery](https://mystery.knightlab.com/)  
**Original Database**: [NU Knight Lab GitHub](https://github.com/NUKnightLab/sql-mysteries)

---

## 📚 Overview

Dalam proyek ini, saya berperan sebagai **detektif data** yang menyelidiki sebuah **kasus pembunuhan** yang terjadi di **SQL City** pada **15 Januari 2018**. Proyek ini didesain untuk mengasah keterampilan SQL dalam konteks cerita interaktif dan nyata.

---

## 🔍 Kasus Pembunuhan

> *“Saya kehilangan laporan TKP, tapi saya ingat dua hal: Lokasinya di SQL City, dan kejadiannya pada 15 Januari 2018.”*

Tugas saya adalah menggunakan kemampuan SQL untuk:
- Menyelidiki saksi
- Menggali petunjuk
- Menemukan pelaku pembunuhan

---

## 🧰 Tools & Dataset

- **Database Engine**: SQLite (awal), PostgreSQL (modifikasi)
- **Query Language**: SQL
- **Ekspor & Penyesuaian**: Python (untuk menyelaraskan format data)
- **Visualisasi & dokumentasi**: PDF file

---

## 📁 File-File Penting

| File                          | Deskripsi                                                                 |
|-------------------------------|---------------------------------------------------------------------------|
| `Query SQL Murder Mystery.sql` | Berisi seluruh query investigasi dari awal hingga menemukan pelaku       |
| `Project SQL Murder Mistery.pdf` | Penjelasan naratif & proses penyelidikan                                |
| `*.csv`                       | Tabel-tabel dari database yang telah diekspor dan disesuaikan            |
| `*.py`                        | Script Python untuk ekspor/bersihkan file agar cocok dengan PostgreSQL   |

> **Note**: File CSV saya mungkin **tidak persis sama** dengan yang ada di versi original web dan SQLite karena saya melakukan penyesuaian agar bisa digunakan di PostgreSQL (terutama penanganan karakter spesial dan foreign key).

---

## 🐍 Python Scripts

Beberapa script Python digunakan untuk:
- Mengkonversi data dari SQLite ke CSV
- Membersihkan data dari karakter aneh seperti `;;` atau kutipan rusak
- Memastikan data siap di-*import* ke PostgreSQL tanpa error

---

## 💡 Sumber Referensi

- 🌐 Main Project: [https://mystery.knightlab.com/](https://mystery.knightlab.com/)
- 🗃️ GitHub DB: [https://github.com/NUKnightLab/sql-mysteries](https://github.com/NUKnightLab/sql-mysteries)

---

## ✅ Status

🟢 **Selesai** — Pelaku berhasil diidentifikasi menggunakan SQL dan semua file dokumentasi tersedia di repo ini.

---

## 📌 Catatan Akhir

Proyek ini merupakan bagian dari eksplorasi saya dalam bidang data dan penguatan kemampuan SQL.  
Semua penyesuaian file bertujuan agar data bisa digunakan lebih fleksibel di PostgreSQL dan tools lain.

Feel free to fork, eksplorasi ulang, atau kontak saya untuk diskusi!

---
