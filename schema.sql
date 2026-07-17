-- ============================================================
-- APLIKASI WEB TUNTUNAN TATA CARA SHOLAT
-- Kelompok 6 - Manajemen Bisnis Syariah
-- Universitas Muhammadiyah Pontianak
-- ============================================================

PRAGMA foreign_keys = ON;

-- ------------------------------------------------------------
-- 1. TABEL KELOMPOK (identitas header)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS kelompok (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_kelompok TEXT NOT NULL,
    prodi       TEXT NOT NULL,
    mata_kuliah TEXT NOT NULL,
    dosen       TEXT NOT NULL
);

-- ------------------------------------------------------------
-- 2. TABEL KATEGORI (dewasa | anak)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS kategori (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    nama TEXT NOT NULL UNIQUE  -- 'dewasa' atau 'anak'
);

-- ------------------------------------------------------------
-- 3. TABEL GERAKAN
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS gerakan (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_kategori INTEGER NOT NULL,
    nama        TEXT NOT NULL,
    urutan      INTEGER NOT NULL,
    deskripsi   TEXT,
    deskripsi_anak TEXT,
    gambar_url  TEXT,
    video_url   TEXT,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id)
);

-- ------------------------------------------------------------
-- 4. TABEL BACAAN
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bacaan (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_gerakan  INTEGER NOT NULL,
    urutan      INTEGER NOT NULL DEFAULT 1,
    teks_arab   TEXT,
    teks_latin  TEXT,
    terjemahan  TEXT,
    terjemahan_ringkas TEXT,
    audio_url   TEXT,
    sumber      TEXT,
    FOREIGN KEY (id_gerakan) REFERENCES gerakan(id)
);

-- ============================================================
-- SEED DATA
-- ============================================================

-- Kelompok
INSERT INTO kelompok (nama_kelompok, prodi, mata_kuliah, dosen) VALUES
('Kelompok 6', 'Manajemen Bisnis Syariah', 'AIK 4 (Al-Islam dan Kemuhammadiyahan 4)', 'Dedy Susanto, S.Pd.I., M.M.');

-- Kategori
INSERT INTO kategori (nama) VALUES ('dewasa');
INSERT INTO kategori (nama) VALUES ('anak');

-- ============================================================
-- GERAKAN SHOLAT - MODE DEWASA (id_kategori = 1)
-- ============================================================

-- 1. Berdiri tegak / Qiyam
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Berdiri Tegak (Qiyam)', 1,
'Berdiri tegak menghadap kiblat dengan posisi tubuh sempurna. Pandangan diarahkan ke tempat sujud. Niat sholat diucapkan dalam hati sesuai sholat yang dikerjakan.',
'Berdiri tegak lurus, lihat ke tempat sujud, dan niat di dalam hati.',
'/static/img/gerakan/01_qiyam.png', '/static/video/01_qiyam.mp4');

-- 2. Takbiratul Ihram
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Takbiratul Ihram', 2,
'Mengangkat kedua tangan sejajar dengan bahu atau telinga, telapak tangan menghadap kiblat, jari-jari tangan dirapatkan, kemudian mengucapkan takbir "Allāhu Akbar".',
'Angkat dua tangan sampai sebahu sambil bilang "Allahu Akbar".',
'/static/img/gerakan/02_takbir.png', '/static/video/02_takbir.mp4');

-- 3. Bersedekap
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Bersedekap', 3,
'Meletakkan tangan kanan di atas punggung tangan kiri di atas dada. Kemudian membaca doa iftitah sebelum membaca Al-Fatihah.',
'Tangan kanan ditaruh di atas tangan kiri di dada, lalu baca doa pembuka.',
'/static/img/gerakan/03_sedekap.png', '/static/video/03_sedekap.mp4');

-- 4. Membaca Al-Fatihah dan Surah
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Membaca Al-Fātihah', 4,
'Membaca Surah Al-Fātihah dengan tartil dan khusyuk. Setelah Al-Fatihah dilanjutkan dengan membaca surah atau beberapa ayat Al-Quran (pada rakaat pertama dan kedua).',
'Baca Surah Al-Fatihah pelan-pelan, lalu baca surah pendek.',
'/static/img/gerakan/04_fatihah.png', '/static/video/04_fatihah.mp4');

-- 5. Rukuk
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Rukuk', 5,
'Membungkukkan badan hingga punggung sejajar dengan lantai (atau mendekati sejajar). Kedua tangan memegang lutut, jari-jari direnggangkan. Diam sejenak dengan thuma''ninah.',
'Bungkukkan badan, tangan pegang lutut, diam sebentar dengan tenang.',
'/static/img/gerakan/05_rukuk.png', '/static/video/05_rukuk.mp4');

-- 6. I'tidal
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'I''tidal', 6,
'Bangkit dari rukuk hingga berdiri tegak kembali. Mengangkat kedua tangan sejajar bahu ketika bangkit, kemudian berdiri tegak dengan thuma''ninah.',
'Berdiri tegak lagi setelah rukuk, angkat tangan sambil baca doa.',
'/static/img/gerakan/06_itidal.png', '/static/video/06_itidal.mp4');

-- 7. Sujud Pertama
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Sujud Pertama', 7,
'Sujud dengan meletakkan tujuh anggota badan di lantai: dahi (beserta hidung), dua telapak tangan, dua lutut, dan ujung dua kaki. Diam dengan thuma''ninah.',
'Sujud dengan dahi menyentuh lantai, diam sebentar dengan tenang.',
'/static/img/gerakan/07_sujud1.png', '/static/video/07_sujud1.mp4');

-- 8. Duduk di antara dua sujud
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Duduk di Antara Dua Sujud', 8,
'Bangkit dari sujud pertama dan duduk iftirasy (kaki kiri diduduki, kaki kanan ditegakkan). Membaca doa duduk antara dua sujud dengan thuma''ninah.',
'Duduk sebentar di antara dua sujud sambil baca doa.',
'/static/img/gerakan/08_duduk_sujud.png', '/static/video/08_duduk_sujud.mp4');

-- 9. Sujud Kedua
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Sujud Kedua', 9,
'Sujud kembali seperti sujud pertama dengan meletakkan tujuh anggota badan dan membaca tasbih sujud dengan thuma''ninah.',
'Sujud lagi seperti tadi, baca doa yang sama.',
'/static/img/gerakan/09_sujud2.png', '/static/video/09_sujud2.mp4');

-- 10. Berdiri ke rakaat berikutnya
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Berdiri ke Rakaat Berikutnya', 10,
'Bangkit dari sujud kedua untuk melanjutkan ke rakaat berikutnya. Berdiri tegak kembali dengan bertumpu pada kedua lutut, kemudian mengulangi gerakan dari membaca Al-Fatihah.',
'Berdiri lagi untuk mulai rakaat berikutnya.',
'/static/img/gerakan/10_berdiri_rakaat.png', '/static/video/10_berdiri_rakaat.mp4');

-- 11. Duduk Tasyahud Awal
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Duduk Tasyahud Awal', 11,
'Duduk iftirasy pada rakaat kedua (pada sholat 3 dan 4 rakaat). Membaca tasyahud awal. Jari telunjuk kanan diangkat ketika sampai pada kalimat syahadat.',
'Duduk dan baca tasyahud awal, angkat jari telunjuk saat syahadat.',
'/static/img/gerakan/11_tasyahud_awal.png', '/static/video/11_tasyahud_awal.mp4');

-- 12. Duduk Tasyahud Akhir
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Duduk Tasyahud Akhir', 12,
'Duduk tawarruk pada rakaat terakhir: kaki kiri dikeluarkan ke sisi kanan, pantat menyentuh lantai. Membaca tasyahud akhir dan shalawat atas Nabi Ibrahim dan Nabi Muhammad.',
'Duduk berbeda dari biasanya, baca tasyahud akhir dan shalawat.',
'/static/img/gerakan/12_tasyahud_akhir.png', '/static/video/12_tasyahud_akhir.mp4');

-- 13. Salam
INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url) VALUES
(1, 'Salam', 13,
'Mengakhiri sholat dengan menoleh ke kanan sambil mengucapkan salam, kemudian menoleh ke kiri sambil mengucapkan salam.',
'Menoleh ke kanan dan kiri sambil mengucapkan salam.',
'/static/img/gerakan/13_salam.png', '/static/video/13_salam.mp4');

-- ============================================================
-- GERAKAN SHOLAT - MODE ANAK (id_kategori = 2)
-- (Sama strukturnya, deskripsi lebih ringkas)
-- ============================================================

INSERT INTO gerakan (id_kategori, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url)
SELECT 2, nama, urutan, deskripsi, deskripsi_anak, gambar_url, video_url FROM gerakan WHERE id_kategori = 1;

-- ============================================================
-- BACAAN SHOLAT
-- Sumber: Himpunan Putusan Tarjih (HPT) Muhammadiyah, Kitab Shalat
-- ============================================================

-- 2. Takbiratul Ihram
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(2, 1,
'اللهُ أَكْبَرُ',
'Allāhu Akbar',
'Allah Maha Besar',
'Allah Maha Besar',
'/static/audio/dewasa/02_takbir.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 3. Doa Iftitah
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(3, 1,
'سُبْحَانَكَ اللّهُمَّ وَبِحَمْدِكَ وَتَبَارَكَ اسْمُكَ وَتَعَالَى جَدُّكَ وَلاَ إِلَهَ غَيْرُكَ',
'Subhānakallahumma wa bihamdika wa tabārakasmuka wa ta''āla jadduka wa lā ilāha ghairuk',
'Maha Suci Engkau ya Allah, dan dengan memuji-Mu, Maha Berkah nama-Mu, Maha Tinggi keagungan-Mu, dan tiada Tuhan selain Engkau.',
'Maha Suci Allah, Maha Berkah nama-Nya.',
'/static/audio/dewasa/03_iftitah.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 4. Al-Fatihah
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(4, 1,
'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ۝ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ۝ الرَّحْمَٰنِ الرَّحِيمِ ۝ مَالِكِ يَوْمِ الدِّينِ ۝ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ۝ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ۝ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
'Bismillāhirrahmānirrahīm. Alhamdulillāhi rabbil ''ālamīn. Arrahmānirrahīm. Māliki yaumiddīn. Iyyāka na''budu wa iyyāka nasta''īn. Ihdinasshirāthal mustaqīm. Shirāthal ladzīna an''amta ''alaihim ghairil maghdūbi ''alaihim wa laddhāllīn.',
'Dengan nama Allah Yang Maha Pengasih lagi Maha Penyayang. Segala puji bagi Allah, Tuhan semesta alam. Yang Maha Pengasih lagi Maha Penyayang. Yang menguasai hari pembalasan. Hanya kepada Engkau kami menyembah dan hanya kepada Engkau kami memohon pertolongan. Tunjukilah kami jalan yang lurus. Jalan orang-orang yang Engkau beri nikmat, bukan jalan mereka yang dimurkai dan bukan pula jalan mereka yang sesat.',
'Puji syukur kepada Allah, hanya Allah yang kita sembah dan minta tolong.',
'/static/audio/dewasa/04_fatihah.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 5. Rukuk - Tasbih
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(5, 1,
'سُبْحَانَ رَبِّيَ الْعَظِيمِ',
'Subhāna rabbiyal ''azhīm',
'Maha Suci Tuhanku Yang Maha Agung',
'Maha Suci Tuhanku Yang Maha Besar',
'/static/audio/dewasa/05_rukuk.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 6. I'tidal
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(6, 1,
'سَمِعَ اللهُ لِمَنْ حَمِدَهُ',
'Sami''allāhu liman hamidah',
'Allah mendengar orang yang memuji-Nya',
'Allah mendengar pujian kita',
'/static/audio/dewasa/06_itidal_bangkit.mp3',
'HPT Muhammadiyah, Kitab Shalat');

INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(6, 2,
'رَبَّنَا وَلَكَ الْحَمْدُ',
'Rabbanā wa lakal hamd',
'Ya Tuhan kami, bagi-Mu segala puji',
'Ya Allah, bagi-Mu segala puji',
'/static/audio/dewasa/06_itidal_berdiri.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 7. Sujud Pertama - Tasbih
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(7, 1,
'سُبْحَانَ رَبِّيَ الْأَعْلَى',
'Subhāna rabbiyal a''lā',
'Maha Suci Tuhanku Yang Maha Tinggi',
'Maha Suci Tuhanku Yang Maha Tinggi',
'/static/audio/dewasa/07_sujud1.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 8. Duduk antara dua sujud
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(8, 1,
'رَبِّ اغْفِرْ لِي وَارْحَمْنِي وَاجْبُرْنِي وَارْفَعْنِي وَارْزُقْنِي وَاهْدِنِي وَعَافِنِي وَاعْفُ عَنِّي',
'Rabbighfirlī warhamnī wajburnī warfa''nī warzuqnī wahdinī wa ''āfinī wa''fu ''annī',
'Ya Allah, ampunilah aku, rahmatilah aku, cukupkanlah aku, angkatlah derajatku, berilah aku rezeki, berilah aku petunjuk, sehatkanlah aku, dan maafkanlah aku.',
'Ya Allah, ampuni dan sayangi aku.',
'/static/audio/dewasa/08_duduk_sujud.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 9. Sujud Kedua - Tasbih (sama dengan sujud pertama)
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(9, 1,
'سُبْحَانَ رَبِّيَ الْأَعْلَى',
'Subhāna rabbiyal a''lā',
'Maha Suci Tuhanku Yang Maha Tinggi',
'Maha Suci Tuhanku Yang Maha Tinggi',
'/static/audio/dewasa/09_sujud2.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 11. Tasyahud Awal
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(11, 1,
'التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللهِ الصَّالِحِينَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
'At-tahiyyātu lillāhi wash-shalawātu wash-thayyibāt. As-salāmu ''alaika ayyuhan-nabiyyu wa rahmatullāhi wa barakātuh. As-salāmu ''alainā wa ''alā ''ibādillāhish-shālihīn. Asyhadu an lā ilāha illallāh wa asyhadu anna Muhammadan ''abduhu wa rasūluh.',
'Segala penghormatan, sholawat, dan kebaikan hanya untuk Allah. Semoga keselamatan terlimpah kepadamu wahai Nabi, beserta rahmat dan berkah Allah. Semoga keselamatan terlimpah pula kepada kami dan kepada hamba-hamba Allah yang sholeh. Aku bersaksi bahwa tidak ada Tuhan selain Allah, dan aku bersaksi bahwa Muhammad adalah hamba dan utusan-Nya.',
'Salam dan penghormatan untuk Allah dan Nabi Muhammad.',
'/static/audio/dewasa/11_tasyahud_awal.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 12. Tasyahud Akhir + Shalawat
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(12, 1,
'التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللهِ الصَّالِحِينَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
'At-tahiyyātu lillāhi wash-shalawātu wash-thayyibāt. As-salāmu ''alaika ayyuhan-nabiyyu wa rahmatullāhi wa barakātuh. As-salāmu ''alainā wa ''alā ''ibādillāhish-shālihīn. Asyhadu an lā ilāha illallāh wa asyhadu anna Muhammadan ''abduhu wa rasūluh.',
'Segala penghormatan, sholawat, dan kebaikan hanya untuk Allah. Semoga keselamatan terlimpah kepadamu wahai Nabi, beserta rahmat dan berkah Allah. Semoga keselamatan terlimpah pula kepada kami dan kepada hamba-hamba Allah yang sholeh. Aku bersaksi bahwa tidak ada Tuhan selain Allah, dan aku bersaksi bahwa Muhammad adalah hamba dan utusan-Nya.',
'Salam untuk Allah dan Nabi Muhammad.',
'/static/audio/dewasa/12_tasyahud_akhir.mp3',
'HPT Muhammadiyah, Kitab Shalat');

INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(12, 2,
'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ وَبَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ فِي الْعَالَمِينَ إِنَّكَ حَمِيدٌ مَجِيدٌ',
'Allāhumma shalli ''alā Muhammad wa ''alā āli Muhammad kamā shallaita ''alā Ibrāhīm wa ''alā āli Ibrāhīm. Wa bārik ''alā Muhammad wa ''alā āli Muhammad kamā bārakta ''alā Ibrāhīm wa ''alā āli Ibrāhīm fil ''ālamīn. Innaka hamīdun majīd.',
'Ya Allah, limpahkanlah shalawat kepada Muhammad dan keluarga Muhammad, sebagaimana Engkau telah melimpahkan shalawat kepada Ibrahim dan keluarga Ibrahim. Dan berkahilah Muhammad dan keluarga Muhammad sebagaimana Engkau telah memberkahi Ibrahim dan keluarga Ibrahim di alam semesta ini. Sesungguhnya Engkau Maha Terpuji lagi Maha Mulia.',
'Ya Allah, berikan shalawat untuk Nabi Muhammad dan Nabi Ibrahim.',
'/static/audio/dewasa/12_shalawat.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- 13. Salam
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber) VALUES
(13, 1,
'السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللهِ',
'Assalāmu''alaikum wa rahmatullāh',
'Semoga keselamatan dan rahmat Allah terlimpah kepada kalian',
'Semoga keselamatan untuk kalian semua',
'/static/audio/dewasa/13_salam.mp3',
'HPT Muhammadiyah, Kitab Shalat');

-- Salin bacaan untuk mode anak (gerakan id 14-26 = mode anak)
-- Bacaan diambil dari gerakan mode dewasa, disesuaikan id_gerakan.
-- audio_url diarahkan ke folder /static/audio/anak/ (rekaman versi anak-anak),
-- berbeda dari mode dewasa yang memakai /static/audio/dewasa/.
INSERT INTO bacaan (id_gerakan, urutan, teks_arab, teks_latin, terjemahan, terjemahan_ringkas, audio_url, sumber)
SELECT g2.id, b.urutan, b.teks_arab, b.teks_latin, b.terjemahan, b.terjemahan_ringkas,
       REPLACE(b.audio_url, '/static/audio/dewasa/', '/static/audio/anak/'), b.sumber
FROM bacaan b
JOIN gerakan g1 ON b.id_gerakan = g1.id
JOIN gerakan g2 ON g1.urutan = g2.urutan AND g2.id_kategori = 2
WHERE g1.id_kategori = 1;
