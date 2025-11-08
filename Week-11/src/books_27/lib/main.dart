import 'package:flutter/material.dart';
import 'dart:async';
import 'package:async/async.dart';

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

  Future returnFG() async {
    debugPrint('[returnFG] started');
    FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();
    final futures = await futureGroup.future;
    int total = 0;
    for (var num in futures) {
      total += num;
    }
    debugPrint('[returnFG] completed total=$total');
    return total;
  }

  // Added missing async-returning helper methods
  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 1));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 2));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
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
                  : () async {
                      debugPrint('[button] pressed');
                      if (mounted) {
                        setState(() {
                          isCounting = true;
                          result = '';
                        });
                      }
                      try {
                        final total = await returnFG();
                        debugPrint('[button] returnFG returned $total');
                        if (mounted) {
                          setState(() {
                            result = total.toString();
                          });
                        }
                      } catch (e) {
                        debugPrint('[button] error: $e');
                        if (mounted) {
                          setState(() {
                            result = 'Error: $e';
                          });
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            isCounting = false;
                          });
                        }
                      }
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
