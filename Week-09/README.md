# Codelab #09 — Kamera (Praktikum 1, 2 & Tugas)

---

## Praktikum 1 — Mengambil Foto

1. File utama: `src/kamera_filter_27/lib/main.dart`.
2. Alur kerja:
   - `main()` memanggil `WidgetsFlutterBinding.ensureInitialized()` karena kita membutuhkan binding Flutter sebelum memanggil `availableCameras()` (fungsi async yang mengakses platform)
   - Mengambil daftar kamera dengan `availableCameras()` lalu memilih kamera pertama.
   - Menjalankan `MyApp(camera: firstCamera)` yang menampilkan `TakePictureScreen`.
3. `TakePictureScreen` (stateful):
   - Membuat `CameraController` di `initState()` dan menyimpan `Future` inisialisasi di `_initializeControllerFuture`.
   - Menampilkan `CameraPreview(_controller)` setelah controller siap (menggunakan `FutureBuilder`).
   - Saat menekan tombol kamera (FloatingActionButton), program memanggil `await _controller.takePicture()` untuk mengambil foto, lalu menavigasi ke layar carousel dengan path file foto.

Hasil : <br>
![Output](img/01.webp)

### Catatan penting (praktikum 1)

- Pastikan aplikasi meminta permission kamera di AndroidManifest/Info.plist bila dijalankan di perangkat nyata.
- Jika `availableCameras()` mengembalikan list kosong, tampilkan pesan error atau fallback.

## Praktikum 2 — Photo Filter Carousel

1. File utama: `src/photo_filter_carousel_27/lib/widget/filter_carousel.dart` (juga ada versi serupa di `src/kamera_filter_27`).
2. Alur kerja:
   - Widget `PhotoFilterCarousel` menampilkan sebuah foto (bisa dari `Image.network` atau `Image.file`) dan sebuah daftar filter (warna) di bagian bawah.
   - Memanfaatkan `ValueNotifier<Color>` untuk menyimpan warna filter terpilih dan `ValueListenableBuilder` untuk merender ulang gambar dengan `color` dan `colorBlendMode`.
   - `FilterSelector` (widget terpisah) menampilkan pilihan warna secara horizontal (carousel) dan memanggil callback `onFilterChanged` ketika pilihan berubah.

Hasil :<br>
![Output](img/02.webp)

## Tugas Praktikum — Penggabungan

Tujuan: setelah mengambil foto pada aplikasi kamera, foto langsung diteruskan ke layar filter carousel agar pengguna bisa mengaplikasikan filter.

Langkah yang dilakukan / cara menguji:

1. Pastikan pada proyek `src/kamera_filter_27`:

   - `TakePictureScreen` setelah mengambil foto memanggil:
     - `final image = await _controller.takePicture();`
     - `Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhotoFilterCarousel(imagePath: image.path)));`
   - File `lib/widget/filter_carousel.dart` pada `kamera_filter_27` menerima `imagePath` pada konstruktor dan menggunakan `Image.file(File(widget.imagePath))` untuk menampilkan foto yang baru diambil.

2. Jika Anda ingin menggabungkan kode dari `photo_filter_carousel_27` ke `kamera_filter_27`, perhatikan:

   - Pada `photo_filter_carousel_27` versi demo, `PhotoFilterCarousel` tidak menerima `imagePath` (menggunakan `Image.network`). Anda perlu menambahkan parameter `imagePath` dan fallback ke `Image.network` bila nilai kosong.
   - Pastikan `filter_selector` (widget) jika membutuhkan preview atau thumbnail menerima `imagePath` sehingga preview menampilkan foto yang sama.

3. Edge cases yang diuji:
   - Foto tidak tersimpan / path tidak valid -> tampilkan fallback UI.
   - Permission kamera ditolak -> tampilkan pesan instruktif.
   - Gagal memuat file (I/O error) -> jangan crash, tampilkan warna latar fallback.

Hasil gabungan:<br>
![Output](img/03.webp)

## Jawaban Pertanyaan

1. Jelaskan maksud `void async` pada praktikum 1

   - Sebenarnya deklarasi fungsi `void main() async { ... }` berarti fungsi `main` bersifat asynchronous sehingga bisa menggunakan `await` di dalamnya.
   - `async` mengubah fungsi agar mengembalikan `Future` (meskipun ditulis `void` pada signature), sehingga kita dapat menunggu operasi async seperti `availableCameras()` sebelum memanggil `runApp()`.

2. Jelaskan fungsi dari anotasi `@immutable` dan `@override`

   - `@immutable` (dari package `meta`) menandakan bahwa semua field dalam kelas harus bersifat final; ini membantu memaksa gaya pemrograman immutable untuk widget yang seharusnya tidak berubah setelah dibuat.
   - `@override` adalah anotasi yang menandai bahwa sebuah method menimpa (override) method pada superclass; membantu pembaca kode dan memberi peringatan jika tanda tangan method tidak sesuai dengan superclass.
