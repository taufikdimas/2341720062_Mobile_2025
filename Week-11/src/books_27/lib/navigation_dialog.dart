import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({super.key});

  @override
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = Colors.indigo.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(title: const Text('Navigation Dialog Screen - Taufik')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Change Color'),
          onPressed: () {
            _showColorDialog(context).then((value) => setState(() {}));
          },
        ),
      ),
    );
  }

  _showColorDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Very important question'),
          content: const Text('Please choose a color'),
          actions: <Widget>[
            TextButton(
              child: const Text('Coral'),
              onPressed: () {
                // Coral - warm, attractive accent
                color = const Color(0xFFFF6B6B);
                Navigator.pop(context, color);
              },
            ),
            TextButton(
              child: const Text('Peach'),
              onPressed: () {
                // Peach - soft warm tone
                color = const Color(0xFFFFA726);
                Navigator.pop(context, color);
              },
            ),
            TextButton(
              child: const Text('Lavender'),
              onPressed: () {
                // Lavender - soft pastel purple
                color = const Color(0xFFB39DDB);
                Navigator.pop(context, color);
              },
            ),
          ],
        );
      },
    );
  }
}
