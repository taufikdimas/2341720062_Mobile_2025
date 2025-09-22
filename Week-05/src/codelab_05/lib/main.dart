import 'package:flutter/material.dart';
import 'basic_widgets/date_time_pickers.dart'; // import halaman date picker

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contoh Date Picker',
      home: MyHomePage(
        title: 'Contoh Date Picker',
      ), // panggil widget dari file lain
    );
  }
}
