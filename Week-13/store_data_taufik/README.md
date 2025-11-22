# Praktikum 1: Konversi Dart model ke JSON

Nama: Taufik Dimas

NIM: 2341720062

Kelas: TI-3F / 13

---

## Langkah 1: Buat Project Baru

Membuat project Flutter baru dengan nama `store_data_taufik` di folder `Week-13/`.

```bash
flutter create store_data_taufik
```

## Langkah 2: Buka file `main.dart`

Membuka file `lib/main.dart` dan memulai setup aplikasi dasar.

## Langkah 3: Buat folder baru `assets`

Membuat folder baru bernama `assets` di root project untuk menyimpan file JSON.

```
store_data_taufik/
  ├── assets/
  ├── lib/
  └── pubspec.yaml
```

## Langkah 4: Buat file baru `pizzalist.json`

Membuat file `pizzalist.json` di dalam folder `assets/` dengan data pizza:

```json
[
  {
    "id": 1,
    "pizzaName": "Margherita",
    "description": "Pizza with tomato, fresh mozzarella and basil",
    "price": 8.75,
    "imageUrl": "images/margherita.png"
  },
  {
    "id": 2,
    "pizzaName": "Marinara",
    "description": "Pizza with tomato, garlic and oregano",
    "price": 7.5,
    "imageUrl": "images/marinara.png"
  },
  {
    "id": 3,
    "pizzaName": "Napoli",
    "description": "Pizza with tomato, garlic and anchovies",
    "price": 9.5,
    "imageUrl": "images/marinara.png"
  },
  {
    "id": 4,
    "pizzaName": "Carciofi",
    "description": "Pizza with tomato, fresh mozzarella and artichokes",
    "price": 8.8,
    "imageUrl": "images/marinara.png"
  },
  {
    "id": 5,
    "pizzaName": "Bufala",
    "description": "Pizza with tomato, buffalo mozzarella and basil",
    "price": 12.5,
    "imageUrl": "images/marinara.png"
  }
]
```

## Langkah 5: Edit `pubspec.yaml`

Menambahkan referensi folder `assets` ke file `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/pizzalist.json
```

## Langkah 6: Edit `main.dart`

Membuat variabel `pizzaString` di dalam class `_MyHomePageState`:

```dart
class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';
```

## Langkah 7: Tetap di `main.dart`

Menambahkan method `readJsonFile()` untuk membaca file JSON:

```dart
Future<void> readJsonFile() async {
  final String response = await rootBundle.loadString('assets/pizzalist.json');
  setState(() {
    pizzaString = response;
  });
}
```

Import yang diperlukan:

```dart
import 'package:flutter/services.dart';
```

## Langkah 8: Panggil method readJsonFile

Memanggil method `readJsonFile()` di `initState()`:

```dart
@override
void initState() {
  super.initState();
  readJsonFile();
}
```

## Langkah 9: Tampilkan hasil JSON

Menampilkan hasil JSON di body Scaffold:

```dart
body: ListView(
  children: [
    Text(pizzaString),
  ],
),
```

## Langkah 10: Run

Menjalankan aplikasi untuk melihat hasil JSON string yang ditampilkan.

---

## Soal 1

### Screenshot

**Aplikasi setelah menambahkan nama "Taufik" pada title dan mengubah warna tema menjadi biru:**

![Screenshot Soal 1](./screenshots/soal1.png)

### Penjelasan

Pada Soal 1 ini, saya telah:

1. Menambahkan nama panggilan "Taufik" pada title app di `main.dart`:
   ```dart
   title: 'Store Data Taufik',
   home: const MyHomePage(title: 'Store Data Taufik'),
   ```
2. Mengubah warna tema aplikasi dari `deepPurple` menjadi `blue`:
   ```dart
   theme: ThemeData(
     colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
     useMaterial3: true,
   ),
   ```

---

## Soal 2

### Screenshot

**Tampilan JSON String dari file pizzalist.json:**

![Screenshot Soal 2](./screenshots/soal2.png)

### Penjelasan

Pada langkah ini, saya berhasil:

1. Membuat file `pizzalist.json` di folder `assets/`
2. Menambahkan referensi assets di `pubspec.yaml`:
   ```yaml
   assets:
     - assets/pizzalist.json
   ```
3. Membuat method `readJsonFile()` untuk membaca file JSON:
   ```dart
   Future<void> readJsonFile() async {
     final String response = await rootBundle.loadString('assets/pizzalist.json');
     setState(() {
       pizzaString = response;
     });
   }
   ```
4. Menampilkan string JSON mentah di ListView

---

## Langkah 11: Buat file baru `pizza.dart`

Membuat file class baru di folder `lib/model/` dengan nama file `pizza.dart`.

## Langkah 12: Model pizza.dart

Mengetik kode model Pizza di file `pizza.dart`:

```dart
class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
```

## Langkah 13: Buat `constructor()`

Menambahkan constructor `fromJson()` di dalam class `Pizza`:

```dart
factory Pizza.fromJson(Map<String, dynamic> json) {
  return Pizza(
    id: json['id'],
    pizzaName: json['pizzaName'],
    description: json['description'],
    price: json['price'],
    imageUrl: json['imageUrl'],
  );
}
```

## Langkah 14: Pindah ke `class _MyHomePageState`

Menambahkan kode `jsonDecode` di method `readJsonFile()`:

```dart
Future<List<Pizza>> readJsonFile() async {
  final String response = await rootBundle.loadString('assets/pizzalist.json');
  final List<dynamic> decodedList = jsonDecode(response);
  // ... konversi ke Pizza objects
}
```

## Langkah 15: Pastikan impor class

Memastikan import yang diperlukan ada di bagian atas file `main.dart`:

```dart
import 'dart:convert';
import 'model/pizza.dart';
```

## Langkah 16: Konversi List Map ke List Objek Dart

Menambahkan kode untuk mengonversi Map menjadi objek Pizza:

```dart
Future<List<Pizza>> readJsonFile() async {
  final String response = await rootBundle.loadString('assets/pizzalist.json');
  final List<dynamic> decodedList = jsonDecode(response);
  List<Pizza> myPizzas = decodedList
      .map((pizzaJson) => Pizza.fromJson(pizzaJson))
      .toList();
  return myPizzas;
}
```

## Langkah 17: return myPizzas

Menghapus atau mengkomentari `setState` yang menampilkan `pizzaString` dan mengembalikan `myPizzas`:

```dart
return myPizzas;
```

## Langkah 18: Perbarui Signature Method

Memperbarui signature method `readJsonFile()` untuk menunjukkan bahwa ia mengembalikan `Future<List<Pizza>>`:

```dart
Future<List<Pizza>> readJsonFile() async {
  // ...
}
```

## Langkah 19: Deklarasikan Variabel State

Mendeklarasikan variabel state baru untuk menampung List objek Pizza:

```dart
class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];
```

## Langkah 20: Panggil di initState dan Perbarui State

Memperbarui `initState()` untuk memanggil `readJsonFile()` dengan `.then()`:

```dart
@override
void initState() {
  super.initState();
  readJsonFile().then((pizzas) {
    setState(() {
      myPizzas = pizzas;
    });
  });
}
```

## Langkah 21: Tampilkan Data di ListView

Memperbarui body Scaffold dengan `ListView.builder`:

```dart
body: ListView.builder(
  itemCount: myPizzas.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(myPizzas[index].pizzaName),
      subtitle: Text(myPizzas[index].description),
    );
  },
),
```

## Langkah 22: Run

Menjalankan aplikasi. Data pizza sekarang ditampilkan dalam daftar yang terstruktur sebagai objek List Dart.

---

## Soal 3

### Screenshot

**Tampilan List Pizza dengan ListView.builder:**

![Screenshot Soal 3](./screenshots/soal3.png)

### Penjelasan

Pada tahap ini, saya telah berhasil:

1. Membuat model class `Pizza` di `lib/model/pizza.dart` dengan:

   - Properties: `id`, `pizzaName`, `description`, `price`, `imageUrl`
   - Constructor `fromJson()` untuk deserialization
   - Method `toJson()` untuk serialization

2. Mengubah method `readJsonFile()` untuk mengembalikan `Future<List<Pizza>>`:

   ```dart
   Future<List<Pizza>> readJsonFile() async {
     final String response = await rootBundle.loadString('assets/pizzalist.json');
     final List<dynamic> decodedList = jsonDecode(response);
     List<Pizza> myPizzas = decodedList.map((pizzaJson) => Pizza.fromJson(pizzaJson)).toList();
     return myPizzas;
   }
   ```

3. Menampilkan data pizza menggunakan `ListView.builder`:

   ```dart
   body: ListView.builder(
     itemCount: myPizzas.length,
     itemBuilder: (context, index) {
       return ListTile(
         title: Text(myPizzas[index].pizzaName),
         subtitle: Text(myPizzas[index].description),
       );
     },
   ),
   ```

4. Menambahkan function `convertToJSON()` untuk mengubah List objek Pizza kembali menjadi JSON string dan mencetak hasilnya di Debug Console.

---

## Langkah 23: Tambahkan Method toJson() (Serialization)

Menambahkan method `toJson()` ke class `Pizza` di file `pizza.dart`:

```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'pizzaName': pizzaName,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
  };
}
```

## Langkah 24: Buat Fungsi Konversi JSON String

Menambahkan fungsi `convertToJSON()` di dalam `_MyHomePageState`:

```dart
String convertToJSON(List<Pizza> pizzas) {
  return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
}
```

## Langkah 25: Tampilkan Output JSON di Konsol

Menambahkan kode di method `readJsonFile()` untuk memanggil `convertToJSON()` dan mencetak hasilnya:

```dart
@override
void initState() {
  super.initState();
  readJsonFile().then((pizzas) {
    setState(() {
      myPizzas = pizzas;
    });
    String json = convertToJSON(myPizzas);
    print(json);
  });
}
```

## Langkah 26: Cek Output Konsol

Menjalankan aplikasi dan memeriksa Debug Console untuk melihat List objek Pizza telah berhasil dikonversi kembali menjadi JSON String.

**Output di Debug Console:**

```json
[{"id":1,"pizzaName":"Margherita","description":"Pizza with tomato, fresh mozzarella and basil","price":8.75,"imageUrl":"images/margherita.png"},{"id":2,"pizzaName":"Marinara","description":"Pizza with tomato, garlic and oregano","price":7.5,"imageUrl":"images/marinara.png"},...]
```

---

## Kesimpulan

Praktikum 1 ini telah berhasil mendemonstrasikan:

- **Deserialization**: Mengubah JSON string menjadi objek Dart (List<Pizza>)
- **Serialization**: Mengubah objek Dart kembali menjadi JSON string
- Penggunaan `factory constructor` untuk membuat objek dari Map
- Penggunaan `toJson()` method untuk mengkonversi objek ke Map
- Membaca file JSON dari assets menggunakan `rootBundle.loadString()`
- Penggunaan `jsonDecode()` dan `jsonEncode()` dari package `dart:convert`

Dengan memahami konsep konversi data ini, kita dapat dengan mudah bekerja dengan API, menyimpan data dalam format JSON, dan melakukan persistensi data di aplikasi Flutter.

---

## Kode Lengkap

### `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'model/pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Data Taufik',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Store Data Taufik'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];

  Future<List<Pizza>> readJsonFile() async {
    final String response = await rootBundle.loadString(
      'assets/pizzalist.json',
    );
    final List<dynamic> decodedList = jsonDecode(response);
    List<Pizza> myPizzas = decodedList
        .map((pizzaJson) => Pizza.fromJson(pizzaJson))
        .toList();
    return myPizzas;
  }

  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
  }

  @override
  void initState() {
    super.initState();
    readJsonFile().then((pizzas) {
      setState(() {
        myPizzas = pizzas;
      });
      String json = convertToJSON(myPizzas);
      print(json);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myPizzas[index].pizzaName),
            subtitle: Text(myPizzas[index].description),
          );
        },
      ),
    );
  }
}
```

### `lib/model/pizza.dart`

```dart
class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      pizzaName: json['pizzaName'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
```

### `pubspec.yaml` (bagian assets)

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/pizzalist.json
```

---

# Praktikum 2: Handle Kompatibilitas Data JSON

Pada praktikum ini, kita akan menangani masalah kompatibilitas data JSON yang tidak konsisten, seperti tipe data yang berbeda atau nilai null.

## Langkah 1: Simulasikan Error

Mensimulasikan penggunaan data JSON yang tidak konsisten atau "rusak". Praktikum ini mengajarkan cara membuat kode yang lebih robust dalam menangani data yang tidak sempurna.

## Langkah 2: Lihat Error Tipe Data String ke Int

Jika ID pizza di JSON dikirim sebagai String (misalnya `"id": "1"`) sementara model Dart mengharapkan `int`, akan terjadi runtime error karena type mismatch.

**Error yang mungkin terjadi:**

```
type 'String' is not a subtype of type 'int'
```

## Langkah 3: Terapkan tryParse dan Null Coalescing pada ID

Menambahkan `int.tryParse()` dan null coalescing operator (`??`) pada field `id`:

```dart
factory Pizza.fromJson(Map<String, dynamic> json) {
  return Pizza(
    // Gunakan int.tryParse untuk handle String to Int conversion
    id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
    // ... field lainnya
  );
}
```

**Penjelasan:**

- `json['id']?.toString()` - Convert nilai menjadi String (null-safe)
- `?? '0'` - Jika null, gunakan '0' sebagai default
- `int.tryParse()` - Coba parse String ke int, return null jika gagal
- `?? 0` - Jika parsing gagal, gunakan 0 sebagai default

## Langkah 4: Simulasikan Error Null pada String

Jika ada field yang hilang (misalnya `imageUrl` tidak ada dalam JSON), akan terjadi error null reference.

**Error yang mungkin terjadi:**

```
Null check operator used on a null value
```

## Langkah 5: Terapkan Null Coalescing pada String

Menambahkan null coalescing operator (`??`) pada field String untuk memberikan nilai default:

```dart
pizzaName: json['pizzaName'] ?? 'No name',
description: json['description'] ?? '',
imageUrl: json['imageUrl'] ?? '',
```

## Langkah 6: Gunakan toString() untuk Field String

Untuk memastikan semua nilai benar-benar String (bahkan jika dikirim sebagai tipe lain):

```dart
pizzaName: (json['pizzaName'] ?? 'No name').toString(),
description: (json['description'] ?? '').toString(),
imageUrl: (json['imageUrl'] ?? '').toString(),
```

## Langkah 7: Simulasikan Error Tipe Data String ke Double

Jika field `price` dikirim sebagai String (misalnya `"price": "8.75"`), akan terjadi error saat mengonversi String ke double.

**Error yang mungkin terjadi:**

```
type 'String' is not a subtype of type 'double'
```

## Langkah 8: Terapkan double.tryParse

Menggunakan `double.tryParse()` dengan null coalescing untuk field `price`:

```dart
price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
```

## Langkah 9: Run dan Perhatikan Output Null

Setelah implementasi perbaikan tipe data, aplikasi akan berjalan tanpa crash. Namun, mungkin menampilkan nilai default seperti "No name" atau "" untuk field yang missing.

## Langkah 10: Tambahkan Operator Ternary untuk Output User-Friendly

Jika diperlukan, kita bisa menambahkan pengecekan di UI untuk tampilan yang lebih ramah pengguna:

```dart
// Contoh di ListView.builder (opsional)
title: Text(myPizzas[index].pizzaName.isNotEmpty
    ? myPizzas[index].pizzaName
    : 'No name'),
```

## Langkah 11: Run

Menjalankan aplikasi. Data yang tidak konsisten sekarang ditangani dengan baik, tidak ada crash, dan UI tidak menampilkan nilai null yang membingungkan.

---

## Soal 4

### Screenshot

**Aplikasi berjalan dengan baik meskipun data JSON tidak konsisten:**

![Screenshot Soal 4](./screenshots/soal4.png)

### Penjelasan

Pada Praktikum 2 ini, saya telah berhasil:

1. **Menangani Type Casting untuk ID:**

   - Menggunakan `int.tryParse()` untuk mengkonversi berbagai tipe data ke `int`
   - Menambahkan null coalescing (`??`) untuk memberikan nilai default `0`

2. **Menangani Null pada String:**

   - Menambahkan null coalescing untuk `pizzaName`, `description`, dan `imageUrl`
   - Memberikan nilai default yang sesuai ('No name' untuk nama, '' untuk string kosong)

3. **Menangani Type Casting untuk Price:**

   - Menggunakan `double.tryParse()` untuk mengkonversi String/int ke `double`
   - Menambahkan default value `0` jika parsing gagal

4. **Menggunakan toString():**
   - Memastikan semua field String benar-benar bertipe String
   - Mencegah error jika JSON mengirim tipe data yang tidak sesuai

### Kode Lengkap Pizza Model (Praktikum 2)

```dart
factory Pizza.fromJson(Map<String, dynamic> json) {
  return Pizza(
    id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
    pizzaName: (json['pizzaName'] ?? 'No name').toString(),
    description: (json['description'] ?? '').toString(),
    price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
    imageUrl: (json['imageUrl'] ?? '').toString(),
  );
}
```

**Manfaat:**

- ✅ Aplikasi tidak crash meskipun data JSON rusak atau tidak konsisten
- ✅ Tipe data yang berbeda dapat di-handle dengan baik
- ✅ Nilai null ditangani dengan memberikan default value
- ✅ Kode lebih robust dan production-ready

---

## Kesimpulan Praktikum 1 & 2

Dari kedua praktikum ini, kita telah mempelajari:

### Praktikum 1:

- Deserialization JSON ke objek Dart
- Serialization objek Dart ke JSON
- Penggunaan `factory constructor` dan `toJson()` method
- Bekerja dengan assets dan `rootBundle`

### Praktikum 2:

- Menangani data JSON yang tidak konsisten
- Type casting dengan `tryParse()` methods
- Null safety dengan null coalescing operator (`??`)
- Defensive programming untuk production-ready code

Kombinasi kedua praktikum ini memberikan fondasi yang kuat untuk bekerja dengan API dan data persistence di aplikasi Flutter yang real-world.

---

# Praktikum 3: Menangani Error JSON

Pada praktikum ini, kita akan fokus pada **catching common JSON errors** dengan mengganti string literals (nama kunci JSON) menjadi konstanta untuk menghindari error yang sulit di-debug (kesalahan pengetikan/typo).

## Langkah 1: Buka `pizza.dart` dan Buat Konstanta

Membuat konstanta untuk setiap kunci JSON di bagian atas file `pizza.dart`, di luar class Pizza.

```dart
// Praktikum 3 - Langkah 1: Deklarasi konstanta untuk kunci JSON
const String keyId = 'id';
const String keyName = 'pizzaName';
const String keyDescription = 'description';
const String keyPrice = 'price';
const String keyImage = 'imageUrl';
```

**Tujuan:**

- Menghindari typo saat menulis nama kunci JSON
- Jika ada perubahan struktur JSON, cukup ubah di satu tempat
- Lebih mudah di-maintain dan di-refactor

## Langkah 2: Perbarui fromJson() menggunakan Konstanta

Mengganti semua string literal kunci JSON (misalnya `'id'`) dengan konstanta yang sesuai (`keyId`).

**Sebelum (Praktikum 1 & 2):**

```dart
factory Pizza.fromJson(Map<String, dynamic> json) {
  return Pizza(
    id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
    pizzaName: json['pizzaName']?.toString() ?? 'No name',
    description: json['description']?.toString() ?? '',
    // ... dst
  );
}
```

**Sesudah (Praktikum 3):**

```dart
factory Pizza.fromJson(Map<String, dynamic> json) {
  return Pizza(
    id: json[keyId] is int ? json[keyId] : int.parse(json[keyId].toString()),
    pizzaName: json[keyName]?.toString() ?? 'No name',
    description: json[keyDescription]?.toString() ?? '',
    price: json[keyPrice] is double
        ? json[keyPrice]
        : double.parse(json[keyPrice].toString()),
    imageUrl: json[keyImage]?.toString() ?? '',
  );
}
```

## Langkah 3: Perbarui toJson() menggunakan Konstanta

Memperbarui method `toJson()` agar menggunakan konstanta yang sama.

**Sebelum:**

```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'pizzaName': pizzaName,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
  };
}
```

**Sesudah:**

```dart
Map<String, dynamic> toJson() {
  return {
    keyId: id,
    keyName: pizzaName,
    keyDescription: description,
    keyPrice: price,
    keyImage: imageUrl,
  };
}
```

## Langkah 4: Run

Menjalankan aplikasi. Tidak akan ada perubahan visual, tetapi kode kini lebih safe dan maintainable.

---

## Soal 5

### Screenshot

**Aplikasi berjalan normal dengan konstanta JSON keys:**

![Screenshot Soal 5](./screenshots/soal5.png)

### Penjelasan: Maksud Kode Lebih Safe dan Maintainable

Dengan menggunakan konstanta untuk kunci JSON, kode menjadi **lebih safe dan maintainable** karena:

#### 1. **Menghindari Typo (Type Safety)**

- ❌ **Sebelum:** `json['pizzaName']` vs `json['pizaName']` (typo!)
- ✅ **Sesudah:** `json[keyName]` - jika salah ketik, IDE akan error
- Compiler akan mendeteksi kesalahan saat compile time, bukan runtime

#### 2. **Single Source of Truth**

- Jika struktur JSON berubah dari `"pizzaName"` menjadi `"name"`:
  - ❌ **Sebelum:** Harus cari dan ganti di **semua tempat** (fromJson, toJson, dll)
  - ✅ **Sesudah:** Cukup ubah **satu konstanta** saja:
    ```dart
    const String keyName = 'name'; // cukup ubah di sini
    ```

#### 3. **Autocomplete & Refactoring**

- IDE dapat memberikan autocomplete untuk konstanta
- Fitur "Find Usages" dan "Rename" bekerja dengan baik
- Mudah melacak penggunaan kunci tertentu di seluruh kode

#### 4. **Dokumentasi yang Lebih Baik**

- Konstanta dapat diberi komentar untuk menjelaskan maksudnya
- Lebih mudah dipahami oleh developer lain

#### 5. **Konsistensi**

- Memastikan kunci yang sama digunakan di `fromJson()` dan `toJson()`
- Mengurangi kemungkinan ketidakkonsistenan data

### Contoh Masalah yang Dihindari

**Tanpa konstanta:**

```dart
// Di fromJson
id: json['id']  // ✅ benar

// Di toJson
'idd': id  // ❌ typo! runtime error yang susah di-debug
```

**Dengan konstanta:**

```dart
// Di fromJson
id: json[keyId]  // ✅

// Di toJson
keyId: id  // ✅ jika typo, compile error langsung terdeteksi
```

### Manfaat di Production

- ✅ **Lebih mudah di-maintain** saat project berkembang
- ✅ **Mengurangi bug** akibat typo
- ✅ **Mempercepat development** dengan autocomplete
- ✅ **Memudahkan refactoring** saat API berubah
- ✅ **Code review lebih mudah** karena lebih konsisten

---

## Kesimpulan Praktikum 1, 2 & 3

Dari ketiga praktikum ini, kita telah mempelajari:

### Praktikum 1:

- Deserialization JSON ke objek Dart
- Serialization objek Dart ke JSON
- Penggunaan `factory constructor` dan `toJson()` method
- Bekerja dengan assets dan `rootBundle`

### Praktikum 2:

- Menangani data JSON yang tidak konsisten
- Type casting dengan `tryParse()` methods
- Null safety dengan null coalescing operator (`??`)
- Defensive programming untuk production-ready code

### Praktikum 3:

- Menggunakan konstanta untuk kunci JSON
- Menghindari error typo pada string literals
- Meningkatkan maintainability dan code quality
- Single source of truth untuk struktur JSON

**Best Practice:** Kombinasi ketiga praktikum ini memberikan fondasi yang kuat untuk bekerja dengan API dan data persistence di aplikasi Flutter production-ready yang robust, safe, dan mudah di-maintain.
