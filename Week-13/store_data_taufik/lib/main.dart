// ========================
// PRAKTIKUM 1: Konversi Dart model ke JSON
// PRAKTIKUM 2: Handle kompatibilitas data JSON
// ========================

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
  // Praktikum 1: State variable untuk menyimpan list Pizza objects
  List<Pizza> myPizzas = [];

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

  // Praktikum 1: Initialize state saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    // Praktikum 1: Membaca file JSON dan update state
    readJsonFile().then((pizzas) {
      setState(() {
        myPizzas = pizzas;
      });
      // Praktikum 1: Convert kembali ke JSON dan print ke console
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
      // Praktikum 1 & 2: Menampilkan list pizza dengan ListView.builder
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            // Praktikum 2: pizzaName dan description sudah di-handle untuk null safety
            title: Text(myPizzas[index].pizzaName),
            subtitle: Text(myPizzas[index].description),
          );
        },
      ),
    );
  }
}
