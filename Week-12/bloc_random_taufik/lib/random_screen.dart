import 'package:flutter/material.dart';

import 'random_bloc.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  late final RandomNumberBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = RandomNumberBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random BLoC'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _bloc.randomNumbers,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Terjadi kesalahan: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const Text('Tekan tombol untuk angka acak');
            }

            return Text(
              snapshot.data.toString(),
              style: Theme.of(context).textTheme.displayLarge,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.generate.add(null),
        child: const Icon(Icons.casino),
      ),
    );
  }
}
