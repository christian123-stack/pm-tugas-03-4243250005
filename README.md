# Tugas Rutin 3 — Kalkulator IP Semester

**Nama:** Christian Nicholas Sinaga  
**NIM:** 4243250005  
**Kelas:** PSIK 24C

## Deskripsi

Program console menerima mata kuliah satu per satu sampai nama dikosongkan.
SKS yang valid adalah 1–6 dan nilai huruf A–E. Data dengan input tidak valid
diabaikan, lalu program mencetak Kartu Hasil Studi dengan IP semester,
predikat, dan daftar mata kuliah yang memiliki SKS kurang dari 2.

## Menjalankan dan memeriksa

Jalankan dari folder proyek:

```powershell
dart pub get
dart run bin/main.dart
dart analyze
dart test
```

Contoh masukan (baris kosong pada Nama MK mengakhiri input):

```text
Pemrograman Mobile
3
A
Jaringan Komputer
tiga
B
Statistika
2
B
```

## Closures, higher-order functions, dan error handling (100–200 kata)

Di `lib/khs.dart`, fungsi `hitungIp` menggunakan `fold` untuk mengakumulasi
jumlah SKS dan total bobot nilai secara berbobot. Callback pada `fold` adalah
closure: fungsi kecil yang menerima nilai akumulasi dan mata kuliah berikutnya.
Pada `cetakKhs`, `where` memakai closure predikat untuk memilih mata kuliah
dengan SKS kurang dari dua. Jika opsi `urutkan` bernilai benar, `sort`
menerima closure pembanding yang mengurutkan bobot tertinggi lebih dahulu.
Karena fungsi-fungsi tersebut menerima fungsi lain sebagai argumen, `fold`,
`where`, dan `sort` menjadi contoh higher-order functions. Validasi input
dilakukan oleh `validasiMataKuliah`; SKS bukan angka 1–6 atau nilai di luar A–E
menyebabkan `FormatException`. Fungsi `main` menangkap exception tersebut,
menampilkan alasan data ditolak, lalu melanjutkan input berikutnya tanpa
menghentikan aplikasi. Dengan demikian, satu kesalahan tidak menghilangkan
data mata kuliah lain yang sudah valid.

## Bukti tangkapan layar

### KHS dari data valid

Tangkapan layar menunjukkan tiga mata kuliah diterima, total 8 SKS, dan IP
3,63 dengan predikat Dengan Pujian.

![Contoh KHS dari input valid](screenshots/khs-valid.png)

### Penanganan input nilai tidak valid

Nilai huruf `Z` ditolak dengan pesan kesalahan, dan program mengabaikan data
tersebut alih-alih berhenti.

![Input nilai huruf tidak valid](screenshots/khs-input-invalid.png)

## Penggunaan AI

AI digunakan sebagai bantuan untuk menyusun implementasi, kasus uji, dan draf
README. Program diperiksa dengan `dart analyze` dan `dart test`.