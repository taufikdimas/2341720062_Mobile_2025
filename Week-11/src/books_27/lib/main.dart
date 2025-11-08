import 'package:flutter/material.dart';
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

  // Future<http.Response> getData() async {
  //   const authority = 'www.googleapis.com';
  //   const path = '/books/v1/volumes/Q5mJEAAAQBAJ';
  //   Uri url = Uri.https(authority, path);
  //   return http.get(url);
  // }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future<void> count() async {
    if (isCounting) return;
    setState(() => isCounting = true);
    try {
      debugPrint('count() started');
      int total = 0;
      total = await returnOneAsync();
      debugPrint('after returnOneAsync: $total');
      total += await returnTwoAsync();
      debugPrint('after returnTwoAsync: $total');
      total += await returnThreeAsync();
      debugPrint('after returnThreeAsync: $total');
      setState(() {
        result = total.toString();
      });
      debugPrint('count() finished with total: $total');
    } finally {
      if (mounted) {
        setState(() => isCounting = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Mulai proses otomatis saat halaman dibuka
    count();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back from the Future - Taufik')),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: isCounting
                  ? null
                  : () {
                      debugPrint('button pressed');
                      count();
                    },
            ),
            const Spacer(),
            Text(result),
            const Spacer(),
            if (isCounting) const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
