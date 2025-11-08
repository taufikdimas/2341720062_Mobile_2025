import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taufik Dimas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  bool isCounting = false;

  // Completer example (getNumber)
  late Completer<int> completer;

  Future<int> getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future<void> calculate() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    } catch (e) {
      completer.completeError(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // Do not start any process automatically for the practicum: run when user presses the button
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back from the Future - Taufik')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: isCounting
                  ? null
                  : () {
                      getNumber()
                          .then((value) {
                            setState(() {
                              result = value.toString();
                            });
                          })
                          .catchError((e) {
                            result = 'An error occurred';
                          });
                    },
            ),
            const SizedBox(height: 24),
            Text(' $result', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            if (isCounting) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
