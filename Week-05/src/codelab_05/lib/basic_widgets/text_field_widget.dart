import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldPageState();
}

class _MyTextFieldPageState extends State<MyTextField> {
  final TextEditingController _controller = TextEditingController();
  String _hasil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contoh TextField')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Nama',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasil = _controller.text;
                });
              },
              child: const Text('Tampilkan'),
            ),
            const SizedBox(height: 16),
            Text(
              _hasil.isEmpty ? 'Belum ada input' : 'Halo, $_hasil!',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
