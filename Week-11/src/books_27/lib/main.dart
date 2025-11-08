import 'package:flutter/material.dart';
import 'geolocation.dart';
import 'dart:async';
// removed package:async; using Future.wait instead of FutureGroup

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
  home: const LocationScreen(),
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

  Future<int> returnFG() async {
    debugPrint('[returnFG] started');
    final futures = await Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);
    final total = futures.fold<int>(0, (prev, el) => prev + el);
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

  Future<int> returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
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
                      if (mounted) {
                        setState(() {
                          isCounting = true;
                          result = '';
                        });
                      }
                      returnError()
                          .then((value) {
                            if (mounted) {
                              setState(() {
                                result = 'Success';
                              });
                            }
                          })
                          .catchError((onError) {
                            if (mounted) {
                              setState(() {
                                result = onError.toString();
                              });
                            }
                          })
                          .whenComplete(() {
                            if (mounted) {
                              setState(() {
                                isCounting = false;
                              });
                            }
                            print('Complete');
                          });
                    },
            ),
            const SizedBox(height: 18),
            Text(' $result', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 18),
            if (isCounting) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
