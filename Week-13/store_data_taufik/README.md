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
