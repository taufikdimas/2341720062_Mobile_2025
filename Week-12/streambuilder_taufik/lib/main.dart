import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Taufik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          secondary: Colors.pink,
          tertiary: Colors.orange,
        ),
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  int lastNumber = 0;
  late StreamController<int> numberStreamController;
  late NumberStream numberStream;
  late StreamTransformer<int, int> transformer;
  late StreamSubscription<int> subscription;

  @override
  void initState() {
    super.initState();
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;

    transformer = StreamTransformer<int, int>.fromHandlers(
      handleData: (value, sink) {
        // Pastikan nilai tetap berada pada rentang 1-90.
        sink.add(value.clamp(1, 90));
      },
      handleError: (error, trace, sink) {
        sink.add(-1);
      },
      handleDone: (sink) => sink.close(),
    );

    final stream = numberStreamController.stream;
    subscription = stream.transform(transformer).listen((event) {
      setState(() {
        lastNumber = event;
      });
    });

    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });

    subscription.onDone(() {
      // Log to console when the stream finishes as per the codelab instruction.
      print('OnDone was called');
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    if (!numberStreamController.isClosed) {
      numberStreamController.close();
    }
    super.dispose();
  }

  void addRandomNumber() {
    final random = Random();
    final myNum = random.nextInt(90) + 1;
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
  }

  void stopStream() {
    if (!numberStreamController.isClosed) {
      numberStreamController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream Taufik')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              lastNumber.toString(),
              style: Theme.of(context).textTheme.displayLarge ??
                  const TextStyle(fontSize: 96),
            ),
            ElevatedButton(
              onPressed: addRandomNumber,
              child: const Text('New Random Number'),
            ),
            ElevatedButton(
              onPressed: stopStream,
              child: const Text('Stop Subscription'),
            ),
          ],
        ),
      ),
    );
  }
}
