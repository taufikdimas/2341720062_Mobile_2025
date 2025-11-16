import 'package:flutter/material.dart';
import 'stream.dart';

void main() {
  runApp(const StreamBuilderApp());
}

class StreamBuilderApp extends StatelessWidget {
  const StreamBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamBuilder Taufik',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const StreamHomePage(title: 'StreamBuilder Taufik'),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key, required this.title});

  final String title;

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  final NumberStream _numberStream = const NumberStream();
  late final Stream<int> _numbers;

  @override
  void initState() {
    super.initState();
    _numbers = _numberStream.generateNumbers();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _numbers,
          builder: (context, snapshot) {
            final statusText = _describeConnection(snapshot.connectionState);

            if (snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Terjadi kesalahan pada stream', style: textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Text('${snapshot.error}', textAlign: TextAlign.center),
                ],
              );
            }

            final displayedValue = snapshot.hasData
                ? snapshot.data!.toString().padLeft(2, '0')
                : '--';

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(statusText, style: textTheme.titleMedium),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: Text(
                    displayedValue,
                    key: ValueKey(displayedValue),
                    style: textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Angka baru dikirim setiap detik melalui StreamBuilder.',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _describeConnection(ConnectionState state) {
    switch (state) {
      case ConnectionState.none:
        return 'Stream belum dimulai';
      case ConnectionState.waiting:
        return 'Menunggu angka pertama...';
      case ConnectionState.active:
        return 'Stream sedang berjalan';
      case ConnectionState.done:
        return 'Stream selesai';
    }
  }
}
