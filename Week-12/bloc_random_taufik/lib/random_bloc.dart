import 'dart:async';
import 'dart:math';

/// BLoC that exposes a stream of random integers between 0-9.
class RandomNumberBloc {
  final _random = Random();

  final _randomNumberController = StreamController<int>();
  Stream<int> get randomNumbers => _randomNumberController.stream;

  final _generatorController = StreamController<void>();
  Sink<void> get generate => _generatorController.sink;

  RandomNumberBloc() {
    _generatorController.stream.listen((_) {
      final number = _random.nextInt(10);
      _randomNumberController.sink.add(number);
    });
  }

  void dispose() {
    _generatorController.close();
    _randomNumberController.close();
  }
}
