import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final String name;
  final String nim;
  const AppFooter({super.key, required this.name, required this.nim});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 1),
        const SizedBox(height: 8),
        Text('$name - $nim', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
      ],
    );
  }
}
