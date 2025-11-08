import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    Color color;
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Second Screen - Taufik')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Lavender'),
              onPressed: () {
                // Lavender (soft purple)
                color = Colors.purple.shade200;
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Peach'),
              onPressed: () {
                // Peach (soft orange/pink)
                color = Colors.orange.shade200;
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Rose'),
              onPressed: () {
                // Rose (soft pink)
                color = Colors.pink.shade300;
                Navigator.pop(context, color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
