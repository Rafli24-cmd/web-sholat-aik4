from flask import Flask, render_template, jsonify, request, redirect, url_for
import sqlite3
import os

app = Flask(__name__)
app.secret_key = 'sholat-kelompok6-ump-2024'

DATABASE = os.path.join(os.path.dirname(__file__), 'instance', 'sholat.db')


# ─────────────────────────────────────────────
# HELPER: koneksi database
# ─────────────────────────────────────────────
def get_db():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    return conn


def init_db():
    """Inisialisasi database dari schema.sql jika belum ada."""
    os.makedirs(os.path.dirname(DATABASE), exist_ok=True)
    if not os.path.exists(DATABASE):
        with get_db() as conn:
            with open(os.path.join(os.path.dirname(__file__), 'schema.sql'), 'r', encoding='utf-8') as f:
                conn.executescript(f.read())
        print("✅ Database berhasil diinisialisasi.")


# ─────────────────────────────────────────────
# ROUTE: Halaman Utama / Beranda
# ─────────────────────────────────────────────
@app.route('/')
def index():
    with get_db() as conn:
        kelompok = conn.execute('SELECT * FROM kelompok LIMIT 1').fetchone()
    return render_template('index.html', kelompok=kelompok)


# ─────────────────────────────────────────────
# ROUTE: Daftar Gerakan (pilih mode)
# ─────────────────────────────────────────────
@app.route('/sholat/<mode>')
def daftar_gerakan(mode):
    """
    mode: 'dewasa' atau 'anak'
    Menampilkan daftar semua gerakan sholat sesuai mode.
    """
    if mode not in ('dewasa', 'anak'):
        return redirect(url_for('index'))

    with get_db() as conn:
        kelompok = conn.execute('SELECT * FROM kelompok LIMIT 1').fetchone()
        kategori = conn.execute(
            'SELECT * FROM kategori WHERE nama = ?', (mode,)
        ).fetchone()

        if not kategori:
            return redirect(url_for('index'))

        gerakan_list = conn.execute(
            'SELECT * FROM gerakan WHERE id_kategori = ? ORDER BY urutan',
            (kategori['id'],)
        ).fetchall()

    return render_template(
        'daftar_gerakan.html',
        kelompok=kelompok,
        gerakan_list=gerakan_list,
        mode=mode
    )


# ─────────────────────────────────────────────
# ROUTE: Detail Gerakan
# ─────────────────────────────────────────────
@app.route('/sholat/<mode>/gerakan/<int:urutan>')
def detail_gerakan(mode, urutan):
    """
    Menampilkan detail satu gerakan beserta bacaan lengkapnya.
    Mendukung navigasi Next/Previous.
    """
    if mode not in ('dewasa', 'anak'):
        return redirect(url_for('index'))

    with get_db() as conn:
        kelompok = conn.execute('SELECT * FROM kelompok LIMIT 1').fetchone()
        kategori = conn.execute(
            'SELECT * FROM kategori WHERE nama = ?', (mode,)
        ).fetchone()

        if not kategori:
            return redirect(url_for('index'))

        gerakan = conn.execute(
            'SELECT * FROM gerakan WHERE id_kategori = ? AND urutan = ?',
            (kategori['id'], urutan)
        ).fetchone()

        if not gerakan:
            return redirect(url_for('daftar_gerakan', mode=mode))

        bacaan_list = conn.execute(
            'SELECT * FROM bacaan WHERE id_gerakan = ? ORDER BY urutan',
            (gerakan['id'],)
        ).fetchall()

        # Total gerakan untuk navigasi
        total = conn.execute(
            'SELECT COUNT(*) as total FROM gerakan WHERE id_kategori = ?',
            (kategori['id'],)
        ).fetchone()['total']

        # Gerakan sebelum & sesudah
        prev_gerakan = conn.execute(
            'SELECT urutan FROM gerakan WHERE id_kategori = ? AND urutan < ? ORDER BY urutan DESC LIMIT 1',
            (kategori['id'], urutan)
        ).fetchone()

        next_gerakan = conn.execute(
            'SELECT urutan FROM gerakan WHERE id_kategori = ? AND urutan > ? ORDER BY urutan ASC LIMIT 1',
            (kategori['id'], urutan)
        ).fetchone()

        # Semua gerakan untuk sidebar / klik langsung
        semua_gerakan = conn.execute(
            'SELECT id, nama, urutan FROM gerakan WHERE id_kategori = ? ORDER BY urutan',
            (kategori['id'],)
        ).fetchall()

    return render_template(
        'detail_gerakan.html',
        kelompok=kelompok,
        gerakan=gerakan,
        bacaan_list=bacaan_list,
        mode=mode,
        total=total,
        prev_urutan=prev_gerakan['urutan'] if prev_gerakan else None,
        next_urutan=next_gerakan['urutan'] if next_gerakan else None,
        semua_gerakan=semua_gerakan
    )


# ─────────────────────────────────────────────
# API: Data semua gerakan (untuk autoplay JS)
# ─────────────────────────────────────────────
@app.route('/api/gerakan/<mode>')
def api_gerakan(mode):
    """
    Mengembalikan JSON daftar semua gerakan + bacaan untuk keperluan autoplay.
    """
    if mode not in ('dewasa', 'anak'):
        return jsonify({'error': 'Mode tidak valid'}), 400

    with get_db() as conn:
        kategori = conn.execute(
            'SELECT * FROM kategori WHERE nama = ?', (mode,)
        ).fetchone()

        if not kategori:
            return jsonify({'error': 'Kategori tidak ditemukan'}), 404

        gerakan_list = conn.execute(
            'SELECT * FROM gerakan WHERE id_kategori = ? ORDER BY urutan',
            (kategori['id'],)
        ).fetchall()

        result = []
        for g in gerakan_list:
            bacaan_list = conn.execute(
                'SELECT * FROM bacaan WHERE id_gerakan = ? ORDER BY urutan',
                (g['id'],)
            ).fetchall()

            result.append({
                'id': g['id'],
                'urutan': g['urutan'],
                'nama': g['nama'],
                'deskripsi': g['deskripsi'] if mode == 'dewasa' else g['deskripsi_anak'],
                'gambar_url': g['gambar_url'],
                'video_url': g['video_url'],
                'bacaan': [{
                    'id': b['id'],
                    'urutan': b['urutan'],
                    'teks_arab': b['teks_arab'],
                    'teks_latin': b['teks_latin'],
                    'terjemahan': b['terjemahan'] if mode == 'dewasa' else b['terjemahan_ringkas'],
                    'audio_url': b['audio_url'],
                    'sumber': b['sumber']
                } for b in bacaan_list]
            })

    return jsonify(result)


# ─────────────────────────────────────────────
# API: Data satu gerakan (untuk navigasi cepat)
# ─────────────────────────────────────────────
@app.route('/api/gerakan/<mode>/<int:urutan>')
def api_detail_gerakan(mode, urutan):
    if mode not in ('dewasa', 'anak'):
        return jsonify({'error': 'Mode tidak valid'}), 400

    with get_db() as conn:
        kategori = conn.execute(
            'SELECT * FROM kategori WHERE nama = ?', (mode,)
        ).fetchone()

        gerakan = conn.execute(
            'SELECT * FROM gerakan WHERE id_kategori = ? AND urutan = ?',
            (kategori['id'], urutan)
        ).fetchone()

        if not gerakan:
            return jsonify({'error': 'Gerakan tidak ditemukan'}), 404

        bacaan_list = conn.execute(
            'SELECT * FROM bacaan WHERE id_gerakan = ? ORDER BY urutan',
            (gerakan['id'],)
        ).fetchall()

        total = conn.execute(
            'SELECT COUNT(*) as total FROM gerakan WHERE id_kategori = ?',
            (kategori['id'],)
        ).fetchone()['total']

    return jsonify({
        'id': gerakan['id'],
        'urutan': gerakan['urutan'],
        'nama': gerakan['nama'],
        'deskripsi': gerakan['deskripsi'] if mode == 'dewasa' else gerakan['deskripsi_anak'],
        'gambar_url': gerakan['gambar_url'],
        'video_url': gerakan['video_url'],
        'total': total,
        'bacaan': [{
            'id': b['id'],
            'urutan': b['urutan'],
            'teks_arab': b['teks_arab'],
            'teks_latin': b['teks_latin'],
            'terjemahan': b['terjemahan'] if mode == 'dewasa' else b['terjemahan_ringkas'],
            'audio_url': b['audio_url'],
            'sumber': b['sumber']
        } for b in bacaan_list]
    })


# ─────────────────────────────────────────────
# JALANKAN APLIKASI
# ─────────────────────────────────────────────
if __name__ == '__main__':
    init_db()
    app.run(debug=True, host='0.0.0.0', port=5000)
