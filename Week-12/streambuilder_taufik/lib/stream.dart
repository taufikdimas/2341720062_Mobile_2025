import 'dart:async';

class NumberStream {
  const NumberStream();

  Stream<int> generateNumbers({Duration interval = const Duration(seconds: 1)}) {
    return Stream.periodic(interval, (count) => count);
  }
}
