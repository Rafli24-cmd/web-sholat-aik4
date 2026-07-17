# 🕌 Tuntunan Tata Cara Sholat Sesuai Sunnah Rasulullah ﷺ

Aplikasi web edukatif yang menyajikan tuntunan tata cara sholat berdasarkan  
**Himpunan Putusan Tarjih (HPT) Muhammadiyah**.

---

## 👥 Identitas Kelompok

| No | Nama | NIM | Peran |
|----|------|-----|-------|
| 1 | Rafli Nurrizki Subarti | 241220083 | Ketua Tim / Project Manager |
| 2 | Elva Adelia Regina | 241220072 | Front-end Developer |
| 3 | Nazwa Mecca | 241220067 | Back-end Developer |
| 4 | Audina Zevirani | 241220052 | Database & Content Engineer |
| 5 | Bintang Adilla Arsa Kinanti | 241220066 | QA, Dokumentasi & Deployment |

**Kelompok 6** · Manajemen Bisnis Syariah · Fakultas Agama Islam  
**Mata Kuliah:** AIK 4 (Al-Islam dan Kemuhammadiyahan 4)  
**Dosen Pengampu:** Dedy Susanto, S.Pd.I., M.M. (NIDN. 1128048303)  
**Universitas Muhammadiyah Pontianak**

---

## 🌐 URL Aplikasi (Live)

> 🔗 **[https://sholat-kelompok6.up.railway.app](https://sholat-kelompok6.up.railway.app)**  
> *(URL akan diperbarui setelah deployment)*

---

## ✨ Fitur Aplikasi

- **2 Mode Pengguna:** Dewasa (lengkap) dan Anak-anak (bahasa sederhana)
- **13 Gerakan Sholat** dari Qiyam hingga Salam, sesuai HPT Muhammadiyah
- **Teks 4 Lapis:** Arab · Latin · Terjemahan · Sumber HPT
- **Audio MP3** untuk setiap bacaan
- **Video** gerakan sebagai alternatif media
- **Navigasi Next/Previous** antar gerakan
- **Autoplay** — memutar gerakan dan audio secara berurutan otomatis
- **Klik langsung** gerakan mana pun dari sidebar
- **Responsif** — mobile, tablet, desktop
- **Identitas kelompok** tampil di setiap halaman

---

## 🛠️ Teknologi

| Lapisan | Teknologi |
|---------|-----------|
| Front-end | HTML5, CSS3, JavaScript (Vanilla) |
| Back-end | Python Flask |
| Database | SQLite |
| Font | Inter, Sora, Amiri (Arabic) |

---

## 🚀 Cara Menjalankan Lokal

```bash
# 1. Clone repositori
git clone https://github.com/[username]/sholat-kelompok6.git
cd sholat-kelompok6

# 2. Install dependencies
pip install -r requirements.txt

# 3. Jalankan aplikasi
python app.py

# 4. Buka browser
# http://localhost:5000
```

Database akan dibuat otomatis saat pertama kali dijalankan.

---

## 📁 Struktur Folder

```
sholat-app/
├── app.py                  # Flask backend (routes & logic)
├── schema.sql              # Skema database + seed data
├── requirements.txt
├── instance/
│   └── sholat.db           # SQLite database (auto-generated)
├── static/
│   ├── css/style.css       # Stylesheet utama
│   ├── js/main.js          # JavaScript utama
│   ├── img/gerakan/        # Gambar tiap gerakan (01_qiyam.png, dst)
│   └── audio/              # File MP3 bacaan
└── templates/
    ├── base.html           # Template dasar (header & footer)
    ├── index.html          # Halaman beranda
    ├── daftar_gerakan.html # Daftar semua gerakan
    └── detail_gerakan.html # Detail 1 gerakan + bacaan + audio
```

---

## 📚 Sumber Konten

Seluruh teks Arab, transliterasi Latin, dan terjemahan bacaan sholat  
bersumber dari:

1. **Himpunan Putusan Tarjih Muhammadiyah (HPT)** — Kitab Shalat,  
   PP Muhammadiyah, Suara Muhammadiyah, Yogyakarta.
2. **Tuntunan Shalat sesuai Tarjih Muhammadiyah**,  
   PP Muhammadiyah.

---

## 📋 Checklist Fitur (F-01 s.d. F-09)

- [x] F-01 Daftar gerakan sholat urut dan dapat diklik
- [x] F-02 Detail gerakan (gambar + bacaan 4 lapis)
- [x] F-03 Audio MP3 setiap bacaan
- [x] F-04 Opsi video gerakan
- [x] F-05 Navigasi Next/Previous
- [x] F-06 Autoplay berurutan
- [x] F-07 Mode Dewasa & Anak
- [x] F-08 Identitas kelompok di setiap halaman
- [x] F-09 Data dari database (bukan hardcode HTML)
