import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/simple_provider01.dart';


class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameGeneration = ref.watch(randomGeneratorProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: Text(nameGeneration,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(randomGeneratorProvider);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
