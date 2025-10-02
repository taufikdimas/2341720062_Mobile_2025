import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Langkah 4: Implementasi title row ---
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32), // padding di sepanjang tepi 32 piksel
      child: Row(
        children: [
          // Soal 1: Column di dalam Expanded + crossAxisAlignment.start
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Soal 2: Baris pertama teks dalam Container dengan bottom padding 8
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Wisata Gunung Kelud',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Kediri, Jawa Timur, Indonesia',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Soal 3: Icon bintang merah + teks "41"
          const Icon(Icons.star, color: Colors.red),
          const Text('41'),
        ],
      ),
    );

    return MaterialApp(
      title: 'Taufik Dimas - 2341720062',
      home: Scaffold(
        appBar: AppBar(title: const Text('Taufik Dimas - 2341720062')),
        // ganti body lama dengan titleSection
        body: titleSection,
      ),
    );
  }
}
