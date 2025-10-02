# **Codelab #06 | Layout dan Navigasi**

---

## **Praktikum 1: Membangun Layout di Flutter**

### **Langkah 1: Buat Project Baru**

> Buatlah sebuah project flutter baru dengan nama layout_flutter. Atau sesuaikan style laporan praktikum yang Anda buat.

![Output](img/01.png)

### **Langkah 2: Buka file lib/main.dart**

> Buka file main.dart lalu ganti dengan kode berikut. Isi nama dan NIM Anda di text title

![Output](img/02.png)

### **Langkah 3: Identifikasi layout diagram**

> 1. Struktur utama, Satu kolom besar yang berisi:
>
> - Gambar (banner)
> - Baris Judul
> - Baris Tombol
> - Blok teks deskripsi
>
> 2. Baris Judul:
>
> - Kolom teks (judul + subjudul) → dibungkus Expanded agar fleksibel
> - Ikon bintang
> - Angka rating
>
> 3. Baris Tombol:
>
> - 3 kolom, masing-masing berisi ikon + teks (misal: Call, Route, Share)
>
> 4. Layout tambahan:
>
> - Menggunakan grid sederhana (Row/Column)
> - Tidak ada elemen tumpang-tindih
> - Alignment, padding, dan border diatur agar rapi

### **Langkah 4 : Implementasi title row**
