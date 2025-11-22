// ========================
// PRAKTIKUM 1: Konversi Dart model ke JSON
// PRAKTIKUM 2: Handle kompatibilitas data JSON
// PRAKTIKUM 3: Menangani error JSON dengan konstanta
// PRAKTIKUM 4: SharedPreferences - Menyimpan data sederhana
// PRAKTIKUM 5: Akses filesystem dengan path_provider
// ========================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'model/pizza.dart';
// Praktikum 4 - Langkah 3: Import shared_preferences
import 'package:shared_preferences/shared_preferences.dart';
// Praktikum 5 - Langkah 2: Import path_provider
import 'package:path_provider/path_provider.dart';

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
  // Praktikum 1: State variable untuk menyimpan list Pizza objects
  List<Pizza> myPizzas = [];

  // Praktikum 4 - Langkah 4: Variabel untuk menyimpan counter app
  int appCounter = 0;

  // Praktikum 5 - Langkah 3: Variabel untuk menyimpan path direktori
  String documentsPath = 'Unknown';
  String tempPath = 'Unknown';

  // Praktikum 1: Method untuk membaca dan decode JSON file
  // Praktikum 2: Sudah dapat handle data JSON yang tidak konsisten
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

  // Praktikum 1: Method untuk convert List<Pizza> kembali ke JSON string
  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
  }

  // Praktikum 4 - Langkah 5-9: Method untuk membaca dan menulis ke SharedPreferences
  Future<void> readAndWritePreference() async {
    // Langkah 6: Dapatkan instance SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Langkah 7: Baca nilai appCounter, gunakan null coalescing untuk default 0
    appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;

    // Langkah 8: Simpan nilai baru ke storage
    await prefs.setInt('appCounter', appCounter);

    // Langkah 9: Update UI dengan setState
    setState(() {
      appCounter = appCounter;
    });
  }

  // Praktikum 4 - Langkah 13: Method untuk menghapus data preferences
  Future<void> deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  // Praktikum 5 - Langkah 4: Method untuk mendapatkan path direktori
  Future getPaths() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      documentsPath = documentsDir.path;
      tempPath = tempDir.path;
    });
  }

  // Praktikum 5 - Langkah 5: Initialize state dan panggil getPaths
  @override
  void initState() {
    super.initState();
    getPaths();

    // Praktikum 1: Membaca file JSON dan update state (di-comment untuk Praktikum 5)
    // readJsonFile().then((pizzas) {
    //   setState(() {
    //     myPizzas = pizzas;
    //   });
    //   // Praktikum 1: Convert kembali ke JSON dan print ke console
    //   String json = convertToJSON(myPizzas);
    //   print(json);
    // });

    // Praktikum 4 - Langkah 10: Panggil readAndWritePreference (di-comment untuk Praktikum 5)
    // readAndWritePreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Praktikum 5 - Langkah 6: Tampilan path direktori
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Doc path: $documentsPath'),
          Text('Temp path $tempPath'),
        ],
      ),

      // Praktikum 4: Counter dan tombol reset (di-comment untuk Praktikum 5)
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Text(
      //         'You have opened the app $appCounter times.',
      //         style: const TextStyle(fontSize: 20),
      //       ),
      //       ElevatedButton(
      //         onPressed: deletePreference,
      //         child: const Text('Reset counter'),
      //       ),
      //     ],
      //   ),
      // ),

      // Praktikum 1-3: ListView pizza (di-comment untuk Praktikum 4)
      // body: ListView.builder(
      //   itemCount: myPizzas.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(myPizzas[index].pizzaName),
      //       subtitle: Text(myPizzas[index].description),
      //     );
      //   },
      // ),
    );
  }
}
