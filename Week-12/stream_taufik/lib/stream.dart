import 'dart:math';

class NumberStream {
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      final random = Random();
      final myNum = random.nextInt(10);
      return myNum;
    });
  }
}
