import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../05_future_provider/provider/future_providers.dart';

class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  FamilyFutureScreenState createState() => FamilyFutureScreenState();
}

class FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {
  //var pokemonId01 = 0;
  @override
  Widget build(BuildContext context) {
    final pokemonId02 = ref.watch(pokemonIdStateNotifierProvider);
    final pokemonNameAsync = ref.watch(pokemonProvider(pokemonId02));

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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'btn-3',
                child: const Icon(Icons.remove),
                onPressed: () {
                  ref
                      .read(pokemonIdStateNotifierProvider.notifier)
                      .prevPokemon();

                  //  setState(() { pokemonId01--; });
                },
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'btn-2',
                child: const Icon(Icons.add),
                onPressed: () {
                  //  setState(() { pokemonId01++; });

                  ref
                      .read(pokemonIdStateNotifierProvider.notifier)
                      .nextPokemon();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
