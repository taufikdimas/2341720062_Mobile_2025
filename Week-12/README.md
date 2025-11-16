# Praktikum 1: Dart Streams

Selesaikan langkah-langkah praktikum berikut ini menggunakan editor Visual Studio Code (VS Code) atau Android Studio atau code editor lain kesukaan Anda. Jawablah di laporan praktikum Anda (ketik di README.md) pada setiap soal yang ada di beberapa langkah praktikum ini.

# Langkah 1: Buat Project Baru

Buatlah sebuah project flutter baru dengan nama stream_nama (beri nama panggilan Anda) di folder week-12/src/ repository GitHub Anda.

# Langkah 2: Buka file main.dart

Ketiklah kode seperti berikut ini.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}
```

```dart
class _StreamHomePageState extends State<StreamHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

## Soal 1

Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.

```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Taufik',
```

Gantilah warna tema aplikasi sesuai kesukaan Anda.
Lakukan commit hasil jawaban Soal 1 dengan pesan "W12: Jawaban Soal 1"

```dart
primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          secondary: Colors.pink,
          tertiary: Colors.orange,
```

# Langkah 3: Buat file baru stream.dart

Buat file baru di folder lib project Anda. Lalu isi dengan kode berikut.

```dart
import 'package:flutter/material.dart';

class ColorStream {

}
```

# Langkah 4: Tambah variabel colors

Tambahkan variabel di dalam class ColorStream seperti berikut.

```dart
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
  ];
```

## Soal 2

### Tambahkan 5 warna lainnya sesuai keinginan Anda pada variabel colors tersebut.

```dart
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    // Soal 2: Menambahkan warna sesuai keinginan
    Colors.pink,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.indigo,
  ];
```

### Lakukan commit hasil jawaban Soal 2 dengan pesan "W12: Jawaban Soal 2"

# Langkah 5: Tambah method getColors()

Di dalam class ColorStream ketik method seperti kode berikut. Perhatikan tanda bintang di akhir keyword async\* (ini digunakan untuk melakukan Stream data)

```dart
Stream<Color> getColors() async* {
}
```

# Langkah 6: Tambah perintah yield\*

Tambahkan kode berikut ini.

```dart
yield* Stream.periodic(
  const Duration(seconds: 1), (int t) {
    int index = t % colors.length;
    return colors[index];
});
```

## Soal 3

### Jelaskan fungsi keyword yield\* pada kode tersebut!

Jawab: yield* digunakan untuk mengalirkan (delegate) seluruh nilai dari Stream lain ke dalam Stream yang sedang dibuat. Berbeda dengan yield yang mengirimkan satu nilai, yield* mengirimkan semua nilai dari Stream secara berurutan.

### Apa maksud isi perintah kode tersebut?

Jawab: konstruksi ini membentuk stream yang memancarkan data setiap satu detik. Parameter t berperan sebagai penghitung yang bertambah secara berurutan, lalu diproyeksikan ke dalam rentang indeks list colors melalui operasi modulo agar tetap valid. Dari hasil tersebut, warna dipilih sesuai indeks dan dikirimkan ke stream. Dengan mekanisme siklik ini, warna akan berganti tiap detik dan kembali ke awal setelah mencapai elemen terakhir, sehingga tercipta aliran data yang berulang tanpa henti.

### Lakukan commit hasil jawaban Soal 3 dengan pesan "W12: Jawaban Soal 3"

# Langkah 7: Buka main.dart

Ketik kode impor file ini pada file main.dart

```dart
import 'stream.dart';
```

# Langkah 8: Tambah variabel

Ketik dua properti ini di dalam class \_StreamHomePageState

```dart
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;
```

# Langkah 9: Tambah method changeColor()

Tetap di file main, Ketik kode seperti berikut

```dart
  void changeColor() async {
    await for (var eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }
  }
```

# Langkah 10: Lakukan override initState()

Ketika kode seperti berikut:

```dart
  @override
  void initState() {
    super.initState();
    colorStream = ColorStream();
    changeColor();
  }
```

# Langkah 11: Ubah isi Scaffold()

Sesuaikan kode seperti berikut.

```dart
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Taufik'),
      ),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
      ),
    );
  }
```

# Langkah 12: Run

Lakukan running pada aplikasi Flutter Anda, maka akan terlihat berubah warna background setiap detik.

## Soal 4

## Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

![doksli](img/Praktikum1_Dart%20Stream.gif)

## Lakukan commit hasil jawaban Soal 4 dengan pesan "W12: Jawaban Soal 4"

# Langkah 13: Ganti isi method changeColor()

Anda boleh comment atau hapus kode sebelumnya, lalu ketika kode seperti berikut.

## Soal 5

### Jelaskan perbedaan menggunakan listen dan await for (langkah 9) !

Perbedaan antara `await for` dan `listen()` terletak pada mekanisme eksekusi dan pengelolaan aliran data stream. Konstruksi `await for` menerapkan pendekatan sinkron-blocking yang mengiterasi setiap event secara berurutan dan menghentikan eksekusi kode selanjutnya hingga stream berakhir atau dibatalkan, sehingga cocok untuk pemrosesan data yang memerlukan urutan ketat. Sebaliknya, metode `listen()` mengimplementasikan pola asinkron-non-blocking dengan melakukan subscription terhadap stream dan langsung melanjutkan eksekusi kode berikutnya tanpa menunggu, memberikan fleksibilitas lebih tinggi melalui kemampuan penanganan error, callback completion, serta kontrol subscription yang dapat dibatalkan kapan saja, menjadikannya lebih optimal untuk aplikasi Flutter yang memerlukan responsivitas antarmuka pengguna.

### Lakukan commit hasil jawaban Soal 5 dengan pesan "W12: Jawaban Soal 5"

# Praktikum 2: Stream controllers dan sinks

StreamControllers akan membuat jembatan antara Stream dan Sink. Stream berisi data secara sekuensial yang dapat diterima oleh subscriber manapun, sedangkan Sink digunakan untuk mengisi (injeksi) data.

Secara sederhana, StreamControllers merupakan stream management. Ia akan otomatis membuat stream dan sink serta beberapa method untuk melakukan kontrol terhadap event dan fitur-fitur yang ada di dalamnya.

Anda dapat membayangkan stream sebagai pipa air yang mengalir searah, dari salah satu ujung Anda dapat mengisi data dan dari ujung lain data itu keluar. Anda dapat melihat konsep stream pada gambar diagram berikut ini.

## Langkah 1: Buka file stream.dart

Lakukan impor dengan mengetik kode ini.

```dart
import 'dart:async';
```

## Langkah 2: Tambah class NumberStream

Tetap di file stream.dart tambah class baru seperti berikut.

```dart
class NumberStream {
}
```

## Langkah 3: Tambah StreamController

Di dalam class NumberStream buatlah variabel seperti berikut.

```dart
final StreamController<int> controller = StreamController<int>();
```

## Langkah 4: Tambah method addNumberToSink

Tetap di class NumberStream buatlah method ini

```dart
  void addNumberToSink(int newNumber) {
    controller.sink.add(newNumber);
  }
```

## Langkah 5: Tambah method close()

```dart
  close() {
    controller.close();
  }
```

## Langkah 6: Buka main.dart

Ketik kode import seperti berikut

```dart
import 'dart:async';
import 'dart:math';
```

## Langkah 7: Tambah variabel

Di dalam class \_StreamHomePageState ketik variabel berikut

```dart
  int lastNumber = 0;
  late StreamController numberStreamController;
  late NumberStream numberStream;
```

## Langkah 8: Edit initState()

```dart
  @override
  void initState() {
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream;
    stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });
    super.initState();
  }
```

## Langkah 9: Edit dispose()

```dart
  @override
  void dispose() {
    numberStreamController.close();
    super.dispose();
  }
```

## Langkah 10: Tambah method addRandomNumber()

```dart
void addRandomNumber() {
  Random random = Random();
  int myNum = random.nextInt(10);
  numberStream.addNumberToSink(myNum);
}
```

## Langkah 11: Edit method build()

```dart
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(lastNumber.toString()),
            ElevatedButton(
              onPressed: () => addRandomNumber(),
              child: const Text('New Random Number'),
            )
          ],
        ),
      ),
```

## Langkah 12: Run

Lakukan running pada aplikasi Flutter Anda, maka akan terlihat seperti gambar berikut.

## Soal 6

#### Jelaskan maksud kode langkah 8 dan 10 tersebut!

**Langkah 8 (initState):**

Kode pada `initState()` berfungsi untuk melakukan inisialisasi dan konfigurasi stream saat widget pertama kali dibuat. Tahapan yang dilakukan meliputi pembuatan instance `NumberStream` sebagai sumber data, pengambilan referensi `StreamController` untuk mengakses stream-nya, kemudian melakukan subscription terhadap stream tersebut menggunakan method `listen()`. Setiap kali ada event (data baru) yang dipancarkan melalui stream, listener akan menangkapnya dan memanggil `setState()` untuk memperbarui nilai variabel `lastNumber`, yang kemudian memicu rebuild widget untuk menampilkan nilai terbaru di UI. Mekanisme ini menciptakan reaktivitas data dimana perubahan pada stream secara otomatis tercermin pada tampilan aplikasi.

**Langkah 10 (addRandomNumber):**

Method `addRandomNumber()` berperan sebagai trigger untuk menginjeksikan data ke dalam stream. Prosesnya dimulai dengan membuat instance `Random` untuk menghasilkan angka acak, kemudian menggunakan `nextInt(10)` untuk mendapatkan bilangan bulat acak dalam rentang 0 hingga 9. Angka yang dihasilkan tersebut kemudian dikirimkan ke stream melalui method `addNumberToSink()` dari `NumberStream`, yang secara internal memanfaatkan `controller.sink.add()` untuk memasukkan data ke dalam stream. Data ini selanjutnya akan ditangkap oleh listener yang telah didefinisikan pada `initState()`, menciptakan alur data searah dari source (sink) menuju subscriber (listener) yang merupakan konsep fundamental dari arsitektur stream.

#### Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

![doksli](img/Praktikum2_Stream%20controllers%20dan%20sinks.gif)

#### Lalu lakukan commit dengan pesan "W12: Jawaban Soal 6".

---

## Langkah 13: Buka stream.dart

Tambahkan method berikut ini.

```dart
  addError() {
    controller.sink.addError('error');
  }
```

## Langkah 14: Buka main.dart

Tambahkan method onError di dalam class StreamHomePageState pada method listen di fungsi initState() seperti berikut ini.

```dart
  @override
  void initState() {
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream;
    stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    }).onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });
    super.initState();
  }
```

## Langkah 15: Edit method addRandomNumber()

Lakukan comment pada dua baris kode berikut, lalu ketik kode seperti berikut ini.

```dart
  void addRandomNumber() {
    Random random = Random();
    // int myNum = random.nextInt(10);
    // numberStream.addNumberToSink(myNum);
    numberStream.addError();
  }
```

## Soal 7

### Jelaskan maksud kode langkah 13 sampai 15 tersebut!

Ketiga langkah tersebut mengimplementasikan mekanisme error handling dalam stream untuk menangani kondisi eksepsional yang mungkin terjadi selama pemrosesan data.

**Langkah 13** menambahkan method `addError()` pada class `NumberStream` yang berfungsi sebagai interface untuk menginjeksikan error ke dalam stream melalui `controller.sink.addError()`, memungkinkan simulasi atau penanganan kondisi error secara terkontrol.

**Langkah 14** melengkapi listener dengan callback `onError()` yang akan terpicu ketika stream mengirimkan error, dimana implementasinya mengubah nilai `lastNumber` menjadi -1 sebagai indikator visual bahwa telah terjadi error, memberikan feedback kepada pengguna tentang kondisi abnormal aplikasi.

**Langkah 15** memodifikasi method `addRandomNumber()` untuk men-trigger error dengan memanggil `numberStream.addError()` sebagai pengganti pengiriman data normal, berfungsi sebagai simulasi untuk menguji apakah mekanisme error handling bekerja dengan baik. Kombinasi ketiga langkah ini menciptakan alur error handling yang lengkap: dari injeksi error (source), propagasi melalui stream, hingga penanganan di subscriber (listener), yang merupakan praktik penting dalam pengembangan aplikasi robust untuk menangani skenario failure dengan graceful degradation.

### Kembalikan kode seperti semula pada Langkah 15, comment addError() agar Anda dapat melanjutkan ke praktikum 3 berikutnya.

```dart
  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    numberStream.addNumberToSink(myNum);
    // numberStream.addError();
  }
```

#### Lakukan commit dengan pesan "W12: Jawaban Soal 7".

---

# Praktikum 3: Injeksi data ke streams

Skenario yang umum dilakukan adalah melakukan manipulasi atau transformasi data stream sebelum sampai pada UI end user. Hal ini sangatlah berguna ketika Anda membutuhkan untuk filter data berdasarkan kondisi tertentu, melakukan validasi data, memodifikasinya, atau melakukan proses lain yang memicu beberapa output baru. Contohnya melakukan konversi angka ke string, membuat sebuah perhitungan, atau menghilangkan data yang berulang terus tampil.

Pada praktikum 3 ini, Anda akan menggunakan StreamTransformers ke dalam stream untuk melakukan map dan filter data.

Setelah Anda menyelesaikan praktikum 2, Anda dapat melanjutkan praktikum 3 ini. Selesaikan langkah-langkah praktikum berikut ini menggunakan editor Visual Studio Code (VS Code) atau Android Studio atau code editor lain kesukaan Anda. Jawablah di laporan praktikum Anda pada setiap soal yang ada di beberapa langkah praktikum ini.

## Langkah 1: Buka main.dart

Tambahkan variabel baru di dalam class \_StreamHomePageState

```dart
  late StreamTransformer transformer;
```

## Langkah 2: Tambahkan kode ini di initState

```dart
    transformer = StreamTransformer<int, int>.fromHandlers(
      handleData: (value, sink) {
        sink.add(value * 10);
      },
      handleError: (error, trace, sink) {
        sink.add(-1);
      },
      handleDone: (sink) => sink.close(),
    );
```

## Langkah 3: Tetap di initState

Lakukan edit seperti kode berikut.

```dart
    stream.transform(transformer).listen((event) {
      setState(() {
        lastNumber = event;
      });
    }).onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });
```

## Langkah 4: Run

Terakhir, run atau tekan F5 untuk melihat hasilnya jika memang belum running. Bisa juga lakukan hot restart jika aplikasi sudah running. Maka hasilnya akan seperti gambar berikut ini. Anda akan melihat tampilan angka dari 0 hingga 90.

## Soal 8

### Jelaskan maksud kode langkah 1-3 tersebut!

Ketiga langkah tersebut mengimplementasikan transformasi data stream menggunakan `StreamTransformer` untuk memodifikasi nilai sebelum sampai ke listener. **Langkah 1** mendeklarasikan variabel `transformer` bertipe `StreamTransformer` yang akan berfungsi sebagai middleware untuk memproses data stream. **Langkah 2** melakukan inisialisasi transformer dengan `StreamTransformer<int, int>.fromHandlers()` yang mendefinisikan tiga handler: `handleData` untuk mentransformasi setiap nilai input dengan mengalikannya 10 (misalnya angka 5 menjadi 50), `handleError` untuk menangani error dengan mengubahnya menjadi nilai -1, dan `handleDone` untuk menutup sink ketika stream selesai. **Langkah 3** mengaplikasikan transformer ke stream menggunakan method `transform()` sebelum melakukan subscription dengan `listen()`, sehingga setiap data yang melewati stream akan terlebih dahulu ditransformasi (dikali 10) sebelum diterima oleh listener dan di-update ke UI melalui `setState()`. Mekanisme ini mendemonstrasikan konsep data pipeline dalam reactive programming, dimana data dapat diproses dan dimodifikasi secara deklaratif sebelum mencapai destination akhir, memungkinkan pemisahan logic transformasi dari logic presentasi untuk arsitektur yang lebih maintainable.

#### Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

![Stream Transformer](img/Praktikum3_Lanjutan%20State%20Management%20dengan%20Streams.gif)

#### Lakukan commit dengan pesan "W12: Jawaban Soal 8".

---

# Praktikum 4: Subscribe ke stream events

Dari praktikum sebelumnya, Anda telah menggunakan method listen mendapatkan nilai dari stream. Ini akan menghasilkan sebuah Subscription. Subscription berisi method yang dapat digunakan untuk melakukan listen pada suatu event dari stream secara terstruktur.

Pada praktikum 4 ini, kita akan gunakan Subscription untuk menangani event dan error dengan teknik praktik baik (best practice), dan menutup Subscription tersebut.

Setelah Anda menyelesaikan praktikum 3, Anda dapat melanjutkan praktikum 4 ini. Selesaikan langkah-langkah praktikum berikut ini menggunakan editor Visual Studio Code (VS Code) atau Android Studio atau code editor lain kesukaan Anda. Jawablah di laporan praktikum Anda pada setiap soal yang ada di beberapa langkah praktikum ini.

## Langkah 1: Tambah variabel

Tambahkan variabel berikut di class \_StreamHomePageState

```dart
  late StreamSubscription subscription;
```

## Langkah 2: Edit initState()

Edit kode seperti berikut ini.

```dart
    subscription = stream.transform(transformer).listen((event) {
      setState(() {
        lastNumber = event;
      });
    });
```

## Langkah 3: Tetap di initState()

Tambahkan kode berikut ini.

```dart
    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });
```

## Langkah 4: Tambah properti onDone()

Tambahkan dibawahnya kode ini setelah onError

```dart
    subscription.onDone(() {
      print('OnDone was called');
    });
```

## Langkah 5: Tambah method baru

Ketik method ini di dalam class \_StreamHomePageState

```dart
  void stopStream() {
    numberStreamController.close();
  }
```

## Langkah 6: Pindah ke method dispose()

Jika method dispose() belum ada, Anda dapat mengetiknya dan dibuat override. Ketik kode ini didalamnya.

```dart
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
```

## Langkah 7: Pindah ke method build()

Tambahkan button kedua dengan isi kode seperti berikut ini.

```dart
            ElevatedButton(
              onPressed: () => stopStream(),
              child: const Text('Stop Subscription'),
            ),
```

## Langkah 8: Edit method addRandomNumber()

Edit kode seperti berikut ini.

```dart
  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
  }
```

## Langkah 9: Run

Anda akan melihat dua button seperti gambar berikut.

## Langkah 10: Tekan button 'Stop Subscription'

Anda akan melihat pesan di Debug Console seperti berikut.

## Soal 9

### Jelaskan maksud kode langkah 2, 6 dan 8 tersebut!

**Langkah 2 (Edit initState):**

Pada langkah ini, hasil dari `stream.transform(transformer).listen()` disimpan ke dalam variabel `subscription` bertipe `StreamSubscription`. Berbeda dengan praktikum sebelumnya yang langsung melakukan chaining method, pendekatan ini menyimpan referensi subscription sehingga memungkinkan kontrol yang lebih eksplisit terhadap lifecycle stream. Dengan menyimpan subscription sebagai variabel instance, kita dapat mengakses method-method seperti `pause()`, `resume()`, `cancel()`, dan menambahkan callback seperti `onError()` dan `onDone()` secara terpisah, yang merupakan best practice dalam pengelolaan stream subscription untuk memastikan resource management yang proper.

**Langkah 6 (Edit dispose):**

Method `dispose()` dimodifikasi untuk memanggil `subscription.cancel()` sebagai pengganti `numberStreamController.close()`. Pemanggilan `cancel()` pada subscription sangat penting untuk mencegah memory leak dengan memutuskan listening terhadap stream ketika widget di-destroy. Ini merupakan implementasi proper cleanup dalam lifecycle widget Flutter, dimana setiap resource yang dialokasikan saat `initState()` harus dilepaskan saat `dispose()`. Dengan membatalkan subscription, kita memastikan bahwa tidak ada callback yang akan dipanggil setelah widget tidak lagi ada dalam widget tree, mencegah error yang muncul dari pemanggilan `setState()` pada widget yang sudah di-dispose.

**Langkah 8 (Edit addRandomNumber):**

Method ini ditambahkan dengan pengecekan kondisi `!numberStreamController.isClosed` sebelum mengirim data ke stream. Pengecekan ini mencegah error yang terjadi ketika mencoba menambahkan data ke stream yang sudah ditutup (closed). Jika controller masih terbuka, data akan dikirim normal melalui `addNumberToSink()`, namun jika sudah tertutup (misalnya setelah button 'Stop Subscription' ditekan), aplikasi akan menampilkan nilai -1 sebagai indikator bahwa stream sudah tidak aktif. Implementasi defensive programming ini meningkatkan robustness aplikasi dengan graceful handling terhadap operasi pada closed stream, menghindari exception yang dapat menyebabkan crash.

### Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

#### Hasil Subscribe stream Events

![Subscribe Stream Events](img/Praktikum4_Subscribe%20ke%20stream%20events.gif)

#### Hasil stop Subscribe stream Events

![awwwasss setop](img/praktikum4_stop%20subscribe%20stream%20events.jpg)

### Lalu lakukan commit dengan pesan "W12: Jawaban Soal 9".

---

# Praktikum 5: Multiple stream subscriptions

Secara default, stream hanya bisa digunakan untuk satu subscription. Jika Anda mencoba untuk melakukan subscription yang sama lebih dari satu, maka akan terjadi error. Untuk menangani hal itu, tersedia broadcast stream yang dapat digunakan untuk multiple subscriptions. Pada praktikum ini, Anda akan mencoba untuk melakukan multiple stream subscriptions.

Setelah Anda menyelesaikan praktikum 4, Anda dapat melanjutkan praktikum 5 ini. Selesaikan langkah-langkah praktikum berikut ini menggunakan editor Visual Studio Code (VS Code) atau Android Studio atau code editor lain kesukaan Anda. Jawablah di laporan praktikum Anda pada setiap soal yang ada di beberapa langkah praktikum ini.

## Langkah 1: Buka file main.dart

Ketik variabel berikut di class \_StreamHomePageState

```dart
  late StreamSubscription subscription2;
  String values = '';
```

## Langkah 2: Edit initState()

Ketik kode seperti berikut.

```dart
    subscription2 = stream.listen((event) {
      setState(() {
        values += '$event - ';
      });
    });
```

## Langkah 3: Run

Lakukan run maka akan tampil error seperti gambar berikut.

![Error Multiple Subscription](img/error%20praktikum%205.jpg)

## Soal 10

### Jelaskan mengapa error itu bisa terjadi ?

Error "Bad state: Stream has already been listened to" terjadi karena secara default, `StreamController` membuat single-subscription stream yang hanya dapat di-listen oleh satu subscriber pada satu waktu. Ketika kita mencoba membuat `subscription2` dengan memanggil `stream.listen()` untuk kedua kalinya pada stream yang sama, Dart runtime mendeteksi bahwa stream tersebut sudah memiliki listener aktif (yaitu `subscription` yang dibuat sebelumnya) dan melemparkan exception sebagai mekanisme proteksi.

Hal ini merupakan design decision dari Dart untuk mencegah race condition dan memastikan data consistency, karena single-subscription stream dioptimalkan untuk skenario dimana hanya ada satu konsumen yang memproses data secara berurutan. Dalam konteks stream events, setiap event hanya akan dikirimkan ke satu listener, sehingga jika ada multiple listeners, akan timbul ambiguitas tentang siapa yang seharusnya menerima event tersebut. Untuk menangani kebutuhan multiple subscriptions, Dart menyediakan broadcast stream melalui `StreamController.broadcast()` yang secara khusus didesain untuk mendistribusikan event yang sama ke multiple listeners secara concurrent, dengan trade-off bahwa late subscribers tidak akan menerima events yang sudah dipancarkan sebelumnya.

### Lakukan commit dengan pesan "W12: Jawaban Soal 10".

---

## Langkah 4: Set broadcast stream

Ketik kode seperti berikut di method initState()

```dart
  @override
  void initState() {
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream.asBroadcastStream();
    ...
```

## Langkah 5: Edit method build()

Tambahkan text seperti berikut

```dart
            children: [
              Text(lastNumber.toString()),
              ElevatedButton(
                onPressed: () => addRandomNumber(),
                child: const Text('New Random Number'),
              ),
              ElevatedButton(
                onPressed: () => stopStream(),
                child: const Text('Stop Subscription'),
              ),
              Text(values),
            ],
```

## Langkah 6: Run

Tekan button 'New Random Number' beberapa kali, maka akan tampil teks angka terus bertambah sebanyak dua kali.

## Soal 11

### Jelaskan mengapa hal itu bisa terjadi ?

Fenomena munculnya angka dua kali (duplicated) terjadi karena kita menggunakan broadcast stream dengan dua subscription yang berbeda (`subscription` dan `subscription2`) yang keduanya mendengarkan stream yang sama. Ketika method `asBroadcastStream()` dipanggil, stream yang awalnya single-subscription berubah menjadi broadcast stream yang memungkinkan multiple listeners untuk menerima event yang sama secara simultan.

Dalam implementasi ini, `subscription` menerima data yang sudah ditransformasi (dikali 10) dan menampilkannya di `lastNumber`, sedangkan `subscription2` menerima data original (tanpa transformasi) dan menampilkannya dalam string `values`. Setiap kali button 'New Random Number' diklik, satu angka random (0-9) diinjeksikan ke stream, dan karena stream adalah broadcast, event tersebut didistribusikan ke semua listener yang aktif. Hasilnya, kita melihat dua representasi dari angka yang sama: satu dalam bentuk hasil transformasi di `lastNumber` dan satu lagi dalam bentuk akumulasi string di `values`, menciptakan efek "dua kali" yang sebenarnya merupakan dua perspektif berbeda terhadap data yang sama dari dua subscriber yang independen.

### Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

![Broadcast Stream](img/Praktikum5_Multiple%20stream%20subscriptions.gif)

### Lakukan commit dengan pesan "W12: Jawaban Soal 11".

---

# Praktikum 6: StreamBuilder

StreamBuilder adalah sebuah widget untuk melakukan listen terhadap event dari stream. Ketika sebuah event terkirim, maka akan dibangun ulang semua turunannya. Seperti halnya widget FutureBuilder pada pertemuan pekan lalu, StreamBuilder berguna untuk membangun UI secara reaktif yang diperbarui setiap data baru tersedia.

Setelah Anda menyelesaikan praktikum 5, Anda dapat melanjutkan praktikum 6 ini. Selesaikan langkah-langkah praktikum berikut ini menggunakan editor Visual Studio Code (VS Code) atau Android Studio atau code editor lain kesukaan Anda. Jawablah di laporan praktikum Anda pada setiap soal yang ada di beberapa langkah praktikum ini.

## Langkah 1: Buat Project Baru

Buatlah sebuah project flutter baru dengan nama streambuilder_Taufik di folder codelab_week12

## Langkah 2: Buat file baru stream.dart

Ketik kode ini

```dart
import 'dart:math';

class NumberStream {

}
```

## Langkah 3: Tetap di file stream.dart

Ketik kode seperti berikut.

```dart
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      Random random = Random();
      int myNum = random.nextInt(10);
      return myNum;
    });
  }
```

## Langkah 4: Edit main.dart

Ketik kode seperti berikut ini.

```dart
import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

## Langkah 5: Tambah variabel

Di dalam class \_StreamHomePageState, ketikan variabel ini.

```dart
  late Stream<int> numberStream;
```

## Langkah 6: Edit initState()

Ketik kode seperti berikut.

```dart
  @override
  void initState() {
    numberStream = NumberStream().getNumbers();
    super.initState();
  }
```

## Langkah 7: Edit method build()

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: StreamBuilder(
        stream: numberStream,
        initialData: 0,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error!');
          }
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data.toString(),
                style: const TextStyle(fontSize: 96),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
```

## Langkah 8: Run

Hasilnya, setiap detik akan tampil angka baru seperti berikut.

## Soal 12

### Jelaskan maksud kode pada langkah 3 dan 7 !

**Langkah 3 (Method getNumbers):**

Method `getNumbers()` mengembalikan `Stream<int>` yang menghasilkan aliran data berupa angka integer secara asynchronous menggunakan generator function (`async*`). Implementasinya menggunakan `yield*` untuk mendelegasikan seluruh output dari `Stream.periodic()` yang berfungsi membangkitkan event secara berkala setiap 1 detik. Pada setiap interval, callback function menerima parameter `t` (tick counter) yang kemudian diabaikan, dan sebagai gantinya dibuat instance `Random` untuk menghasilkan angka acak antara 0-9 menggunakan `nextInt(10)`. Angka random ini dikembalikan dan menjadi data yang dipancarkan oleh stream. Dengan demikian, stream ini akan terus menghasilkan angka random baru setiap detik tanpa henti, cocok untuk skenario yang membutuhkan data real-time yang berubah secara periodik.

**Langkah 7 (StreamBuilder Widget):**

`StreamBuilder` adalah widget khusus Flutter yang secara otomatis melakukan listening terhadap stream dan merebuild UI setiap kali ada data baru. Widget ini menerima tiga parameter utama: `stream` yang merupakan sumber data (numberStream), `initialData` yang menentukan nilai awal sebelum stream mengirim data pertama (0), dan `builder` yang merupakan callback function untuk membangun widget tree berdasarkan state terkini dari stream. Parameter `snapshot` dalam builder menyimpan informasi lengkap tentang state stream termasuk data, error, dan connection state. Logika builder mengimplementasikan conditional rendering: jika terjadi error (`hasError`), akan print pesan error; jika ada data (`hasData`), menampilkan angka dengan font size 96 di tengah layar; dan jika tidak ada kondisi yang terpenuhi (initial state), menampilkan empty widget (`SizedBox.shrink()`). Pendekatan reactive ini menghilangkan kebutuhan manual subscription management dan setState(), membuat kode lebih deklaratif dan maintainable.

### Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

![StreamBuilder](img/Praktikum6_StreamBuilder.gif)

### Lalu lakukan commit dengan pesan "W12: Jawaban Soal 12".
