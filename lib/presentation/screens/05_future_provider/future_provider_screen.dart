import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/future_providers.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNameAsync = ref.watch(pokemonNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
          child: pokemonNameAsync.when(
        data: (data) => Text(data, style: const TextStyle(fontSize: 30)),
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator(),
      )),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn-4',
        child: const Icon(Icons.refresh),
        onPressed: () {
          ref.read(pokemonIdProvider.notifier).update((state) => state + 1);
        },
      ),

/*       floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'btn-2',
                child: const Icon(Icons.add),
                onPressed: () {
                   ref.read(pokemonIdProvider.notifier).nextPokemon();
                },
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'btn-3',
                child: const Icon(Icons.remove),
                onPressed: () {
                  ref.read(pokemonIdProvider.notifier).prevPokemon();
                },
              ),
            ],
          ),
        ],
      ), */
    );
  }
}
