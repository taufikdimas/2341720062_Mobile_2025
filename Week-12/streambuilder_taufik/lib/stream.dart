import 'dart:async';

import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    // Soal 2 colors
    Colors.pink,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.indigo,
  ];

  Stream<Color> getColors() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1),
      (int t) {
        final index = t % colors.length;
        return colors[index];
      },
    );
  }
}

class NumberStream {
  final StreamController<int> controller = StreamController<int>();

  void addNumberToSink(int newNumber) {
    controller.sink.add(newNumber);
  }

  void addError() {
    controller.sink.addError('error');
  }

  void close() {
    controller.close();
  }
}
