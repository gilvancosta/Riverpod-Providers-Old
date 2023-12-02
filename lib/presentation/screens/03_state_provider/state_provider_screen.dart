/* import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/state_providers.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter1 = ref.watch(countProvider1);
    final counter2 = ref.watch(countProvider2);

    final isDarkMode = ref.watch(isDarkModeProvider);
    final randomName = ref.watch(randomNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
          child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          IconButton(
            // icon: const Icon( Icons.light_mode_outlined, size: 100 ),
            icon: isDarkMode
                ? const Icon(Icons.dark_mode_outlined, size: 100)
                : const Icon(Icons.light_mode_outlined, size: 100),
            onPressed: () {
              ref
                  .read(isDarkModeProvider.notifier)
                  .update((state) => !isDarkMode);
            },
          ),
          Text(randomName, style: const TextStyle(fontSize: 25)),
          TextButton.icon(
            icon: const Icon(
              Icons.add,
              size: 50,
            ),
            label: Text('$counter2', style: const TextStyle(fontSize: 100)),
            onPressed: () {
              ref.read(countProvider2.notifier).update((state) => state + 1);
            },
          ),
          const Spacer(flex: 2),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nombre aleatorio'),
        icon: const Icon(Icons.refresh_rounded),
        onPressed: () {
          ref.invalidate(randomNameProvider);
        },
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider.autoDispose((ref) => 0);

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter value: '),
            Consumer(
              builder: (contexto, refLocal, _) {
                final conter = refLocal.watch(counterProvider);
                return Text('$conter');
              },
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
