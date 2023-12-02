import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../example01/provider/simple_provider01.dart';

class ProviderScreen02 extends ConsumerStatefulWidget {
  const ProviderScreen02({super.key});

  @override
  ProviderScreen02State createState() => ProviderScreen02State();

  //State<ProviderScreen02> createState() => ProviderScreen02State();
}

class ProviderScreen02State extends ConsumerState<ProviderScreen02> {
  @override
  Widget build(BuildContext context) {
    final nameGeneration = ref.watch(randomGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('nameGeneration'),
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
